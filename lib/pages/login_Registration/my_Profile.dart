// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/custom_Elevated_Button.dart';
import 'package:flutter_agro_new/component/text_input_field.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:get/get.dart';

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
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
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
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 50, top: 43, right: 50),
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
                  children: const [
                    SizedBox(
                      height: 30,
                    ),
                    CircleAvatar(
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                        height: 50,
                        width: 353,
                        child: TextInputField(
                            hintText: "Username", validatorText: "")),
                    const SizedBox(
                      height: 35,
                    ),
                    const Text(
                      'Email Address',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                        height: 50,
                        width: 353,
                        child: TextInputField(
                            hintText: "Email Address", validatorText: "")),
                    const SizedBox(
                      height: 35,
                    ),
                    SizedBox(
                      height: 50,
                      width: 353,
                      child: customElevatedButton(
                        onPressed: () {},
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
                  children: const [
                    Text(
                      "Full Name",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                        height: 50,
                        width: 353,
                        child: TextInputField(
                            hintText: "Full Name", validatorText: "")),
                    SizedBox(
                      height: 35,
                    ),
                    Text(
                      "Phone Number",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                        height: 50,
                        width: 353,
                        child: TextInputField(
                            hintText: "Phone Number", validatorText: "")),
                  ],
                ),
              )
            ],
          )
        ],
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, top: 43, right: 50),
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
                width: MediaQuery.of(context).size.width * 0.75,
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
          const SizedBox(
            height: 50,
            width: 353,
            child: TextInputField(
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
          const SizedBox(
            height: 50,
            width: 353,
            child: TextInputField(
              hintText: "Enter New Password",
              validatorText: "",
              isInputPassword: true,
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
          const SizedBox(
            height: 50,
            width: 353,
            child: TextInputField(
              hintText: "Confirm New Password",
              validatorText: "",
              isInputPassword: true,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 50,
            width: 353,
            child: customElevatedButton(
              onPressed: () {},
              title: "Save Changes",
            ),
          )
        ],
      ),
    );
  }
}
