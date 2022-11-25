import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../component/custom_Elevated_Button.dart';
import '../../component/text_Input_field.dart';
import '../../component/services/register_api.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final username = TextEditingController();
  final email = TextEditingController();
  final phonenumber = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  registermethod() async {
    var data = {
      "firstname": firstname.text,
      "lastname": lastname.text,
      "username": username.text,
      "email": email.text,
      "contact_number": phonenumber.text,
    };
    final isValid = _form.currentState?.validate();
    if (isValid!) {
      http.Response response = await Registerapi().editDataByUsername(data);

      final responseMap = jsonDecode(response.body);
      if (response.statusCode == 202) {
        Get.toNamed('/thankyou');
      } else {
        Flushbar(
          duration: const Duration(seconds: 2),
          message: responseMap.values.first,
        ).show(context);
      }
    } else {
      Flushbar(
        duration: const Duration(seconds: 2),
        message: "Please Enter all the details",
      ).show(context);
    }
  }
  // void uploadData() {
  //   Map<String, dynamic> updata = {
  //     "firstname": firstname.text,
  //     "lastname": lastname.text,
  //     "username": username.text,
  //     "email": email.text,
  //     "contact_number": phonenumber.text,
  //   };

  //   registerapi().editDataByUsername(updata);
  //   debugPrint(updata.toString());
  // }

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
                        "Register",
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 500,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 235,
                              child: TextInputField(
                                textEditingController: firstname,
                                leadingIcon: const Icon(
                                  Icons.person_outline_rounded,
                                  color: Color(0xFF327C04),
                                ),
                                validator: (value) {
                                  if (value != null && value.isEmpty) {
                                    return "Please Enter First Name";
                                  }
                                  return null;
                                },
                                hintText: 'First Name',
                                validatorText: 'Please Enter First Name',
                              ),
                            ),
                            SizedBox(
                              width: 235,
                              child: TextInputField(
                                textEditingController: lastname,
                                leadingIcon: const Icon(
                                  Icons.person_outline_rounded,
                                  color: Color(0xFF327C04),
                                ),
                                validator: (value) {
                                  if (value != null && value.isEmpty) {
                                    return "Please Enter Last Name";
                                  }
                                  return null;
                                },
                                hintText: 'Last Name',
                                validatorText: 'Please Enter Last Name',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextInputField(
                        textEditingController: username,
                        leadingIcon: const Icon(Icons.person_outline_outlined),
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
                        height: 20,
                      ),
                      TextInputField(
                          textEditingController: email,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !value.contains('@') ||
                                !value.contains('.')) {
                              return "Please Enter Valid Email Address";
                            }
                            return null;
                          },
                          hintText: 'Email address',
                          validatorText: 'Please Enter Email address'),
                      const SizedBox(
                        height: 20,
                      ),
                      TextInputField(
                          leadingIcon: Image.asset(""),
                          textEditingController: phonenumber,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Phone Number";
                            } else if (value.length != 10) {
                              return "Please Enter Valid Phone Number";
                            }
                            return null;
                          },
                          hintText: 'Phone Number',
                          validatorText: 'Please Enter Phone Number'),
                      const SizedBox(
                        height: 20,
                      ),
                      const TextInputField(
                        leadingIcon: Icon(Icons.abc),
                        hintText: 'Role',
                        validatorText: '',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                          height: 50,
                          width: 500,
                          child: CustomElevatedButton(
                            title: 'Register',
                            onPressed: () {
                              registermethod();
                              // uploadData();
                              //Get.toNamed('/thankyou');
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
