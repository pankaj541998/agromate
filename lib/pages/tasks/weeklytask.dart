import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:flutter_agro_new/pages/crop/table_view_crop.dart';
import 'package:get/get.dart';

import '../../test.dart';

class WeeklyTasks extends StatefulWidget {
  const WeeklyTasks({Key? key}) : super(key: key);

  @override
  State<WeeklyTasks> createState() => _WeeklyTasksState();
}

class _WeeklyTasksState extends State<WeeklyTasks> {
  String questionsSelected = 'Potato';
  var questions = ['Potato', 'Carrot', 'Onion', 'Cabbage'];

  String landeholderSelected = 'Kishan';
  var landeholder = ['Kishan', 'Raj', 'Reethik'];
  String blockselected = 'Carrots';
  var crop = ['Green Mielies', 'Carrots', 'Sweet Corn'];
  String Fieldselected = 'Car';
  var field = ['Green ', 'Car', 'Sweet'];
  List<bool> expanded = [false, false];
  int selected = 0; //attention
  int subselected = 0; //attention

  buildPin() {
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AlertDialog(
                // insetPadding:
                //     EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                // contentPadding: EdgeInsets.fromLTRB(24, 8, 24, 24),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Week 1/Day 2",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.cancel_outlined,
                        ))
                  ],
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Title : Plowing",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Text(
                          "Status : Ongoing",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Date : 08/06/2022",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Description : Turn over the uppermost soil, bringing fresh nutrients to the surface while \nburying weeds and crop remains to decay",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Category  : Fertilizer",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 250,
                        ),
                        Text(
                          "Chemical : Ammonia",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Active Ingredients : Nitrogen",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 250,
                        ),
                        Text(
                          "Quantity : 500 Kg",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Time of application : Moderate Wind speed",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Modes of application : Tractor",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Warnings :  ",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.star),
                        Text(
                          "         May cause sensitisation by skin contact",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Precautions : ",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.star),
                        Text(
                          "      Wear a mask",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [],
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
        children: [
          TopBar(),
          const SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Tasks",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          const Divider(
            height: 5,
            color: Colors.grey,
            thickness: 1,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: screenSize.width * 0.18,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Landholder',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 15),
                          DropdownButtonFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                top: 10,
                                bottom: 10,
                                left: 10,
                                right: 10,
                              ),
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: const Color(0xff327C04).withOpacity(0.5),
                                fontFamily: 'Helvetica',
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Color(0xff327C04),
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Color(0xff327C04),
                                ),
                              ),
                              errorStyle: const TextStyle(
                                fontSize: 14,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Color(0xff327C04),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Color(0xff327C04),
                                ),
                              ),
                              isDense: true,
                            ),
                            isExpanded: true,
                            value: landeholderSelected,
                            iconEnabledColor:
                                Colors.transparent, // Down Arrow Icon
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Color(0xff327C04),
                            ),
                            iconSize: 30,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xff000000),
                                fontFamily: 'Helvetica'),
                            items: landeholder.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                landeholderSelected = newValue!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 50),
                    SizedBox(
                      width: screenSize.width * 0.18,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Block',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 15),
                          DropdownButtonFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                top: 10,
                                bottom: 10,
                                left: 10,
                                right: 10,
                              ),
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: const Color(0xff327C04).withOpacity(0.5),
                                fontFamily: 'Helvetica',
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Color(0xff327C04),
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Color(0xff327C04),
                                ),
                              ),
                              errorStyle: const TextStyle(
                                fontSize: 14,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Color(0xff327C04),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Color(0xff327C04),
                                ),
                              ),
                              isDense: true,
                            ),
                            isExpanded: true,
                            value: blockselected,
                            iconEnabledColor:
                                Colors.transparent, // Down Arrow Icon
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Color(0xff327C04),
                            ),
                            iconSize: 30,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xff000000),
                                fontFamily: 'Helvetica'),
                            items: crop.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                blockselected = newValue!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    SizedBox(
                      width: screenSize.width * 0.18,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Field',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 15),
                          DropdownButtonFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                top: 10,
                                bottom: 10,
                                left: 10,
                                right: 10,
                              ),
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: const Color(0xff327C04).withOpacity(0.5),
                                fontFamily: 'Helvetica',
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Color(0xff327C04),
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Color(0xff327C04),
                                ),
                              ),
                              errorStyle: const TextStyle(
                                fontSize: 14,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Color(0xff327C04),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Color(0xff327C04),
                                ),
                              ),
                              isDense: true,
                            ),
                            isExpanded: true,
                            value: Fieldselected,
                            iconEnabledColor:
                                Colors.transparent, // Down Arrow Icon
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Color(0xff327C04),
                            ),
                            iconSize: 30,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xff000000),
                                fontFamily: 'Helvetica'),
                            items: field.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                Fieldselected = newValue!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // accordian()
                SingleChildScrollView(
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.67,
                        child: _buildgridview(context)))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildgridview(context) {
    return GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1,
            crossAxisCount: 4,
            mainAxisSpacing: 2,
            crossAxisSpacing: 3),
        itemCount: 16,
        itemBuilder: (BuildContext ctx, index) {
          //  var element = CropProgram.cropPrograms.elementAt(index);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Week 1"),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      elevation: 2,
                      color: Color(0xFFEBF2EB),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.check_circle_outline),
                                Text("Gap Question")
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text("Answer the set of questions"),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Image.asset("assets/images/taskperson.png"),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.calendar_today_outlined),
                                SizedBox(
                                  width: 3,
                                ),
                                Text("01-12-2022")
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: () {
                        buildPin();
                      },
                      child: Card(
                        color: Color(0xFFEBF2EB),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.check_circle_outline),
                                  Text("Manuring")
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text("Adding manure to the soil"),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Image.asset("assets/images/taskperson.png"),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(Icons.calendar_today_outlined),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text("01-12-2022")
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
