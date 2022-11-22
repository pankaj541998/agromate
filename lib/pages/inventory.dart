import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:get/get.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          TopBar(),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Inventory',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff000000),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Divider(
                    height: 5,
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  SizedBox(height: screenSize.height * 0.03),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InkWell(
                              child: Card(
                                color: Color(0xFFf7f9ea),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.all(screenSize.width * 0.02),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Image(
                                        image: AssetImage(
                                            'image/calendar-svgrepo-com.png'),
                                        height: 100,
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        'Stock Planner',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        "Track schedule inventories",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                Get.toNamed('/stockplanner');
                              },
                            ),
                          ),
                          SizedBox(width: screenSize.width * 0.03),
                          Expanded(
                            child: InkWell(
                              child: Card(
                                color: Color(0xFFf7f9ea),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.all(screenSize.width * 0.02),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Image(
                                        image: AssetImage(
                                            'image/managament-manager-organize-svgrepo-com.png'),
                                        height: 100,
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        'Stock Manager',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        "Manage inventory items",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                Get.toNamed('/stockmanager');
                              },
                            ),
                          ),
                          SizedBox(width: screenSize.width * 0.03),
                          Expanded(
                            child: InkWell(
                              child: Card(
                                color: Color(0xFFf7f9ea),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.all(screenSize.width * 0.02),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Image(
                                        image: AssetImage(
                                            'image/stock-svgrepo-com.png'),
                                        height: 100,
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        'Stock Order',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        "Generate stock Orders",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                Get.toNamed('/stockorder');
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: screenSize.width * 0.15),
                          Expanded(
                            child: InkWell(
                              child: Card(
                                color: Color(0xFFf7f9ea),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.all(screenSize.width * 0.02),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Image(
                                        image: AssetImage(
                                            'image/warehouse-svgrepo-com.png'),
                                        height: 100,
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        'Inventory Class & Types',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        "Define inventory classifications",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                Get.toNamed('/classandtype');
                              },
                            ),
                          ),
                          SizedBox(width: screenSize.width * 0.03),
                          Expanded(
                            child: InkWell(
                              child: Card(
                                color: Color(0xFFf7f9ea),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.all(screenSize.width * 0.02),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Image(
                                        image: AssetImage(
                                            'image/tractor-svgrepo-com.png'),
                                        height: 100,
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        'Modes Of Applications',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        "Define modes of applications",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                Get.toNamed('/modesofapplication');
                              },
                            ),
                          ),
                          SizedBox(width: screenSize.width * 0.15),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
