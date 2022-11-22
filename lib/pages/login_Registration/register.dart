import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../component/custom_Elevated_Button.dart';
import '../../component/text_Input_field.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
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
                      "Register",
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
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
                              leadingIcon: Icon(
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
                              leadingIcon: Icon(
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
                    SizedBox(
                      height: 20,
                    ),
                    TextInputField(
                      leadingIcon: Icon(Icons.person_outline_outlined),
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
                      height: 20,
                    ),
                    TextInputField(
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
                    SizedBox(
                      height: 20,
                    ),
                    TextInputField(
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
                    SizedBox(
                      height: 20,
                    ),
                    TextInputField(
                      leadingIcon: Icon(Icons.abc),
                      hintText: 'Role',
                      validatorText: '',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        height: 50,
                        width: 500,
                        child: customElevatedButton(
                          title: 'Register',
                          onPressed: () {
                            Get.toNamed('/thankyou');
                          },
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
