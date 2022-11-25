import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/custom_Elevated_Button.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:get/get.dart';

import '../../component/text_Input_field.dart';

class Crop extends StatefulWidget {
  const Crop({Key? key}) : super(key: key);

  @override
  State<Crop> createState() => _CropState();
}

class _CropState extends State<Crop> {
  late String _selectedValue;
  List<String> listOfValue = [
    'Week 1',
    'Week 2',
    'Week 3',
    'Week 4',
  ];
  buildPin() {
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AlertDialog(
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.cancel_outlined))
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Add New Crop program",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Crop",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                    height: 40,
                                    width: 300,
                                    child: TextInputField(
                                        hintText: "", validatorText: ""))
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Yield Per Hectare",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                    height: 40,
                                    width: 300,
                                    child: TextInputField(
                                        hintText: "", validatorText: ""))
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "plant Population",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                    height: 40,
                                    width: 300,
                                    child: TextInputField(
                                        hintText: "", validatorText: ""))
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Week",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                  height: 40,
                                  width: 300,
                                  child: DropdownButtonFormField(
                                    focusColor: Colors.white,
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          left: 10, top: 10, right: 10),
                                      fillColor: Colors.white,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF327C04)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF327C04)),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF327C04),
                                          width: 5.0,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    items: listOfValue.map((String val) {
                                      return DropdownMenuItem(
                                        enabled: true,
                                        value: val,
                                        child: Text(
                                          val,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedValue;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40,
                          width: 296,
                          child: CustomElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            title: "Add",
                          ),
                        ),
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
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopBar(),
          const SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Text(
                        'Select A Crop Program',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Row(
                        children: [
                          InkWell(
                            hoverColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff327C04),
                                border: Border.all(
                                  color: const Color(0xff327C04),
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 3),
                                child: Text(
                                  'Grid',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Get.toNamed('/table_view_crop'),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xffF7F9EA),
                                border: Border.all(
                                  color: const Color(0xff327C04),
                                ),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 3),
                                child: Text(
                                  'Table',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          buildPin();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF327C04),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 4),
                            child: Text(
                              'Add Crop Program',
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xffffffff)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Divider(
            height: 5,
            color: Colors.grey,
            thickness: 1,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
            child: Wrap(
              spacing: 25,
              runSpacing: 25,
              children: List<Widget>.generate(
                12,
                (int index) => SizedBox(
                  width: screenSize.width * 0.1669,
                  child: InkWell(
                    onTap: () => Get.toNamed('/view_details'),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xff000000).withOpacity(0.04),
                              offset: const Offset(0.0, 1.0),
                              blurRadius: 8.0,
                              spreadRadius: 5.0), //BoxShadow
                          const BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset('images/potato.png', width: 40),
                                const SizedBox(width: 10),
                                const Text(
                                  'Potato',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Plant Population : 80000',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Yield Per Hectares : 8000',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Weeks : 20',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
