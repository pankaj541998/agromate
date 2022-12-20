import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/custom_Elevated_Button.dart';
import 'package:flutter_agro_new/component/text_Input_field.dart';
import 'package:flutter_agro_new/component/top_bar.dart';

class Allocate extends StatefulWidget {
  Allocate({Key? key}) : super(key: key);

  @override
  State<Allocate> createState() => _AllocateState();
}

bool check = false;
bool check1 = false;
bool check2 = false;
bool check3 = false;
bool check4 = false;
bool check5 = false;
bool check6 = false;
bool check7 = false;

class _AllocateState extends State<Allocate> {
  late String _selectedValue;
  late String _selectedValue1;
  late String _selectedValue2;
  late String _selectedValue3;
  late String _selectedValue4;
  late String _selectedValue5;
  late String _selectedValue6;
  late String _selectedValue7;
  List<String> listOfValue = [
    'Kishan 1',
    'Kishan 2',
    'Kishan 3',
    'Kishan 4',
  ];
  List<String> listOfValue1 = [
    'Farm 1',
    'Farm 2',
    'Farm 3',
    'Farm 4',
  ];
  List<String> listOfValue2 = [
    'Agronomist 1',
    'Agronomist 2',
    'Agronomist 3',
    'Agronomist 4',
  ];
  List<String> listOfValue3 = [
    'Manager 1',
    'Manager 2',
    'Manager 3',
    'Manager 4',
  ];
  List<String> listOfValue4 = [
    'Block 1',
    'Block 2',
    'Block 3',
    'Block 4',
  ];
  List<String> listOfValue5 = [
    'Field 1',
    'Field 2',
    'Field 3',
    'Field 4',
  ];
  List<String> listOfValue6 = [
    'Farmer 1',
    'Farmer 2',
    'Farmer 3',
    'Farmer 4',
  ];
  List<String> listOfValue7 = [
    'Labourer 1',
    'Labourer 2',
    'Labourer 3',
    'Labourer 4',
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
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        "Allocation",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    color: Color(0xFFD6D6D6),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 60,
                    width: double.infinity,
                    color: Color(0xFFF7F9EA),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 40,
                        top: 18,
                      ),
                      child: Text(
                        "Allocating Agronomist & Manager",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Landholder",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 40,
                            width: 257,
                            child: DropdownButtonFormField(
                              hint: Text("Select Landholder"),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Farm",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 40,
                            width: 257,
                            child: DropdownButtonFormField(
                              hint: Text("Select Farm"),
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
                            "Agronomist",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 40,
                            width: 257,
                            child: DropdownButtonFormField(
                              hint: Text("Select Agronomist"),
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
                            "Manager",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 40,
                            width: 257,
                            child: DropdownButtonFormField(
                              hint: Text("Select Manager"),
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
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 60,
                    width: double.infinity,
                    color: Color(0xFFF7F9EA),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 40,
                        top: 18,
                      ),
                      child: Text(
                        "Allocating Farmer & Labourer",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Block",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 40,
                            width: 257,
                            child: DropdownButtonFormField(
                              hint: Text("Select Block"),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Field",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 40,
                            width: 257,
                            child: DropdownButtonFormField(
                              hint: Text("Select Field"),
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
                            "Farmer",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 40,
                            width: 257,
                            child: DropdownButtonFormField(
                              hint: Text("Select Farmer"),
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
                            "Labourer",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 40,
                            width: 257,
                            child: DropdownButtonFormField(
                              hint: Text("Select Labourer"),
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
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 296,
                        height: 40,
                        child: CustomElevatedButton(
                          onPressed: () {},
                          title: "Submit",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Question extends StatelessWidget {
  const Question({Key? key, required this.sentence, required this.number})
      : super(key: key);
  final String sentence;
  final String number;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                number,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Text(
                      sentence,
                      maxLines: 2,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 22,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {},
                child: Card(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Color(0xFF327C04)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(50, 8, 50, 8),
                    child: Text(
                      "Yes",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 40,
              ),
              InkWell(
                onTap: () {},
                child: Card(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Color(0xFF327C04)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(50, 8, 50, 8),
                    child: Text(
                      "No",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 40,
              ),
              InkWell(
                onTap: () {},
                child: Card(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Color(0xFF327C04)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(50, 8, 50, 8),
                    child: Text(
                      "Maybe",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  height: 50,
                  width: 815,
                  child: TextInputField(
                      hintText: "Enter Text", validatorText: "validatorText")),
              SizedBox(
                width: 30,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset("assets/images/upload.png")
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
