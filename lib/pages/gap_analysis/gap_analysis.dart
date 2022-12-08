import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/custom_Elevated_Button.dart';
import 'package:flutter_agro_new/component/dropdown_btn.dart';
import 'package:flutter_agro_new/component/text_Input_field.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:flutter_agro_new/database_api/methods/gap_question_method.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../database_api/models/gapQuestionModel.dart';

class GapAnalysis extends StatefulWidget {
  GapAnalysis({Key? key}) : super(key: key);

  @override
  State<GapAnalysis> createState() => _GapAnalysisState();
}

class _GapAnalysisState extends State<GapAnalysis> {
  String? currentgapCat;

  bool check1 = false;
  bool check2 = false;
  bool check3 = false;

  Future<String> addGap() async {
    debugPrint("reached");
    Map<String, dynamic> updata = {
      "gap_category_name": "Farming",
      "question": "What type of irrigation should i use",
      "options": 1,
      "text": 0,
      "image": 1
    };
    return await addGapAPI(updata);
  }

  Future<String> addGapAPI(Map<String, dynamic> updata) async {
    final _chuckerHttpClient = await http.Client();
    print(updata);
    final prefs = await SharedPreferences.getInstance();
    http.Response response = await _chuckerHttpClient.post(
      Uri.parse("https://agromate.website/laravel/api/gap_category"),
      body: updata,
    );
    print(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      return 'null';
    } else {
      return 'throw (Exception("Search Error"))';
    }
  }

  late final Future myfuture;
  @override
  void initState() {
    super.initState();
    myfuture = GapQuestionMethods().getCategory();
  }

  late String _selectedValue;
  List<String> listOfValue = [
    'Farming',
    'Irrigation',
    'packaging',
    'Transport',
  ];

  List<String> gap_cat = [];
  bool _isonce = true;
  setValues() {
    if (_isonce) {
      for (var i = 0; i < gapData.data!.length; i++) {
        gap_cat.add(gapData.data![i].gapCategory!);
      }
      _isonce = false;
    }
  }

  buildPinAlert() {
    return showDialog(
        context: context, builder: (context) => _buildbody(context));
  }

  Widget _buildbody(context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return FutureBuilder(
          future: myfuture,
          builder: (ctx, snapshot) {
            if (snapshot.data == null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.45,
                  ),
                  Center(child: CircularProgressIndicator()),
                ],
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              setValues();
              print("data from rsp ${snapshot.data}");
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occured',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }
            }
            return _buildBody2(context, setState);
          },
        );
      },
    );
  }

  Widget _buildBody2(context, setState) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AlertDialog(
          insetPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          contentPadding: EdgeInsets.fromLTRB(24, 8, 24, 24),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "New Gap Analysis",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.cancel_outlined,
                  color: Color(0xFF4E944F),
                ),
              )
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Category"),
                      SizedBox(
                        height: 15,
                        // ignore: prefer_const_literals_to_create_immutables
                      ),
                      SizedBox(
                        height: 40,
                        width: 330,
                        child: SizedBox(
                          width: 500,
                          child: DropdownBtn(
                            items: gap_cat,
                            hint: 'Select Category',
                            onItemSelected: (value) async {
                              setState(() {
                                currentgapCat = value;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Question",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 40,
                        width: 330,
                        child: TextFormField(
                          controller: questionTextEditingController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 10, top: 25, right: 10),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0xFF327C04)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0xFF327C04)),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF327C04),
                                width: 5.0,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Theme(
                        data: ThemeData(
                          unselectedWidgetColor: Color(0xff327C04),
                        ),
                        child: Checkbox(
                          activeColor: Color(0xff327C04),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0))),
                          value: check1,
                          onChanged: (check) {
                            setState(() {
                              check1 = check!;
                            });
                          },
                        ),
                      ),
                      Text(
                        "Options",
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Theme(
                        data: ThemeData(
                          unselectedWidgetColor: Color(0xff327C04),
                        ),
                        child: Checkbox(
                          activeColor: Color(0xff327C04),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0))),
                          value: check2,
                          onChanged: (check) {
                            setState(() {
                              check2 = check!;
                            });
                          },
                        ),
                      ),
                      Text(
                        "Text",
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Theme(
                        data: ThemeData(
                          unselectedWidgetColor: Color(0xff327C04),
                        ),
                        child: Checkbox(
                          activeColor: Color(0xff327C04),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0))),
                          value: check3,
                          onChanged: (check) {
                            setState(() {
                              check3 = check!;
                            });
                          },
                        ),
                      ),
                      Text(
                        "Image",
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Color(0xFF327C04)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: Text("Yes"),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Color(0xFF327C04)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: Text("No"),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Color(0xFF327C04)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: Text("Maybe"),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 40,
                width: 170,
                child: CustomElevatedButton(
                  title: "ADD",
                  onPressed: () {
                    addGap();
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String? currentCategory;
  int? currentCategoryId;

  final questionTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          TopBar(),
          SizedBox(
            height: 45,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                              "assets/images/tasks-list-svgrepo-com.png"),
                          SizedBox(
                            width: 25,
                          ),
                          Text(
                            "Gap Questions",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                        width: 92,
                        child: ElevatedButton(
                            onPressed: () {
                              buildPinAlert();
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
                                  'ADD',
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
                      "Title : Farming",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.6,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Question(
                            sentence:
                                "Crop production areas are not located near or adjacent to dairy, livestock, or fowl production facilities unless adequate barriers exist.",
                            number: "1)"),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Question(
                            sentence:
                                "A water quality assessment has been performed to determine the quality of water used for irrigation purpose on the crop(s) being applied.",
                            number: "2)"),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Question(
                            sentence:
                                "Crop production areas are not located near or adjacent to dairy, livestock, or fowl production facilities unless adequate barriers exist.",
                            number: "3)")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
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
                style: TextStyle(fontSize: 16, color: Colors.black),
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
                      style: TextStyle(fontSize: 16, color: Colors.black),
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
              SizedBox(
                  height: 30,
                  width: 140,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 1, color: Color(0xFF327C04)),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Yes",
                        style: TextStyle(color: Color(0xFF327C04)),
                      ))),
              SizedBox(
                width: 40,
              ),
              SizedBox(
                  height: 30,
                  width: 140,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 1, color: Color(0xFF327C04)),
                      ),
                      onPressed: () {},
                      child: Text(
                        "No",
                        style: TextStyle(color: Color(0xFF327C04)),
                      ))),
              SizedBox(
                width: 40,
              ),
              SizedBox(
                  height: 30,
                  width: 140,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 1, color: Color(0xFF327C04)),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Maybe",
                        style: TextStyle(color: Color(0xFF327C04)),
                      )))
            ],
          ),
          SizedBox(
            height: 18,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
                width: 450,
                child: TextInputField(
                  hintText: "Enter Text",
                  validatorText: "validatorText",
                ),
              ),
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
