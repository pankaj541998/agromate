import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/custom_Elevated_Button.dart';
import 'package:flutter_agro_new/component/text_Input_field.dart';
import 'package:flutter_agro_new/pages/login_Registration/otpVerification.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../services/otp_api.dart';

class forgotPassword extends StatefulWidget {
  forgotPassword({Key? key}) : super(key: key);

  @override
  State<forgotPassword> createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {
  final email = TextEditingController();

  Future<void> otpSendData() async {
    print("reached");
    Map<String, dynamic> updata = {
      "email": email.text,
    };

    http.Response response = await OTPServices().otp(updata);
    Map responseMap = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("go to otp now");
      Get.toNamed('/otpVerification');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => otpVerification(
            email: email.text,
          ),
        ),
      );
    } else {
      Flushbar(
        duration: const Duration(seconds: 2),
        message: responseMap.values.first,
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
                      "Forgot Password",
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
                        endIndent: 240,
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
                      height: 51,
                    ),
                    Text(
                      "Enter your email and instructions will be sent to you!",
                      style: TextStyle(fontSize: 18, color: Color(0xFF000000)),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextInputField(
                      textEditingController: email,
                      leadingIcon: Icon(
                        Icons.email_outlined,
                        color: Color(0xFFA1B809),
                      ),
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
                      validatorText: 'Please Enter Email address',
                    ),
                    SizedBox(
                      height: 29,
                    ),
                    SizedBox(
                      height: 50,
                      width: 500,
                      child: customElevatedButton(
                        title: 'Send Mail',
                        onPressed: () {
                          otpSendData();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 500,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Didn't receive mail ?"),
                          ElevatedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xFF327C04)),
                            ),
                            onPressed: () {},
                            child: Text(" Resend mail"),
                          )
                        ],
                      ),
                    )
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
