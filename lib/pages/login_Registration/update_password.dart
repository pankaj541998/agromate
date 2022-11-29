import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/custom_Elevated_Button.dart';
import 'package:flutter_agro_new/component/text_input_field.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../component/services/auth_api.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({Key? key, this.email}) : super(key: key);

  final String? email;

  @override
  State<UpdatePassword> createState() => UpdatePasswordState();
}

class UpdatePasswordState extends State<UpdatePassword> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  bool success = false;

  Future<void> updatePasword() async {
    Map<String, dynamic> updata = {
      "email": widget.email,
      "password": passwordcontroller.text,
    };

    http.Response response = await AuthServices.updatePassword(updata);
    Map responseMap = jsonDecode(response.body);
    if (response.statusCode == 200) {
      AuthServices.updatePassword(updata);
      Get.toNamed('/login');
    } else {
      Flushbar(
        message: responseMap.values.first,
        duration: const Duration(seconds: 3),
      ).show(context);
    }
  }

  void _validateData() {
    final isValid = _updatepassword.currentState?.validate();
    if (isValid!) {
      updatePasword();
    } else {
      Flushbar(
        message: "Password not matched",
        duration: const Duration(seconds: 3),
      ).show(context);
    }
  }

  final _updatepassword = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFF7F9EA),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Form(
                  key: _updatepassword,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Update Password",
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const SizedBox(
                        width: 500,
                        // ignore: unnecessary_const
                        child: const Divider(
                          thickness: 2,
                          color: Color(0xFF327C04),
                          endIndent: 280,
                          indent: 0,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Reset password with agromate",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF505050)),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextInputField(
                        isInputPassword: true,
                        leadingIcon: Image.asset("assets/images/password.png"),
                        hintText: "New Password",
                        validatorText: "validatorText",
                        textEditingController: passwordcontroller,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FlutterPwValidator(
                        controller: passwordcontroller,
                        minLength: 6,
                        uppercaseCharCount: 1,
                        numericCharCount: 1,
                        specialCharCount: 1,
                        normalCharCount: 1,
                        width: 500,
                        height: 215,
                        onSuccess: () {
                          setState(() {
                            success = true;
                          });
                          print("MATCHED");
                        },
                        onFail: () {
                          setState(() {
                            success = false;
                          });
                          print("NOT MATCHED");
                        },
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      TextInputField(
                        isInputPassword: true,
                        leadingIcon: Image.asset("assets/images/password.png"),
                        hintText: "Confirm New Password",
                        validatorText: "",
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return "Password cannot be empty";
                          } else if (value != null && value.length < 6) {
                            return "Password length should be atleast 6";
                          } else if (value != passwordcontroller.text) {
                            return "Password Not Matched";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 50,
                        width: 500,
                        child: CustomElevatedButton(
                          title: "Update Password",
                          onPressed: () {
                            _validateData();
                          },
                        ),
                      ),
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
