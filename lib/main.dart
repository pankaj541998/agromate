import 'package:flutter/material.dart';
import 'package:flutter_agro_new/pages/Inventory_modes_of_application.dart';
import 'package:flutter_agro_new/pages/inventory.dart';
import 'package:flutter_agro_new/pages/inventory_class_type.dart';

import 'package:flutter_agro_new/pages/login_Registration/forgot_Password.dart';
import 'package:flutter_agro_new/pages/login_Registration/login.dart';
import 'package:flutter_agro_new/pages/login_Registration/my_Profile.dart';
import 'package:flutter_agro_new/pages/login_Registration/otpVerification.dart';
import 'package:flutter_agro_new/pages/login_Registration/register.dart';
import 'package:flutter_agro_new/pages/login_Registration/thankyou.dart';
import 'package:flutter_agro_new/pages/login_Registration/update_password.dart';
import 'package:flutter_agro_new/pages/stock_manager.dart';
import 'package:flutter_agro_new/pages/stock_order.dart';
import 'package:flutter_agro_new/pages/stock_planner.dart';
import 'package:get/get.dart';

import 'package:flutter_agro_new/pages/dashboard.dart';

import 'pages/crop-plan/add_crop_plan.dart';
import 'pages/crop-plan/crop_plan.dart';
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
      theme: ThemeData(fontFamily: 'Poppins'),
      initialRoute: '/add_crop_plan',
      getPages: [
        GetPage(name: '/', page: () => const login()),
        GetPage(name: '/register', page: () => const register()),
        GetPage(name: '/thankyou', page: () => const thankyou()),
        GetPage(name: '/forgotPassword', page: () => forgotPassword()),
        GetPage(name: '/otpVerification', page: () => const otpVerification()),
        GetPage(name: '/updatePassword', page: () => const updatePassword()),
        GetPage(name: '/dashboard', page: () => const DashBoard()),
        GetPage(name: '/myprofile', page: () => MyProfile()),
        GetPage(name: '/inventory', page: () => const Inventory()),
        GetPage(name: '/stockplanner', page: () => const StockPlanner()),
        GetPage(name: '/stockmanager', page: () => const StockManager()),
        GetPage(name: '/stockorder', page: () => const StockOrder()),
        GetPage(name: '/classandtype', page: () => const InventoryClassType()),
        GetPage(name: '/crop_plan', page: () => const CropPlan()),
        GetPage(name: '/add_crop_plan', page: () => const AddCropPlan()),
        GetPage(
            name: '/modesofapplication',
            page: () => const ModesOfApplication()),
      ],
    );
  }
}
