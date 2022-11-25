import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_agro_new/component/custom_Elevated_Button.dart';
import 'package:flutter_agro_new/pages/login_Registration/update_password.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;
import '../../services/otp_api.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({Key? key, this.email}) : super(key: key);

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
  final String? email;
}

class _OtpVerificationState extends State<OtpVerification> {
  final otp = TextEditingController();

  Future<void> otpSend() async {
    print(widget.email);
    Map<String, dynamic> updata = {
      "email": widget.email,
      "otp": otp.text,
    };

    http.Response response = await OTPServices().verifyOTP(updata);
    Map responseMap = jsonDecode(response.body);
    print("response is $responseMap");
    if (response.statusCode == 200) {
      Get.toNamed('/updatePassword');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UpdatePassword(email: widget.email)));
    } else {
      Flushbar(
        message: responseMap.values.last.toString(),
        duration: const Duration(seconds: 2),
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
                      "Enter OTP",
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
                        endIndent: 280,
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
                    SizedBox(
                      width: 400,
                      child: PinCodeTextField(
                        cursorHeight: 20,
                        cursorColor: Colors.green,
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return "Please Enter OTP";
                          } else if (value != null && value.length < 4) {
                            return "OTP length should be atleast 4";
                          }
                          return null;
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        length: 4,
                        obscureText: false, autoFocus: true,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          selectedFillColor: Colors.white,
                          inactiveFillColor: Colors.white,
                          inactiveColor: const Color(0xFFA1B809),
                          activeColor: const Color(0xFFA1B809),
                          selectedColor: const Color(0xFFA1B809),
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(15),
                          fieldHeight: 60,
                          fieldWidth: 60,
                          activeFillColor: Colors.white,
                        ),
                        animationDuration: const Duration(milliseconds: 300),
                        // backgroundColor: Colors.white,
                        enableActiveFill: true,
                        // errorAnimationController: errorController,
                        controller: otp,
                        onCompleted: (v) {
                          print("Completed");
                        },
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            // currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                        keyboardType: TextInputType.number,
                        appContext: context,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 50,
                      width: 400,
                      child: customElevatedButton(
                        title: "Submit OTP",
                        onPressed: () {
                          otpSend();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 400,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Didn't receive OTP ?"),
                          ElevatedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xFF327C04)),
                            ),
                            onPressed: () {},
                            child: const Text(" Resend OTP"),
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
