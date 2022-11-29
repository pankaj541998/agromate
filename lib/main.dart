import 'package:flutter/material.dart';
import 'package:flutter_agro_new/pages/Inventory/modes_of_application/Inventory_modes_of_application.dart';

import 'package:flutter_agro_new/pages/allocation.dart';

import 'package:flutter_agro_new/pages/allocate.dart';

import 'package:flutter_agro_new/pages/farms/select_block.dart';
import 'package:flutter_agro_new/pages/farms/select_field.dart';

import 'package:flutter_agro_new/pages/farms/view_farm.dart';
import 'package:flutter_agro_new/pages/gap_analysis/gap_analysis.dart';
import 'package:flutter_agro_new/pages/growth_stages/growth_stage_details.dart';
import 'package:flutter_agro_new/pages/growth_stages/growth_stages.dart';
import 'package:flutter_agro_new/pages/Inventory/inventory.dart';
import 'package:flutter_agro_new/pages/Inventory/class_and_type/inventory_class_type.dart';

import 'package:flutter_agro_new/pages/login_Registration/forgot_password.dart';
import 'package:flutter_agro_new/pages/login_Registration/login.dart';
import 'package:flutter_agro_new/pages/login_Registration/my_profile.dart';
import 'package:flutter_agro_new/pages/login_Registration/otp_verification.dart';
import 'package:flutter_agro_new/pages/login_Registration/register.dart';
import 'package:flutter_agro_new/pages/login_Registration/thankyou.dart';
import 'package:flutter_agro_new/pages/login_Registration/update_password.dart';
import 'package:flutter_agro_new/pages/Inventory/stock_order/stock_order.dart';
import 'package:flutter_agro_new/pages/user.dart';
import 'package:get/get.dart';
import 'package:flutter_agro_new/pages/dashboard.dart';
import 'pages/Inventory/stock_manager/add_stock.dart';
import 'pages/Inventory/stock_manager/stock_manager.dart';
import 'pages/Inventory/stock_manager/stock_manager_table.dart';
import 'pages/Inventory/stock_planner/stock_planner.dart';
import 'pages/Inventory/stock_planner/stock_planner_table.dart';
import 'pages/crop-plan/add_crop_plan.dart';
import 'pages/crop-plan/crop_plan.dart';
import 'pages/crop/grid_view_crop.dart';
import 'pages/crop/table_view_crop.dart';
import 'pages/crop/view_details.dart';
import 'pages/farms/select_plot.dart';
import 'pages/tasks/add_task.dart';
import 'pages/tasks/taska.dart';
import 'providers/map_box_provider.dart';
import 'providers/map_filter_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => MapFilterProvider()),
      ChangeNotifierProvider(create: (context) => MapBoxProvider()),
    ],
    child: const MyApp(),
  ));
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
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const Login()),
        GetPage(name: '/register', page: () => const Register()),
        GetPage(name: '/thankyou', page: () => const Thankyou()),
        GetPage(name: '/forgotPassword', page: () => const ForgotPassword()),
        GetPage(name: '/otpVerification', page: () => const OtpVerification()),
        GetPage(name: '/updatePassword', page: () => const UpdatePassword()),
        GetPage(name: '/dashboard', page: () => const DashBoard()),
        GetPage(name: '/myprofile', page: () => MyProfile()),
        GetPage(name: '/inventory', page: () => Inventory()),
        GetPage(name: '/gapanalysis', page: () => GapAnalysis()),
        GetPage(name: '/growthstage', page: () => GrowthStage()),
        GetPage(name: '/growthstagedetails', page: () => GrowthStageDetails()),
        GetPage(name: '/crop_plan', page: () => CropPlan()),
        GetPage(name: '/add_crop_plan', page: () => AddCropPlan()),
        GetPage(name: '/grid_view_crop', page: () => Crop()),
        GetPage(name: '/table_view_crop', page: () => TableViewCrop()),
        GetPage(name: '/view_details', page: () => ViewDetails()),
        GetPage(name: '/view_farm', page: () => ViewFarm()),
        GetPage(name: '/select_plot', page: () => SelectPlot()),
        GetPage(name: '/select_block', page: () => SelectBlock()),
        GetPage(name: '/select_field', page: () => SelectField()),
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
        GetPage(name: '/user', page: () => User()),
        GetPage(name: '/allocation', page: () => Allocation()),
        GetPage(name: '/allocate', page: () => Allocate()),
      ],
    );
  }
}
