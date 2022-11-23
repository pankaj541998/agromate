// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/custom_Elevated_Button.dart';
import 'package:flutter_agro_new/component/text_Input_field.dart';
import 'package:flutter_agro_new/component/top_bar.dart';

class MyProfile extends StatefulWidget {
  MyProfile({Key? key, this.initial}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();

  int? initial;
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
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
                padding: EdgeInsets.only(left: 50, top: 43, right: 50),
                child: SizedBox(
                  width: 530,
                  height: 80,
                  child: AppBar(
                    bottom: TabBar(
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
                        ]),
                    elevation: 0,
                    backgroundColor: Colors.white,
                    leading: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                  height: 590,
                  child: TabBarView(children: [profile(), ChangePassword()]))
            ],
          ),
        ),
      ),
    );
  }
}

class profile extends StatefulWidget {
  profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 50, top: 43, right: 50),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Personal Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Divider(
                  color: Color(0xFF327C04),
                  thickness: 1,
                ),
              )
            ],
          ),
          SizedBox(
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
              SizedBox(
                width: 70,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username',
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
                            hintText: "Username", validatorText: "")),
                    SizedBox(
                      height: 35,
                    ),
                    Text(
                      'Email Address',
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
                            hintText: "Email Address", validatorText: "")),
                    SizedBox(
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
              SizedBox(
                width: 60,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
  ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 50, top: 43, right: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Generate Password",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Divider(
                  color: Color(0xFF327C04),
                  thickness: 1,
                ),
              )
            ],
          ),
          SizedBox(
            height: 33,
          ),
          Text(
            "Current Password",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 50,
            width: 353,
            child: TextInputField(
              hintText: "Enter Current Password",
              validatorText: "",
              isInputPassword: true,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Enter New Password",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 50,
            width: 353,
            child: TextInputField(
              hintText: "Enter New Password",
              validatorText: "",
              isInputPassword: true,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Confirm New Password",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 50,
            width: 353,
            child: TextInputField(
              hintText: "Confirm New Password",
              validatorText: "",
              isInputPassword: true,
            ),
          ),
          SizedBox(
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
