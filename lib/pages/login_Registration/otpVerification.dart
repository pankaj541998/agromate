import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_agro_new/component/custom_Elevated_Button.dart';
import 'package:flutter_agro_new/component/text_Input_field.dart';
import 'package:flutter_agro_new/pages/login_Registration/update_password.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;
import '../../services/otp_api.dart';

class otpVerification extends StatefulWidget {
  otpVerification({Key? key, this.email}) : super(key: key);

  @override
  State<otpVerification> createState() => _otpVerificationState();
  final String? email;
}

class _otpVerificationState extends State<otpVerification> {
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
              builder: (context) => updatePassword(email: widget.email)));
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
                      "Enter OTP",
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
                          inactiveColor: Color(0xFFA1B809),
                          activeColor: Color(0xFFA1B809),
                          selectedColor: Color(0xFFA1B809),
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(15),
                          fieldHeight: 60,
                          fieldWidth: 60,
                          activeFillColor: Colors.white,
                        ),
                        animationDuration: Duration(milliseconds: 300),
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
                    SizedBox(
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
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 400,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Didn't receive OTP ?"),
                          TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xFF327C04)),
                            ),
                            onPressed: () {},
                            child: Text(" Resend OTP"),
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
