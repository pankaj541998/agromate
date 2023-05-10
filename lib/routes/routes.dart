import 'package:flutter_agro_new/Views/pages/crop-plan/add_crop_plan_from_farm.dart';
import 'package:flutter_agro_new/Views/pages/login_Registration/forgot_Password.dart';
import 'package:flutter_agro_new/Views/pages/login_Registration/my_Profile.dart';
import 'package:get/get.dart';
import 'package:flutter_agro_new/Views/pages/dashboard.dart';
import 'package:flutter_agro_new/Views/pages/Inventory/stock_manager/add_stock.dart';
import 'package:flutter_agro_new/Views/pages/Inventory/stock_manager/stock_manager.dart';
import 'package:flutter_agro_new/Views/pages/Inventory/stock_manager/stock_manager_table.dart';
import 'package:flutter_agro_new/Views/pages/Inventory/stock_planner/stock_planner.dart';
import 'package:flutter_agro_new/Views/pages/Inventory/stock_planner/stock_planner_table.dart';
import 'package:flutter_agro_new/Views/pages/crop-plan/add_crop_plan.dart';
import 'package:flutter_agro_new/Views/pages/crop-plan/crop_plan.dart';
import 'package:flutter_agro_new/Views/pages/crop/grid_view_crop.dart';
import 'package:flutter_agro_new/Views/pages/crop/table_view_crop.dart';
import 'package:flutter_agro_new/Views/pages/crop/view_details.dart';
import 'package:flutter_agro_new/Views/pages/farms/plot_farm.dart';
import 'package:flutter_agro_new/Views/pages/tasks/add_task.dart';
import 'package:flutter_agro_new/Views/pages/tasks/taska.dart';
import 'package:flutter_agro_new/Views/pages/Inventory/modes_of_application/Inventory_modes_of_application.dart';
import 'package:flutter_agro_new/Views/pages/allocation.dart';
import 'package:flutter_agro_new/Views/pages/allocate.dart';
import 'package:flutter_agro_new/Views/pages/farms/plot_block.dart';
import 'package:flutter_agro_new/Views/pages/farms/plot_field.dart';
import 'package:flutter_agro_new/Views/pages/farms/view_farm.dart';
import 'package:flutter_agro_new/Views/pages/gap_analysis/gap_analysis.dart';
import 'package:flutter_agro_new/Views/pages/growth_stages/growth_stage_details.dart';
import 'package:flutter_agro_new/Views/pages/growth_stages/growth_stages.dart';
import 'package:flutter_agro_new/Views/pages/Inventory/inventory.dart';
import 'package:flutter_agro_new/Views/pages/Inventory/class_and_type/inventory_class_type.dart';

import 'package:flutter_agro_new/Views/pages/login_Registration/login.dart';

import 'package:flutter_agro_new/Views/pages/login_Registration/otp_verification.dart';
import 'package:flutter_agro_new/Views/pages/login_Registration/register.dart';
import 'package:flutter_agro_new/Views/pages/login_Registration/thankyou.dart';
import 'package:flutter_agro_new/Views/pages/login_Registration/update_password.dart';
import 'package:flutter_agro_new/Views/pages/Inventory/stock_order/stock_order.dart';
import 'package:flutter_agro_new/Views/pages/tasks/weeklytask.dart';
import 'package:flutter_agro_new/Views/pages/user.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(name: '/', page: () => const Login()),
        GetPage(name: '/register', page: () => const Register()),
        GetPage(name: '/thankyou', page: () => Thankyou()),
        GetPage(name: '/forgotPassword', page: () => const ForgotPassword()),
        GetPage(name: '/otpVerification', page: () => const OtpVerification()),
        GetPage(name: '/updatePassword', page: () => const UpdatePassword()),
        GetPage(name: '/dashboard', page: () => const DashBoard()),
        GetPage(name: '/myprofile', page: () => MyProfile()),
        GetPage(name: '/inventory', page: () => const Inventory()),
        GetPage(name: '/gapanalysis', page: () => GapAnalysis()),
        GetPage(name: '/growthstage', page: () => GrowthStage()),
        GetPage(name: '/growthstagedetails', page: () => GrowthStageDetails()),
        GetPage(name: '/crop_plan', page: () => CropPlan()),
        GetPage(name: '/add_crop_plan', page: () => AddCropPlan()),
        GetPage(name: '/grid_view_crop', page: () => Crop()),
        GetPage(name: '/table_view_crop', page: () => TableViewCrop()),
        GetPage(name: '/view_details', page: () => ViewDetails()),
        GetPage(name: '/view_farm', page: () => ViewFarm()),
        GetPage(name: '/plot_farm', page: () => PlotFarm()),
        GetPage(name: '/plot_block', page: () => PlotBlock()),
        GetPage(name: '/plot_field', page: () => PlotField()),
        GetPage(name: '/inventory', page: () => const Inventory()),
        GetPage(name: '/AddCropPlanFromFarm', page: () => AddCropPlanFromFarm()),

        GetPage(name: '/stockplanner', page: () => const StockPlanner()),
        GetPage(
            name: '/stockplannertable', page: () => const StockPlannerTable()),
        GetPage(name: '/stockmanager', page: () => const StockManager()),
        GetPage(
            name: '/stockmanagertable', page: () => const StockManagerTable()),
        GetPage(name: '/addstock', page: () => const AddStock()),
        GetPage(name: '/stockorder', page: () => const StockOrder()),
        GetPage(name: '/classandtype', page: () => InventoryClassType()),
        GetPage(name: '/crop_plan', page: () => const CropPlan()),
        GetPage(name: '/add_crop_plan', page: () => AddCropPlan()),
        GetPage(name: '/grid_view_crop', page: () => const Crop()),
        GetPage(name: '/view_details', page: () => ViewDetails()),
        GetPage(name: '/table_view_crop', page: () => const TableViewCrop()),
        GetPage(name: '/tasks', page: () => const Tasks()),
        GetPage(name: '/add_tasks', page: () => const AddTask()),
        GetPage(
            name: '/modesofapplication',
            page: () => const ModesOfApplication()),
        GetPage(name: '/user', page: () => User()),
        GetPage(name: '/allocation', page: () => Allocation()),
        GetPage(name: '/allocate', page: () => Allocate()),
        GetPage(name: '/weeklytasks', page: () => WeeklyTasks()),
      ];
}
