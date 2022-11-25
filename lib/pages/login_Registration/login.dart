import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/custom_Elevated_Button.dart';
import 'package:flutter_agro_new/component/text_Input_field.dart';
import 'package:flutter_agro_new/pages/login_Registration/forgot_Password.dart';
import 'package:flutter_agro_new/component/services/auth_api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../component/services/test_api.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool check = false;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final username = TextEditingController();
  final password = TextEditingController();

  loginPressed() async {
    var data = {
      'user_name': username.text,
      'password': password.text,
    };
    final isValid = _form.currentState?.validate();
    if (isValid!) {
      http.Response response = await AuthServices.login(data);
      final responseMap = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Get.toNamed('/dashboard');
      } else {
        Flushbar(
          duration: const Duration(seconds: 2),
          message: responseMap.values.first,
        ).show(context);
      }
    } else {
      Flushbar(
        duration: const Duration(seconds: 2),
        message: "Please Enter Username And Password",
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFF7F9EA),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Form(
                  key: _form,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      TextInputField(
                        leadingIcon: Image.asset(
                          "assets/images/username.png",
                          height: 30,
                          width: 30,
                        ),
                        textEditingController: username,
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return "Please Enter Username";
                          }
                          return null;
                        },
                        hintText: 'Username',
                        validatorText: 'Please Enter Username',
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextInputField(
                          leadingIcon: Image.asset(
                            "assets/images/password.png",
                            height: 30,
                            width: 30,
                          ),
                          textEditingController: password,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return "Password cannot be empty";
                            } else if (value != null && value.length < 6) {
                              return "Password length should be atleast 6";
                            }
                            return null;
                          },
                          isInputPassword: true,
                          hintText: 'Password',
                          validatorText: 'Please Enter Password'),
                      const SizedBox(
                        height: 19,
                      ),
                      SizedBox(
                        width: 500,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Theme(
                                  data: ThemeData(
                                      unselectedWidgetColor:
                                          const Color(0xFF4E944F)),
                                  child: Checkbox(
                                    activeColor: const Color(0xFF4E944F),
                                    checkColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5.0))),
                                    value: check,
                                    onChanged: (value) {
                                      setState(() {
                                        check = value!;
                                      });
                                    },
                                  ),
                                ),
                                const Text(
                                  "Remember Me",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(width: 10),
                            TextButton(
                              onPressed: () {
                                Get.toNamed('/forgotPassword');
                              },
                              Widget: const Text(
                                "Forgot Password ?",
                                style: TextStyle(
                                    color: Color(0xFF327C04), fontSize: 15),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 51,
                      ),
                      SizedBox(
                          height: 50,
                          width: 500,
                          child: CustomElevatedButton(
                            title: 'Log in',
                            onPressed: () {
                              loginPressed();
                              // Get.toNamed('/dashboard');
                            },
                          ))
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Image.asset(
                "assets/images/agromatelogonew.png",
                height: 235,
                width: 293,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
