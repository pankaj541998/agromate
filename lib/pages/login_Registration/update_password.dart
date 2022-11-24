import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_agro_new/component/custom_Elevated_Button.dart';
import 'package:flutter_agro_new/component/text_Input_field.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../services/auth_api.dart';

class updatePassword extends StatefulWidget {
  const updatePassword({Key? key, this.email}) : super(key: key);

  final String? email;

  @override
  State<updatePassword> createState() => _updatePasswordState();
}

class _updatePasswordState extends State<updatePassword> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  bool success = false;

  Future<void> updatePasword() async {
    Map<String, dynamic> updata = {
      "email": widget.email,
      "password": passwordcontroller.text,
    };

    http.Response response = await AuthServices.changePassword(updata);
    Map responseMap = jsonDecode(response.body);
    if (response.statusCode == 200) {
      AuthServices.changePassword(updata);
      Get.toNamed('/login');
    } else {
      Flushbar(
        message: responseMap.values.first,
        duration: const Duration(seconds: 3),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFF7F9EA),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Update Password",
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: 500,
                      child: Divider(
                        thickness: 2,
                        color: Color(0xFF327C04),
                        endIndent: 280,
                        indent: 0,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Reset password with agromate",
                      style: TextStyle(fontSize: 16, color: Color(0xFF505050)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextInputField(
                      hintText: "New Password",
                      validatorText: "validatorText",
                      textEditingController: passwordcontroller,
                    ),
                    SizedBox(
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
                    SizedBox(
                      height: 18,
                    ),
                    TextInputField(
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
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 50,
                      width: 500,
                      child: customElevatedButton(
                        title: "Update Password",
                        onPressed: () {
                          updatePasword();
                        },
                      ),
                    ),
                  ],
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
