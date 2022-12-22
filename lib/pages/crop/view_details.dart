import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_agro_new/component/custom_Elevated_Button.dart';
import 'package:flutter_agro_new/component/dropdown_btn.dart';
import 'package:flutter_agro_new/component/text_Input_field.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:flutter_agro_new/models/CropProgramTasksModel.dart';
import 'package:flutter_agro_new/pages/crop/Repository/CropProgramViaDioAPI.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../database_api/methods/gap_question_api_method.dart';
import '../../models/gap.dart';

final GlobalKey<FormState> form = GlobalKey<FormState>();

late CropProgramTasks cropdata;

String CategorySelected = 'Select Category';
var categories = [
  'Select Category',
  'Chemical',
  'Fertiliser',
  'Pesticide',
  'Herbicide',
  'Fungicide'
];
String ActiveIngridientSelected = 'Select Ingredient';
var active = [
  'Select Ingredient',
  'Sulphur',
  'Ammonia',
  'Nitrogen',
  'Calcium',
  'Magnesium'
];
String StatusSelected = 'To Do';
var status = ['To Do', 'On Going', 'Completed'];
String UnitsSelected = 'Select Unit';
var units = [
  'Select Unit',
  'Kilogram',
  'Gram',
  'Liter',
  "Milliliter",
  "Pounds",
  "Tonnes"
];
String productdescriptionSelected = 'Select product description';
var productdescription = [
  'Select product description',
  'product description 1',
  'product description 2',
  'product description 3',
  "product description 4",
  "product description 5",
  "product description 6"
];

String AddGapQuestionSelected = 'Select product description';
var AddGapQuestion = [
  'Select Gap Question',
  'Gap Question 1',
  'Gap Question 2',
  'Gap Question 3',
  "Gap Question 4",
  "Gap Question 5",
  "Gap Question 6"
];

String WeeksSelected = 'Select product description';
var Weeks = [
  'Select Weeks',
  'Weeks 1',
  'Weeks 2',
  'Weeks 3',
  "Weeks 4",
  "Weeks 5",
  "Weeks 6"
];

class ViewDetails extends StatefulWidget {
  ViewDetails({Key? key, this.weeks, this.id}) : super(key: key);

  @override
  State<ViewDetails> createState() => _ViewDetailsState();

  final String? weeks;
  final String? id;
  int? initial;
}

class _ViewDetailsState extends State<ViewDetails> {
  String WeekSelected = 'Week 1';
  var wee = [''];

  TextEditingController controller = TextEditingController();
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController =
      TextEditingController();
  TextEditingController chemicaltitleTextEditingController =
      TextEditingController();
  TextEditingController quantityTextEditingController = TextEditingController();
  bool sort = true;
  List<SampleData>? filterData;
  late final Future myGapCat;
  String? currentgapCat;
  int? currentGapCatId;
  String? currentGapCat;
  List<String> gap_cat = [];

  // bool _isonce = true;
  // setValues() {
  //   if (_isonce) {
  //     for (var i = 0; i < gapData.data!.length; i++) {
  //       gap_cat.add(gapData.data![i].gapCategory!);
  //     }
  //     _isonce = false;
  //   }
  // }

  onsortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        filterData!.sort((a, b) => a.name!.compareTo(b.name!));
      } else {
        filterData!.sort((a, b) => b.name!.compareTo(a.name!));
      }
    }
  }

  generateListForweeks() {
    final items =
        List<String>.generate(int.parse(widget.weeks!), (i) => "Week ${i + 1}");
    // print("created list is $items");
    wee = items;
  }

  Future fetchCropProgram(id) async {
    var client = http.Client();
    final response = await client.get(Uri.parse(
        'https://agromate.website/laravel/api/crop_program_task/$id'));
    final parsed = jsonDecode(response.body);
    print("api call data cp ${response.body}");
    cropdata = CropProgramTasks.fromJson(parsed);

    // return cropdata;
  }

  Future<String> addTask(id) async {
    Map<String, dynamic> updata = {
      "cropprogramid": id,
      "week": WeekSelected,
      "status": StatusSelected,
      "title": titleTextEditingController.text,
      "description": descriptionTextEditingController.text,
      "category": CategorySelected,
      "chemical": productdescriptionSelected,
      "activeingridient": ActiveIngridientSelected,
      "quantity": quantityTextEditingController.text,
      "unit": UnitsSelected
    };
    return await addTaskAPI(updata);
  }

  Future<String> addTaskAPI(Map<String, dynamic> updata) async {
    final _chuckerHttpClient = await http.Client();
    print(updata);
    final prefs = await SharedPreferences.getInstance();
    http.Response response = await _chuckerHttpClient.post(
      Uri.parse("https://agromate.website/laravel/api/programtask"),
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

  @override
  void initState() {
    filterData = myData;
    super.initState();
    myGapCat = GapCatAPI.fetchgapcat();
    fetchCropProgram(widget.id);
    generateListForweeks();
  }

  buildPin() {
    controller.clear();
    titleTextEditingController.clear();
    descriptionTextEditingController.clear();
    chemicaltitleTextEditingController.clear();
    quantityTextEditingController.clear();
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Form(
            key: form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  contentPadding: EdgeInsets.only(top: 10.0),
                  content: Padding(
                    padding: EdgeInsets.only(
                        top: 0, left: 25, right: 25, bottom: 25),
                    child: Column(
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
                              "Add New Task",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Weeks",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8),
                                SizedBox(
                                  width: 300,
                                  child: DropdownButtonFormField(
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
                                        color: const Color(0xff327C04)
                                            .withOpacity(0.5),
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
                                    value: WeekSelected,
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
                                    items: wee.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        WeekSelected = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Status",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8),
                                SizedBox(
                                  width: 300,
                                  child: DropdownButtonFormField(
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
                                        color: const Color(0xff327C04)
                                            .withOpacity(0.5),
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
                                    value: StatusSelected,
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
                                    items: status.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        StatusSelected = newValue!;
                                      });
                                    },
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
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Title",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8),
                                SizedBox(
                                    width: 300,
                                    child: TextInputField(
                                        // inputFormatters: [
                                        //   LengthLimitingTextInputFormatter(
                                        //       25),
                                        //   FilteringTextInputFormatter.allow(
                                        //       RegExp('[a-zA-Z]')),
                                        // ],
                                        // textEditingController:
                                        //     cropTextEditingController,
                                        textEditingController:
                                            titleTextEditingController,
                                        hintText: "",
                                        validator: (value) {
                                          if (value != null && value.isEmpty) {
                                            return "Please Enter Title";
                                          }
                                          return null;
                                        },
                                        validatorText: ""))
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Description",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8),
                                SizedBox(
                                    width: 300,
                                    child: TextInputField(
                                        // inputFormatters: [
                                        //   LengthLimitingTextInputFormatter(
                                        //       6),
                                        //   FilteringTextInputFormatter
                                        //       .digitsOnly
                                        // ],
                                        // textEditingController:
                                        //     yieldTextEditingController,
                                        textEditingController:
                                            descriptionTextEditingController,
                                        hintText: "",
                                        validator: (value) {
                                          if (value != null && value.isEmpty) {
                                            return "Please Enter Description";
                                          }
                                          return null;
                                        },
                                        validatorText: ""))
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Category",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8),
                                SizedBox(
                                  width: 300,
                                  child: DropdownButtonFormField(
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
                                        color: const Color(0xff327C04)
                                            .withOpacity(0.5),
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
                                    value: CategorySelected,
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
                                    items: categories.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        CategorySelected = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Product Description",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8),
                                SizedBox(
                                  width: 300,
                                  child: DropdownButtonFormField(
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
                                        color: const Color(0xff327C04)
                                            .withOpacity(0.5),
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
                                    value: productdescriptionSelected,
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
                                    items:
                                        productdescription.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        productdescriptionSelected = newValue!;
                                      });
                                    },
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
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Active Ingridient",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8),
                                SizedBox(
                                  width: 300,
                                  child: DropdownButtonFormField(
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
                                        color: const Color(0xff327C04)
                                            .withOpacity(0.5),
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
                                    value: ActiveIngridientSelected,
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
                                    items: active.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        ActiveIngridientSelected = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Quantity",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8),
                                SizedBox(
                                    width: 140,
                                    child: TextInputField(
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(6),
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        // textEditingController:
                                        //     weeksTextEditingController,
                                        textEditingController:
                                            quantityTextEditingController,
                                        hintText: "",
                                        validator: (value) {
                                          if (value != null && value.isEmpty) {
                                            return "Please Enter Quantity";
                                          }
                                          return null;
                                        },
                                        validatorText: "")),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Units",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8),
                                SizedBox(
                                  width: 140,
                                  child: DropdownButtonFormField(
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
                                        color: const Color(0xff327C04)
                                            .withOpacity(0.5),
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
                                    value: UnitsSelected,
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
                                    items: units.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        UnitsSelected = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 40,
                              width: 296,
                              child: CustomElevatedButton(
                                onPressed: () {
                                  fetchCropProgram(widget.id);
                                  final isValid = form.currentState?.validate();
                                  debugPrint(WeekSelected);
                                  debugPrint(StatusSelected);
                                  debugPrint(CategorySelected);
                                  debugPrint(ActiveIngridientSelected);
                                  debugPrint(UnitsSelected);
                                  debugPrint(titleTextEditingController.text);
                                  debugPrint(
                                      descriptionTextEditingController.text);
                                  debugPrint(
                                      chemicaltitleTextEditingController.text);
                                  debugPrint(
                                      quantityTextEditingController.text);
                                  //  addTask();
                                  if (isValid!) {
                                    setState(() {
                                      addTask(widget.id).then(
                                        (value) => Navigator.pop(context),
                                      );
                                      Flushbar(
                                        duration: const Duration(seconds: 2),
                                        message: "New Task Added Successfully",
                                      ).show(context);
                                    });
                                  } else {
                                    Flushbar(
                                      duration: const Duration(seconds: 2),
                                      message: "Please Enter All Details",
                                    ).show(context);
                                  }
                                  // addCropProgram();
                                  // Navigator.pop(context);
                                },
                                title: "Add",
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  buildPinData(element) {
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      element,
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

  bool check8 = false;
  bool check9 = false;
  bool check10 = false;
  bool check11 = false;

  buildPinAlert() {
    return showDialog(
        context: context, builder: (context) => buildbody(context));
  }

  Widget buildbody(context) {
    return StatefulBuilder(builder: (context, setState) {
      return FutureBuilder(
          future: myGapCat,
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
              // setValues();
              print("data from rsp ${snapshot.data}");
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occured',
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              }
            }
            var data = snapshot.data!;

            var fetchedcategorylist = data as List<GapQuestionListModel>;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AlertDialog(
                  insetPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  contentPadding: EdgeInsets.fromLTRB(24, 8, 24, 24),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "GAP Analysis",
                        style: TextStyle(
                            fontSize: 27, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
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
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Category",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 40,
                                        width: 300,
                                        child: DropdownBtn(
                                          items: fetchedcategorylist.map((e) {
                                            return e.gapCategory.toString();
                                          }).toList(),
                                          hint: 'Select GAP Category',
                                          onItemSelected: (value) async {
                                            setState(() {
                                              currentGapCat = value;
                                              currentGapCatId =
                                                  fetchedcategorylist
                                                      .singleWhere((element) =>
                                                          element.gapCategory ==
                                                          currentGapCat)
                                                      .id;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Weeks",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 40,
                                        width: 300,
                                        child: DropdownButtonFormField(
                                          hint: Text("Select Weeks"),
                                          focusColor: Colors.white,
                                          isExpanded: true,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                left: 10, top: 10, right: 10),
                                            fillColor: Colors.white,
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                  color: Color(0xFF327C04)),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                  color: Color(0xFF327C04)),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFF327C04),
                                                width: 5.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          items: wee.map((String val) {
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
                                              WeekSelected;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Row(
                                children: [
                                  Theme(
                                    data: ThemeData(
                                        unselectedWidgetColor:
                                            Color(0xFF4E944F)),
                                    child: Checkbox(
                                      activeColor: const Color(0xFF4E944F),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0))),
                                      value: check8,
                                      onChanged: (bool? check) {
                                        setState(() {
                                          this.check8 = check!;
                                        });
                                      },
                                    ),
                                  ),
                                  Text(
                                    "Crop production areas are not located near  or adjacent to diary, livestock, or \n fowl production facilities  unless adequate  barriers exists.",
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Theme(
                                    data: ThemeData(
                                        unselectedWidgetColor:
                                            Color(0xFF4E944F)),
                                    child: Checkbox(
                                      activeColor: const Color(0xFF4E944F),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0))),
                                      value: check9,
                                      onChanged: (bool? check) {
                                        setState(() {
                                          this.check9 = check!;
                                        });
                                      },
                                    ),
                                  ),
                                  Text(
                                    "Crop production areas are not located near  or adjacent to diary, livestock, or \n fowl production facilities  unless adequate  barriers exists.",
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Theme(
                                    data: ThemeData(
                                        unselectedWidgetColor:
                                            Color(0xFF4E944F)),
                                    child: Checkbox(
                                      activeColor: const Color(0xFF4E944F),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0))),
                                      value: check10,
                                      onChanged: (bool? check) {
                                        setState(() {
                                          this.check10 = check!;
                                        });
                                      },
                                    ),
                                  ),
                                  Text(
                                    "Crop production areas are not located near  or adjacent to diary, livestock, or \n fowl production facilities  unless adequate  barriers exists.",
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Theme(
                                    data: ThemeData(
                                        unselectedWidgetColor:
                                            Color(0xFF4E944F)),
                                    child: Checkbox(
                                      activeColor: const Color(0xFF4E944F),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0))),
                                      value: check11,
                                      onChanged: (bool? check) {
                                        setState(() {
                                          this.check11 = check!;
                                        });
                                      },
                                    ),
                                  ),
                                  Text(
                                    "Crop production areas are not located near  or adjacent to diary, livestock, or \n fowl production facilities  unless adequate  barriers exists.",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 40,
                        width: 170,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0XFF327C04),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("ADD"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          });
    });
  }

  Widget _buildgridview(context, weeks, List<Data> data, id) {
    final screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: (0.5 / 0.8),
              crossAxisCount: 4,
              mainAxisSpacing: 2,
              crossAxisSpacing: 3),
          itemCount: int.parse(weeks),
          itemBuilder: (BuildContext ctx, index) {
            String weekName = "Week ${index + 1}";
            var filtered = diocropdata.data!
                .where((element) => (element.week == weekName))
                .toList();

            return Card(
              elevation: 2,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Week ${index + 1}"),
                    filtered.isNotEmpty
                        ? SizedBox(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: screenSize.height * 0.7,
                                    child: ListView.builder(
                                      itemCount: filtered.length,
                                      itemBuilder: (context, index) {
                                        var element = filtered.elementAt(index);
                                        return InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  StatefulBuilder(
                                                builder: (context, setState) {
                                                  return Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      AlertDialog(
                                                        // insetPadding:
                                                        //     EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                                        // contentPadding: EdgeInsets.fromLTRB(24, 8, 24, 24),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10))),
                                                        title: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              element.week
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            IconButton(
                                                                onPressed: () {
                                                                  Get.back();
                                                                },
                                                                icon: Icon(
                                                                  Icons
                                                                      .cancel_outlined,
                                                                ))
                                                          ],
                                                        ),
                                                        content: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "Title : ${element.title}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                SizedBox(
                                                                  width: 50,
                                                                ),
                                                                Text(
                                                                  "Status : ${element.status}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
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
                                                              "Description : ${element.description}",
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Category  : ${element.category}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                SizedBox(
                                                                  width: 250,
                                                                ),
                                                                Text(
                                                                  "Chemical : ${element.chemical}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Active Ingredients : ${element.activeingridient}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                SizedBox(
                                                                  width: 250,
                                                                ),
                                                                Text(
                                                                  "Quantity : ${element.quantity} ${element.units}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Text(
                                                              "Time of application : Moderate Wind speed",
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Text(
                                                              "Modes of application : Tractor",
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Warnings :  ",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Icon(
                                                                    Icons.star),
                                                                Text(
                                                                  "         May cause sensitisation by skin contact",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
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
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Icon(
                                                                    Icons.star),
                                                                Text(
                                                                  "      Wear a mask",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 30,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
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
                                          },
                                          child: Card(
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            color: const Color(0xFFEBF2EB),
                                            child: SizedBox(
                                              height: screenSize.height * 0.15,
                                              width: 300,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Icon(Icons
                                                            .check_circle_outline),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          filtered
                                                                  .elementAt(
                                                                      index)
                                                                  .title ??
                                                              "",
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      filtered
                                                              .elementAt(index)
                                                              .description ??
                                                          "",
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/empty.png',
                                height: 200,
                                width: 150,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text("No Tasks Added Here"),
                            ],
                          )
                  ],
                ),
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      initialIndex: widget.initial ?? 0,
      length: 2,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopBar(),
            const SizedBox(height: 10),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            InkWell(
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Color(0xff327C04),
                              ),
                            ),
                            // const SizedBox(width: 10),
                            const Text(
                              'Crop Program Details',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 42,
                              width: 125,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      const Color(0XFF327C04),
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    buildPinAlert();
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: Color(0xffffffff),
                                        size: 20,
                                      ),
                                      Text(
                                        "ADD GAP",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xffffffff)),
                                      )
                                    ],
                                  )),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                buildPin();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF327C04),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 9),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.add,
                                        color: Color(0xffffffff),
                                        size: 20,
                                      ),
                                      const SizedBox(width: 6),
                                      const Text(
                                        'Add',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xffffffff)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: SizedBox(
                                width: 250,
                                child: CupertinoSearchTextField(
                                  onChanged: (value) {
                                    // setState(() {
                                    //   myData = cropdata.data!
                                    //       .where(
                                    //         (element) => element.crop!
                                    //             .toLowerCase()
                                    //             .contains(
                                    //               value.toLowerCase(),
                                    //             ),
                                    //       )
                                    //       .toList();
                                    // });
                                  },
                                  controller: controller,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xFF327C04),
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                    color: const Color(0xff327C04)
                                        .withOpacity(0.11),
                                  ),
                                  itemSize: 25,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff000000),
                                  ),
                                  prefixInsets:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          10, 8, 0, 8),
                                  placeholder: 'Search',
                                  suffixInsets:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 15, 2),
                                  placeholderStyle: TextStyle(
                                    fontSize: 16,
                                    color: const Color(0xff000000)
                                        .withOpacity(0.38),
                                  ),
                                  padding: const EdgeInsets.only(
                                    left: 5,
                                    top: 0,
                                    bottom: 0,
                                    right: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              height: 5,
              color: Colors.grey,
              thickness: 1,
            ),
            const SizedBox(
              width: 300,
              height: 50,
              child: TabBar(
                indicatorColor: Color(0xFF327C04),
                labelColor: Colors.black,
                unselectedLabelStyle: TextStyle(color: Color(0xFF6B6B6B)),
                labelStyle: TextStyle(
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                tabs: [
                  Tab(
                    text: 'Grid',
                  ),
                  Tab(
                    text: 'Table',
                  )
                ],
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.7,
              child: TabBarView(children: [
                FutureBuilder(
                  future: getCropProgramData().getSecurityQuestions(
                      int.parse(widget.id!)), //fetchCropProgram(1),
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
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            '${snapshot.error} occured',
                            style: TextStyle(fontSize: 18),
                          ),
                        );
                      }
                    }
                    return _buildgridview(
                        context, widget.weeks, diocropdata.data!, widget.id);
                  },
                ),
                datatable(widget.weeks)
                // FutureBuilder<CropProgramTasks>(
                //   future: fetchCropProgram(widget.id),
                //   builder: (ctx, snapshot) {
                //     if (snapshot.connectionState == ConnectionState.done) {
                //       if (snapshot.hasData) {
                //         return datatable(widget.weeks);
                //       } else {
                //         return Center(
                //           child: Text(
                //             '${snapshot.error} occured',
                //             style: const TextStyle(fontSize: 18),
                //           ),
                //         );
                //       }
                //     }
                //     return const Center(child: CircularProgressIndicator());
                //   },
                // )
              ]),
            ),
          ],
        ),
      ),
    );
  }

  datatable(weeks) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(20),
      child: SizedBox(
        height: screenSize.height * 0.6,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(0.0),
            decoration: const BoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: PaginatedDataTable(
                    sortColumnIndex: 0,
                    sortAscending: sort,
                    source: RowSource(
                      weeks: int.parse(weeks),
                      myData: myData,
                      count: myData.length,
                    ),
                    rowsPerPage: 8,
                    columnSpacing: 0,
                    headingRowHeight: 50,
                    horizontalMargin: 0,
                    columns: [
                      DataColumn(
                        label: Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xff327C04).withOpacity(0.11),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Inventory Type",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xff327C04).withOpacity(0.11),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Stock Code",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xff327C04).withOpacity(0.11),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Inventory Class",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xff327C04).withOpacity(0.11),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Description",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xff327C04).withOpacity(0.11),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Unit",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xff327C04).withOpacity(0.11),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Stock Level",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xff327C04).withOpacity(0.11),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Required",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xff327C04).withOpacity(0.11),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Pre PI",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xff327C04).withOpacity(0.11),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "PI",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      for (int length = 1;
                          length <= int.parse(widget.weeks!);
                          length++)
                        DataColumn(
                          label: Expanded(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xff327C04).withOpacity(0.11),
                              ),
                              child: Center(
                                child: Text(
                                  "W${length}",
                                  // "w",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ),

                      // DataColumn(
                      //   label: Expanded(
                      //     child: Container(
                      //       height: 50,
                      //       decoration: BoxDecoration(
                      //         color: const Color(0xff327C04).withOpacity(0.11),
                      //       ),
                      //       child: const Center(
                      //         child: Text(
                      //           "W2",
                      //           textAlign: TextAlign.center,
                      //           style: TextStyle(
                      //               fontWeight: FontWeight.w500, fontSize: 14),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // DataColumn(
                      //   label: Expanded(
                      //     child: Container(
                      //       height: 50,
                      //       decoration: BoxDecoration(
                      //         color: const Color(0xff327C04).withOpacity(0.11),
                      //       ),
                      //       child: const Center(
                      //         child: Text(
                      //           "W3",
                      //           textAlign: TextAlign.center,
                      //           style: TextStyle(
                      //               fontWeight: FontWeight.w500, fontSize: 14),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // DataColumn(
                      //   label: Expanded(
                      //     child: Container(
                      //       height: 50,
                      //       decoration: BoxDecoration(
                      //         color: const Color(0xff327C04).withOpacity(0.11),
                      //       ),
                      //       child: const Center(
                      //         child: Text(
                      //           "W4",
                      //           textAlign: TextAlign.center,
                      //           style: TextStyle(
                      //               fontWeight: FontWeight.w500, fontSize: 14),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // DataColumn(
                      //   label: Expanded(
                      //     child: Container(
                      //       height: 50,
                      //       decoration: BoxDecoration(
                      //         color: const Color(0xff327C04).withOpacity(0.11),
                      //       ),
                      //       child: const Center(
                      //         child: Text(
                      //           "W5",
                      //           textAlign: TextAlign.center,
                      //           style: TextStyle(
                      //               fontWeight: FontWeight.w500, fontSize: 14),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RowSource extends DataTableSource {
  var myData;
  final count;
  int weeks;
  RowSource({
    required this.myData,
    required this.count,
    required this.weeks,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRow(myData![index], weeks);
    } else {
      return null;
    }
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;
}

DataRow recentFileDataRow(var data, int weeks) {
  return DataRow(
    cells: [
      DataCell(Align(
          alignment: Alignment.center,
          child: Padding(
              padding: EdgeInsets.all(10), child: Text(data.name ?? "Name")))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(data.stockCode.toString())))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(data.inventory.toString())))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Padding(
              padding: EdgeInsets.all(10), child: Text(data.desc.toString())))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Padding(
              padding: EdgeInsets.all(10), child: Text(data.unit.toString())))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(data.stockL.toString())))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(data.required.toString())))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(data.prepi.toString())))),
      DataCell(
          Align(alignment: Alignment.center, child: Text(data.pi.toString()))),
      for (int length = 1; length <= weeks; length++)
        DataCell(Align(
            alignment: Alignment.center,
            child: Padding(padding: EdgeInsets.all(10), child: Text("500")))),
      // DataCell(
      //     Align(alignment: Alignment.center, child: Text(data.w2.toString()))),
      // DataCell(
      //     Align(alignment: Alignment.center, child: Text(data.w3.toString()))),
      // DataCell(
      //     Align(alignment: Alignment.center, child: Text(data.w4.toString()))),
      // DataCell(
      //     Align(alignment: Alignment.center, child: Text(data.w5.toString()))),
    ],
  );
}

class SampleData {
  String? name;
  String? stockCode;
  String? inventory;
  String? desc;
  String? unit;
  String? stockL;
  String? required;
  String? prepi;
  String? pi;
  String? w1;
  String? w2;
  String? w3;
  String? w4;
  String? w5;

  SampleData({
    required this.name,
    required this.stockCode,
    required this.inventory,
    required this.desc,
    required this.unit,
    required this.stockL,
    required this.required,
    required this.prepi,
    required this.pi,
    required this.w1,
    required this.w2,
    required this.w3,
    required this.w4,
    required this.w5,
  });
}

List<SampleData> myData = [
  SampleData(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  SampleData(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  SampleData(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  SampleData(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  SampleData(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  SampleData(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  SampleData(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  SampleData(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  SampleData(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  SampleData(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  SampleData(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  SampleData(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
];
