import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:get/get.dart';

class ViewFarm extends StatefulWidget {
  ViewFarm({Key? key}) : super(key: key);

  @override
  State<ViewFarm> createState() => _ViewFarmState();
}

class _ViewFarmState extends State<ViewFarm> {
  late String _selectedValue;
  late String _selectedValue1;
  late String _selectedValue2;
  late String _selectedValue3;
  List<String> listOfValue = [
    'Kishan 1',
    'Kishan 2',
    'Kishan 3',
    'Kishan 4',
  ];
  List<String> listOfValue1 = [
    'VARKPLAAS 1',
    'VARKPLAAS 2',
    'VARKPLAAS 3',
    'VARKPLAAS 4',
  ];
  List<String> listOfValue2 = [
    'A',
    'B',
    'C',
    'D',
  ];
  List<String> listOfValue3 = [
    'A1A',
    'B2B',
    'C3C',
    'D4D',
  ];
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopBar(),
            SizedBox(
              height: 45,
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Farm",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 30,
                          width: 144,
                          child: ElevatedButton(
                              onPressed: () {
                                Get.toNamed('/select_plot');
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xFF327C04))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 19,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Plot Farm',
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              )),
                        )
                      ]),
                  Divider(
                    thickness: 1,
                    color: Color(0xFFD6D6D6),
                  ),
                  SizedBox(
                    height: 23,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select Landholder",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 40,
                            width: 260,
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
                                      color: Color(0xFFA1B809)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFA1B809)),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select Farm",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 40,
                            width: 260,
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
                                      color: Color(0xFFA1B809)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFA1B809)),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF327C04),
                                    width: 5.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              items: listOfValue1.map((String val) {
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
                                  _selectedValue1;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select Block",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 40,
                            width: 260,
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
                                      color: Color(0xFFA1B809)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFA1B809)),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF327C04),
                                    width: 5.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              items: listOfValue2.map((String val) {
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
                                  _selectedValue2;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select Field",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 40,
                            width: 260,
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
                                      color: Color(0xFFA1B809)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFA1B809)),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF327C04),
                                    width: 5.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              items: listOfValue3.map((String val) {
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
                                  _selectedValue3;
                                });
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Image.asset("assets/images/field.png"),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Landholder :",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "kishan",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                "Crop Name :",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "potato",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Farmers : Kishan, Raj",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              // Text(
                              //   "Kishan, Raj",
                              //   style: TextStyle(
                              //     fontSize: 18,
                              //   ),
                              // )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                "Growth Stage :",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Vegatation",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Landholder :",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "kishan",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                "Yield :",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "2000",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 38,
            )
          ],
        ),
      ),
    );
  }
}
