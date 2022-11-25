import 'package:flutter/material.dart';
import 'package:flutter_agro_new/pages/inventory_modes_of_application.dart';
import 'package:flutter_agro_new/pages/add_stock.dart';
import 'package:flutter_agro_new/pages/inventory.dart';
import 'package:flutter_agro_new/pages/inventory_class_type.dart';

import 'package:flutter_agro_new/pages/login_Registration/forgot_password.dart';
import 'package:flutter_agro_new/pages/login_Registration/login.dart';
import 'package:flutter_agro_new/pages/login_Registration/my_profile.dart';
import 'package:flutter_agro_new/pages/login_Registration/otp_verification.dart';
import 'package:flutter_agro_new/pages/login_Registration/register.dart';
import 'package:flutter_agro_new/pages/login_Registration/thankyou.dart';
import 'package:flutter_agro_new/pages/login_Registration/update_password.dart';
import 'package:flutter_agro_new/pages/stock_manager.dart';
import 'package:flutter_agro_new/pages/stock_manager_table.dart';
import 'package:flutter_agro_new/pages/stock_order.dart';
import 'package:flutter_agro_new/pages/stock_planner.dart';
import 'package:flutter_agro_new/pages/stock_planner_table.dart';
import 'package:flutter_agro_new/pages/taska/add_task.dart';
import 'package:flutter_agro_new/pages/taska/taska.dart';
import 'package:flutter_agro_new/test.dart';
import 'package:get/get.dart';

import 'package:flutter_agro_new/pages/dashboard.dart';

import 'pages/crop-plan/add_crop_plan.dart';
import 'pages/crop-plan/crop_plan.dart';
import 'pages/crop/grid_view_crop.dart';
import 'pages/crop/table_view_crop.dart';
import 'pages/crop/view_details.dart';

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
      initialRoute: '/test',
      getPages: [
        GetPage(name: '/', page: () => const Login()),
        GetPage(name: '/register', page: () => const Register()),
        GetPage(name: '/thankyou', page: () => const Thankyou()),
        GetPage(name: '/forgotPassword', page: () => const ForgotPassword()),
        GetPage(name: '/otpVerification', page: () => const OtpVerification()),
        GetPage(name: '/updatePassword', page: () => const UpdatePassword()),
        GetPage(name: '/dashboard', page: () => const DashBoard()),
        GetPage(name: '/myprofile', page: () => MyProfile()),
        GetPage(name: '/inventory', page: () => const Inventory()),
        GetPage(name: '/stockplanner', page: () => const StockPlanner()),
        GetPage(
            name: '/stockplannertable', page: () => const StockPlannerTable()),
        GetPage(name: '/stockmanager', page: () => const StockManager()),
        GetPage(
            name: '/stockmanagertable', page: () => const StockManagerTable()),
        GetPage(name: '/addstock', page: () => const AddStock()),
        GetPage(name: '/stockorder', page: () => const StockOrder()),
        GetPage(name: '/classandtype', page: () => const InventoryClassType()),
        GetPage(name: '/crop_plan', page: () => const CropPlan()),
        GetPage(name: '/add_crop_plan', page: () => const AddCropPlan()),
        GetPage(name: '/grid_view_crop', page: () => const Crop()),
        GetPage(name: '/view_details', page: () => const ViewDetails()),
        GetPage(name: '/table_view_crop', page: () => const TableViewCrop()),
        GetPage(name: '/tasks', page: () => const Tasks()),
        GetPage(name: '/add_tasks', page: () => const AddTask()),
        GetPage(
            name: '/modesofapplication',
            page: () => const ModesOfApplication()),
        GetPage(name: '/test', page: () => const TestAccordian()),
      ],
    );
  }
}
