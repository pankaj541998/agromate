// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_agro_new/component/custom_Elevated_Button.dart';
import 'package:flutter_agro_new/component/services/auth_api.dart';
import 'package:flutter_agro_new/component/text_Input_field.dart';

import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';

class MyProfile extends StatefulWidget {
  MyProfile({Key? key, this.initial}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();

  int? initial;
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      initialIndex: widget.initial ?? 0,
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBar(),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
                child: Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                            onTap: () => Get.back(),
                            child: const Icon(Icons.arrow_back_ios)),
                        const SizedBox(
                          width: 530,
                          height: 80,
                          child: TabBar(
                            indicatorColor: Color(0xFF327C04),
                            labelColor: Colors.black,
                            unselectedLabelStyle:
                                TextStyle(color: Color(0xFF6B6B6B)),
                            labelStyle: TextStyle(
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                            tabs: [
                              Tab(
                                text: 'My Profile',
                              ),
                              Tab(
                                text: 'Change Password',
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 590,
                      child: TabBarView(
                        children: [
                          Profile(),
                          ChangePassword(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final username = TextEditingController();
  final email = TextEditingController();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final phone = TextEditingController();

  final myprofile = GlobalKey<FormState>();

  @override
  void initState() {
    setValues();
    super.initState();
  }

  setValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    firstname.text = prefs.getString('firstName')!;
    lastname.text = prefs.getString('lastName')!;
    phone.text = prefs.getString('phone')!;
    email.text = prefs.getString('email')!;
    username.text = prefs.getString('username')!;
  }

  Future<dynamic> submitData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int userid = prefs.getInt('user_id') ?? 1;
    print("reached");
    print(firstname.text);
    var response =
        await http.post(Uri.parse(ApiConstant.profileUpdateAPI), body: {
      "phone": phone.text,
      "first_name": firstname.text,
      "last_name": lastname.text,
      "user_id": userid.toString(),
    });
    var data = response.body;
    print('response is ' + data);

    if (response.statusCode == 200) {
      // String responseString = response.body;
      // User.fromJson(jsonDecode(responseString) as Map<String, dynamic>);
      Flushbar(
        message: "Changes Saved Successfully",
        duration: const Duration(seconds: 3),
      ).show(context);
    } else
      return Flushbar(
        message: "Unable to save Changes",
        duration: const Duration(seconds: 3),
      ).show(context);
  }

  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 50, top: 43, right: 50),
      child: Form(
        key: myprofile,
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  "Personal Details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: const SizedBox(
                    width: double.infinity,
                    child: Divider(
                      color: Color(0xFF327C04),
                      thickness: 1,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      CircleAvatar(
                        child: Image.asset("assets/images/profilepic.png"),
                        radius: 72.5,
                      ),
                      SizedBox(
                        height: 23,
                      ),
                      Text(
                        "Profile Picture",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 70,
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Username',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                          width: 353,
                          child: TextInputField(
                              readonly: true,
                              textEditingController: username,
                              hintText: "Username",
                              validatorText: "")),
                      const SizedBox(
                        height: 35,
                      ),
                      const Text(
                        'Email Address',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                          width: 353,
                          child: TextInputField(
                              readonly: true,
                              textEditingController: email,
                              hintText: "Email Address",
                              validatorText: "")),
                      const SizedBox(
                        height: 35,
                      ),
                      SizedBox(
                        height: 40,
                        width: 353,
                        child: CustomElevatedButton(
                          onPressed: () {
                            final isValid = myprofile.currentState?.validate();
                            if (isValid!) {
                              submitData();
                            }
                          },
                          title: 'Save Changes',
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 60,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "First Name",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                width: 150,
                                child: TextInputField(
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(20),
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-zA-Z]')),
                                  ],
                                  textEditingController: firstname,
                                  hintText: "First Name",
                                  validatorText: "",
                                  validator: (value) {
                                    if (value != null && value.isEmpty) {
                                      return "Please Enter First Name";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 53,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Last Name",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                width: 150,
                                child: TextInputField(
                                  textEditingController: lastname,
                                  hintText: "Last Name",
                                  validatorText: "",
                                  validator: (value) {
                                    if (value != null && value.isEmpty) {
                                      return "Please Enter Last Name";
                                    }
                                    return null;
                                  },
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(20),
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-zA-Z]')),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Text(
                        "Phone Number",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: 353,
                        child: TextInputField(
                          textEditingController: phone,
                          hintText: "Phone Number",
                          validatorText: "",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Phone Number";
                            } else if (value.length != 10) {
                              return "Please Enter Valid Phone Number";
                            }
                            return null;
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final confirmpassword = TextEditingController();
  final currentpassword = TextEditingController();
  final newpassword = TextEditingController();

  final GlobalKey<FormState> _passwordkey = GlobalKey<FormState>();

  Future<void> changePasword() async {
    print("uppassword called");
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int? userId = prefs.getInt('user_id');
    Map<String, dynamic> updata = {
      "user_id": userId.toString(),
      "curr_password": currentpassword.text,
      "new_password": confirmpassword.text,
    };

    http.Response response = await AuthServices.changePassword(updata);
    Map responseMap = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Flushbar(
        message: "Password Changed Successfully",
        duration: const Duration(seconds: 3),
      ).show(context);
      Get.toNamed('/');
    } else {
      Flushbar(
        message: responseMap.values.last,
        duration: const Duration(seconds: 3),
      ).show(context);
    }
  }

  void _validateData() {
    final isValid = _passwordkey.currentState?.validate();
    if (isValid!) {
      changePasword();
    } else {
      Flushbar(
        message: "Password not matched",
        duration: const Duration(seconds: 3),
      ).show(context);

      Timer(Duration(seconds: 2), () {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, top: 43, right: 50),
      child: Form(
        key: _passwordkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "Generate Password",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.67,
                  child: const Divider(
                    color: Color(0xFF327C04),
                    thickness: 1,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 33,
            ),
            const Text(
              "Current Password",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 40,
              width: 353,
              child: TextInputField(
                textEditingController: currentpassword,
                hintText: "Enter Current Password",
                validatorText: "",
                isInputPassword: true,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Enter New Password",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 40,
              width: 353,
              child: TextInputField(
                textEditingController: newpassword,
                hintText: "Enter New Password",
                validatorText: "",
                isInputPassword: true,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Password is Empty';
                  }
                  if (!RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$')
                      .hasMatch(val)) {
                    return 'password should contain atleast one Uppercase,\n one Lowercase, one numeric & one special character';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Confirm New Password",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 40,
              width: 353,
              child: TextInputField(
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "Password cannot be empty";
                  } else if (value != null && value.length < 6) {
                    return "Password length should be atleast 6";
                  } else if (value != newpassword.text) {
                    return "Password Not Matched";
                  }
                  return null;
                },
                textEditingController: confirmpassword,
                hintText: "Confirm New Password",
                validatorText: "",
                isInputPassword: true,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 40,
              width: 353,
              child: CustomElevatedButton(
                onPressed: () {
                  _validateData();
                },
                title: "Save Changes",
              ),
            )
          ],
        ),
      ),
    );
  }
}
