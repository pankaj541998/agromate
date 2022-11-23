import 'package:flutter/material.dart';

import 'package:flutter_agro_new/pages/login_Registration/forgot_Password.dart';
import 'package:flutter_agro_new/pages/login_Registration/login.dart';
import 'package:flutter_agro_new/pages/login_Registration/otpVerification.dart';
import 'package:flutter_agro_new/pages/login_Registration/register.dart';
import 'package:flutter_agro_new/pages/login_Registration/thankyou.dart';
import 'package:flutter_agro_new/pages/login_Registration/update_password.dart';
import 'package:get/get.dart';

import 'package:flutter_agro_new/pages/dashboard.dart';

import 'test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("root build");
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/test',
      getPages: [
        GetPage(name: '/', page: () => const login()),
        GetPage(name: '/register', page: () => const register()),
        GetPage(name: '/thankyou', page: () => const thankyou()),
        GetPage(name: '/forgotPassword', page: () => forgotPassword()),
        GetPage(name: '/otpVerification', page: () => const otpVerification()),
        GetPage(name: '/updatePassword', page: () => const updatePassword()),
        GetPage(name: '/dashboard', page: () => const DashBoard()),
        GetPage(name: '/test', page: () => const Charts()),
      ],
    );
  }
}
