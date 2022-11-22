import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/custom_Elevated_Button.dart';
import 'package:flutter_agro_new/component/text_Input_field.dart';
import 'package:flutter_agro_new/pages/login_Registration/forgot_Password.dart';
import 'package:get/get.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFF7F9EA),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    TextInputField(
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Please Enter Username";
                        }
                        return null;
                      },
                      hintText: 'Username',
                      validatorText: 'Please Enter Username',
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextInputField(
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
                    SizedBox(
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
                                    unselectedWidgetColor: Color(0xFF4E944F)),
                                child: Checkbox(
                                  activeColor: Color(0xFF4E944F),
                                  checkColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0))),
                                  value: check,
                                  onChanged: (value) {
                                    setState(() {
                                      this.check = value!;
                                    });
                                  },
                                ),
                              ),
                              Text(
                                "Remember Me",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(width: 10),
                          TextButton(
                            onPressed: () {
                              Get.toNamed('/forgotPassword');
                            },
                            child: Text(
                              "Forgot Password ?",
                              style: TextStyle(
                                  color: Color(0xFF327C04), fontSize: 15),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 51,
                    ),
                    SizedBox(
                        height: 50,
                        width: 500,
                        child: customElevatedButton(
                          title: 'Log in',
                          onPressed: () {},
                        ))
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
