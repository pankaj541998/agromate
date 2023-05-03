import 'package:flutter/material.dart';
import 'package:flutter_agro_new/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'providers/map_box_provider.dart';
import 'providers/map_filter_provider.dart';
import 'package:provider/provider.dart';

enum requestResponseState { Error, DataReceived, Loading, SessionExpired }

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
    return ScreenUtilInit(
      designSize: Size(1280, 717),
      builder: (BuildContext context, child) => 
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins'),
        initialRoute: '/',
        getPages: AppRoutes.appRoutes(),
      )
    );
    
  }
}
