import 'package:flutter/material.dart';
import 'package:flutter_agro_new/pages/login_Registration/forgot_Password.dart';
import 'package:flutter_agro_new/pages/login_Registration/login.dart';
import 'package:flutter_agro_new/pages/login_Registration/otpVerification.dart';
import 'package:flutter_agro_new/pages/login_Registration/register.dart';
import 'package:flutter_agro_new/pages/login_Registration/thankyou.dart';
import 'package:flutter_agro_new/pages/login_Registration/update_password.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("root build");
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => login()),
        GetPage(name: '/register', page: () => register()),
        GetPage(name: '/thankyou', page: () => thankyou()),
        GetPage(name: '/forgotPassword', page: () => forgotPassword()),
        GetPage(name: '/otpVerification', page: () => otpVerification()),
        GetPage(name: '/updatePassword', page: () => updatePassword()),
      ],
    );
  }
}
