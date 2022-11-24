// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
// import 'package:flutter_agro_new/component/custom_Elevated_Button.dart';
import 'package:get/get.dart';

class TopBar extends StatelessWidget {
  TopBar({Key? key}) : super(key: key);

  List<String> poplist = ['My Profile', 'Log Out'];
  buildPin(context) {
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AlertDialog(
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.cancel_outlined,
                      size: 60,
                      color: Color(0xFFFF0000),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Are You Sure You want to logout?",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 40,
                          width: 160,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: const BorderSide(
                                    color: Color(0xFF327C04),
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 17,
                                color: Color(0XFF000000),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        SizedBox(
                          height: 40,
                          width: 160,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  const Color(0xFF327C04),
                                ),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ))),
                            onPressed: () {
                              Get.toNamed('/login');
                            },
                            child: const Text('Logout'),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
        child: Container(
      height: 55,
      decoration: const BoxDecoration(
        color: Color(0xff327C04),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0.8,
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Image(
              image: AssetImage('/images/dashborad_logo.png'),
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Get.toNamed('/dashboard'),
                  child: Container(
                    height: double.maxFinite,
                    // color: Colors.orange[300],
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Center(
                      child: Text(
                        'Dashboard',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: Color(0xffffffff)),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: double.maxFinite,
                    // color: Colors.orange[300],
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Center(
                      child: Text(
                        'Task',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed('/crop_plan'),
                  child: Container(
                    height: double.maxFinite,
                    // color: Colors.orange[300],
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Center(
                      child: Text(
                        'Crop Plans',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed('/grid_view_crop'),
                  child: Container(
                    height: double.maxFinite,
                    // color: Colors.orange[300],
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Center(
                      child: Text(
                        'Crop',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: double.maxFinite,
                    // color: Colors.orange[300],
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Center(
                      child: Text(
                        'Farms',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: double.maxFinite,
                    // color: Colors.orange[300],
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Center(
                      child: Text(
                        'Inventory',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed('/growthstage');
                  },
                  child: Container(
                    height: double.maxFinite,
                    // color: Colors.orange[300],
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Center(
                      child: Text(
                        'Growth Stage',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed('/gapanalysis');
                  },
                  child: Container(
                    height: double.maxFinite,
                    // color: Colors.orange[300],
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Center(
                      child: Text(
                        'GAP Analysis',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: double.maxFinite,
                    // color: Colors.orange[300],
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Center(
                      child: Text(
                        'User',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: double.maxFinite,
                    // color: Colors.orange[300],
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Center(
                      child: Text(
                        'Allocation',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 15,
                  backgroundImage: NetworkImage(
                      'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909__340.png'),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                      left: 4.0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                    ),
                    child: PopupMenuButton(
                      offset: const Offset(0, 50),
                      color: const Color(0xFF327C04),
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xffffffff),
                      ),
                      onSelected: (value) {
                        if (value == '/logout') {
                          buildPin(context);
                        } else if (value == "/myProfile") {
                          Get.toNamed('/myprofile');
                        }
                        ;
                      },
                      itemBuilder: (BuildContext bc) {
                        return [
                          const PopupMenuItem(
                            child: Text(
                              "My profile",
                              style: TextStyle(color: Colors.white),
                            ),
                            value: '/myProfile',
                          ),
                          const PopupMenuItem(
                            child: Text(
                              "Logout",
                              style: TextStyle(color: Colors.white),
                            ),
                            value: '/logout',
                          )
                        ];
                      },
                    )),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
