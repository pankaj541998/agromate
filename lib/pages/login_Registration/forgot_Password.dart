import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/custom_Elevated_Button.dart';
import 'package:flutter_agro_new/component/text_input_field.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../services/otp_api.dart';
import 'otp_verification.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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
          builder: (context) => OtpVerification(
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
        color: const Color(0xFFF7F9EA),
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
                    const Text(
                      "Forgot Password",
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
                      child: Divider(
                        thickness: 2,
                        color: Color(0xFF327C04),
                        endIndent: 240,
                        indent: 0,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Reset password with agromate",
                      style: TextStyle(fontSize: 16, color: Color(0xFF505050)),
                    ),
                    const SizedBox(
                      height: 51,
                    ),
                    const Text(
                      "Enter your email and instructions will be sent to you!",
                      style: TextStyle(fontSize: 18, color: Color(0xFF000000)),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextInputField(
                      textEditingController: email,
                      leadingIcon: const Icon(
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
                    const SizedBox(
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
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 500,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Didn't receive mail ?"),
                          ElevatedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xFF327C04)),
                            ),
                            onPressed: () {},
                            child: const Text(" Resend mail"),
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
