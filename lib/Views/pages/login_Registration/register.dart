import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_agro_new/component/custom_Elevated_Button.dart';
import 'package:flutter_agro_new/component/services/register_api.dart';
import 'package:flutter_agro_new/component/text_input_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;



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

      Map responseMap = jsonDecode(response.body);
      if (response.statusCode == 202) {
        Get.toNamed('/thankyou');
      } else {
        print("else entered");
        Flushbar(
          duration: const Duration(seconds: 2),
          message: responseMap.values.first,
        );
      }
    } else {
      Flushbar(
        duration: const Duration(seconds: 2),
        message: "Please Enter all the details",
      );
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
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: const Color(0xFFF7F9EA),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // InkWell(
                            //   onTap: () => Get.back(),
                            //   child: Icon(Icons.arrow_back_ios),
                            // ),
                            const Text(
                              "Register",
                              style: TextStyle(
                                  fontSize: 35,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
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
                                  leadingIcon: Image.asset(
                                      "assets/images/firstname.png"),
                                  validator: (value) {
                                    if (value != null && value.isEmpty) {
                                      return "Please Enter First Name";
                                    }
                                    return null;
                                  },
                                  hintText: 'First Name',
                                  validatorText: 'Please Enter First Name',
                                  inputFormatters: [
                                    new LengthLimitingTextInputFormatter(20),
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-zA-Z]')),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 235,
                                child: TextInputField(
                                  textEditingController: lastname,
                                  leadingIcon: Image.asset(
                                      "assets/images/firstname.png"),
                                  validator: (value) {
                                    if (value != null && value.isEmpty) {
                                      return "Please Enter Last Name";
                                    }
                                    return null;
                                  },
                                  hintText: 'Last Name',
                                  validatorText: 'Please Enter Last Name',
                                  inputFormatters: [
                                    new LengthLimitingTextInputFormatter(20),
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-zA-Z]')),
                                  ],
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
                          leadingIcon:
                              Image.asset("assets/images/username.png"),
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return "Please Enter Username";
                            }
                            return null;
                          },
                          hintText: 'Username',
                          validatorText: 'Please Enter Username',
                          inputFormatters: [
                            new LengthLimitingTextInputFormatter(20),
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-zA-Z, 0-9]')),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextInputField(
                            leadingIcon: Image.asset("assets/images/email.png"),
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
                          leadingIcon: Image.asset("assets/images/Phone.png"),
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
                          validatorText: 'Please Enter Phone Number',
                          inputFormatters: [
                            new LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],
                        ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // TextInputField(
                        //   readonly: true,
                        //   leadingIcon: Image.asset("assets/images/role.png"),
                        //   hintText: 'Role',
                        //   validatorText: '',
                        // ),
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
      ),
    );
  }
}
