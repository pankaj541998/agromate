import 'dart:async';
import 'dart:core';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../component/custom_Elevated_Button.dart';
import '../../component/text_Input_field.dart';
import 'package:http/http.dart' as http;
import '../../models/CropProgramTasksModel.dart';
import '../../models/crop_schedule_task_model.dart';
import '../crop/Repository/CropProgramViaDioAPI.dart';

final GlobalKey<FormState> _form = GlobalKey<FormState>();

late CropProgramTasks cropdata;

String WeekSelected = 'Week 1';
var week = ['Week 1', 'Week 2', 'Week 3', 'Week 4', 'Week 5'];
String CategorySelected = 'Select Category';
var categories = ['Select Category', 'Cat1', 'Cat2', 'Cat3', 'Cat4', 'Cat5'];
String ActiveIngridientSelected = 'Select Ingredient';
var active = [
  'Select Ingredient',
  'Active Ingridient 1',
  'Active Ingridient 2',
  'Active Ingridient 3',
  'Active Ingridient 4',
  'Active Ingridient 5'
];
String taskStatusSelected = 'To Do';
var taskstatus = ['To Do', 'On Going', 'Completed'];
String taskUnitsSelected = 'Select Unit';
var taskunits = [
  'Select Unit',
  'Kilogram',
  'Gram',
  'Liter',
  "Milliliter",
  "Pounds",
  "Tonnes"
];

class WeeklyTasks extends StatefulWidget {
  const WeeklyTasks(
      {Key? key,
      this.id,
      this.weeks,
      this.farmsend,
      this.blocksend,
      this.fieldsend,
      this.cropsend,
      this.cropplanid})
      : super(key: key);

  @override
  State<WeeklyTasks> createState() => _WeeklyTasksState();
  final String? weeks;
  final String? id;
  final String? cropplanid;

  final String? farmsend;
  final String? blocksend;
  final String? fieldsend;
  final String? cropsend;
}

// Future<RegisteredUserModel> fetchRegisteredUsers() async {
//   var client = http.Client();
//   final response = await client
//       .get(Uri.parse('https://agromate.website/laravel/api/get/plan'));
//   final parsed = jsonDecode(response.body);
//   // print(response.body);
//   registeredusers = RegisteredUserModel.fromJson(parsed);
//   // print(registeredusers.data!.elementAt(1).firstName!);
//   return registeredusers;
// }

class _WeeklyTasksState extends State<WeeklyTasks> {
  TextEditingController tasktitleTextEditingController =
      TextEditingController();
  TextEditingController taskdescriptionTextEditingController =
      TextEditingController();
  TextEditingController taskchemicaltitleTextEditingController =
      TextEditingController();
  TextEditingController taskquantityTextEditingController =
      TextEditingController();
  final StreamController<bool> weeklytaskcontroller =
      StreamController<bool>.broadcast();
  String WeekSelected = 'Week 1';
  var wee = [''];

  generateListForweeks() {
    final items = List<String>.generate(4, (i) => "Week ${i + 1}");
    // print("created list is $items");
    wee = items;
  }

  String questionsSelected = 'Potato';
  var questions = ['Potato', 'Carrot', 'Onion', 'Cabbage'];

  String tasklandeholderSelected = 'Kishan';
  var tasklandeholder = ['Kishan', 'Raj', 'Reethik'];
  String taskfarmSelected = 'Farm 1';
  var taskfarm = ['Farm 1', 'Farm 2', 'Farm 3'];
  String taskblockselected = 'Carrots';
  var crop = ['Green Mielies', 'Carrots', 'Sweet Corn'];
  String taskFieldselected = 'Car';
  var taskfield = ['Green ', 'Car', 'Sweet'];
  List<bool> expanded = [false, false];
  int selected = 0; //attention
  int subselected = 0; //attention
  var taskid;

  addWeeklyTask(cropprogramid) async {
    debugPrint("reached");
    Map<String, dynamic> updata = {
      "crop_plan_id": widget.cropplanid.toString(),
      // "cropprogramid": cropprogramid,
      "week": WeekSelected,
      "status": taskStatusSelected,
      "title": tasktitleTextEditingController.text,
      "description": taskdescriptionTextEditingController.text,
      "category": CategorySelected,
      "chemical": taskchemicaltitleTextEditingController.text,
      "activeingridient": ActiveIngridientSelected,
      "quantity": taskquantityTextEditingController.text,
      "unit": taskUnitsSelected
    };
    addTaskAPI(updata);
  }

  addTaskAPI(Map<String, dynamic> updata) async {
    final _chuckerHttpClient = await http.Client();
    print(updata);
    final prefs = await SharedPreferences.getInstance();
    http.Response response = await _chuckerHttpClient.post(
      Uri.parse(" https://agromate.website/laravel/api/add_task"),
      body: updata,
    );
    print(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      Flushbar(
        duration: const Duration(seconds: 2),
        message: "New Task Added Successfully",
      ).show(context);
      return 'null';
    } else {
      return 'throw (Exception("Search Error"))';
    }
  }

  @override
  void initState() {
    super.initState();
    //fetchCropProgram(widget.id);
    taskid = widget.id;
    generateListForweeks();
  }

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
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  buildPinAlert() {
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Form(
            key: _form,
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
                                    items: week.map((String items) {
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
                                    value: taskStatusSelected,
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
                                    items: taskstatus.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        taskStatusSelected = newValue!;
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
                                            tasktitleTextEditingController,
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
                                            taskdescriptionTextEditingController,
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
                                  "Chemical",
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
                                        //     weeksTextEditingController,
                                        textEditingController:
                                            taskchemicaltitleTextEditingController,
                                        hintText: "",
                                        validator: (value) {
                                          if (value != null && value.isEmpty) {
                                            return "Please Chemical";
                                          }
                                          return null;
                                        },
                                        validatorText: "")),
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
                                        // inputFormatters: [
                                        //   LengthLimitingTextInputFormatter(
                                        //       6),
                                        //   FilteringTextInputFormatter
                                        //       .digitsOnly
                                        // ],
                                        // textEditingController:
                                        //     weeksTextEditingController,
                                        textEditingController:
                                            taskquantityTextEditingController,
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
                                    value: taskUnitsSelected,
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
                                    items: taskunits.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        taskUnitsSelected = newValue!;
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
                                onPressed: () async {
                                  final isValid =
                                      _form.currentState?.validate();
                                  debugPrint(WeekSelected);
                                  debugPrint(taskStatusSelected);
                                  debugPrint(CategorySelected);
                                  debugPrint(ActiveIngridientSelected);
                                  debugPrint(taskUnitsSelected);
                                  debugPrint(
                                      tasktitleTextEditingController.text);
                                  debugPrint(
                                      taskdescriptionTextEditingController
                                          .text);
                                  debugPrint(
                                      taskchemicaltitleTextEditingController
                                          .text);
                                  debugPrint(
                                      taskquantityTextEditingController.text);
                                  debugPrint(widget.cropplanid.toString());
                                  if (isValid!) {
                                    // setState(() {
                                    //   addCropProgram().then((value) =>
                                    //       Navigator.pushNamed(
                                    //           context, '/table_view_crop'));
                                    // });
                                    addWeeklyTask(taskid);
                                    weeklytaskcontroller.add(true);
                                    Navigator.pop(context);
                                  } else {
                                    // Flushbar(
                                    //   duration: const Duration(seconds: 2),
                                    //   message: "Please Enter All Details",
                                    // ).show(context);
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
                    InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back_ios_rounded)),
                    SizedBox(width: screenSize.width * 0.02),
                    Text(
                      "Tasks",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        buildPinAlert();
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
                                    fontSize: 16, color: Color(0xffffffff)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
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
                    Text(
                      widget.farmsend.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_circle_right_outlined),
                    SizedBox(width: 10),
                    Text(
                      widget.blocksend.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_circle_right_outlined),
                    SizedBox(width: 10),
                    Text(
                      widget.fieldsend.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_circle_right_outlined),
                    SizedBox(width: 10),
                    Text(
                      widget.cropsend.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // accordian()
                SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: StreamBuilder<bool>(
                        stream: weeklytaskcontroller.stream,
                        builder: (context, snapshot) {
                          return FutureBuilder(
                            future: getCropProgramData().getSecurityQuestions(
                                int.parse(widget.id!)), //fetchCropProgram(1),
                            builder: (ctx, snapshot) {
                              if (snapshot.data == null) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.45,
                                    ),
                                    Center(child: CircularProgressIndicator()),
                                  ],
                                );
                              }
                              if (snapshot.data != null) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text(
                                      '${snapshot.error} occured',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  );
                                }
                              }

                              return _buildgridview(context, widget.weeks,
                                  diocropdata.data!, widget.id);
                            },
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildgridview(context, weeks, List<CropScheduleTasks> data, id) {
    final screenSize = MediaQuery.of(context).size;

    return GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: (0.5 / 0.8),
            crossAxisCount: 4,
            mainAxisSpacing: 2,
            crossAxisSpacing: 3),
        itemCount: int.parse(weeks),
        itemBuilder: (BuildContext ctx, index) {
          //  var element = CropProgram.cropPrograms.elementAt(index);
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
                  // SizedBox(
                  //   height: screenSize.height * 0.2,
                  //   child: Card(
                  //     elevation: 2,
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(20)),
                  //     color: const Color(0xFFEBF2EB),
                  //     child: SizedBox(
                  //       height: screenSize.height * 0.15,
                  //       width: 300,
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(10),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Row(
                  //               children: [
                  //                 const Icon(Icons.check_circle_outline),
                  //                 SizedBox(
                  //                   width: 10,
                  //                 ),
                  //                 Text(
                  //                   "GAP Questions",
                  //                   style: TextStyle(fontSize: 14),
                  //                 )
                  //               ],
                  //             ),
                  //             SizedBox(
                  //               height: 10,
                  //             ),
                  //             Text(
                  //               "Answer these Questions",
                  //               style: TextStyle(fontSize: 12),
                  //             ),
                  //             SizedBox(
                  //               height: 10,
                  //             ),
                  //             Row(
                  //               children: [
                  //                 SizedBox(
                  //                   height: 20,
                  //                   child: Image.asset(
                  //                       "assets/images/taskperson.png"),
                  //                 ),
                  //                 SizedBox(
                  //                   width: 10,
                  //                 ),
                  //                 Icon(
                  //                   Icons.calendar_today_outlined,
                  //                   size: 18,
                  //                 ),
                  //                 SizedBox(
                  //                   width: 5,
                  //                 ),
                  //                 Text(
                  //                   "22/12/22",
                  //                   style: TextStyle(fontSize: 14),
                  //                 )
                  //               ],
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: screenSize.height * 0.2,
                  //   child: InkWell(
                  //     onTap: () => buildPin(),
                  //     child: Card(
                  //       elevation: 2,
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(20)),
                  //       color: const Color(0xFFEBF2EB),
                  //       child: SizedBox(
                  //         height: screenSize.height * 0.15,
                  //         width: 300,
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(10),
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Row(
                  //                 children: [
                  //                   const Icon(Icons.check_circle_outline),
                  //                   SizedBox(
                  //                     width: 10,
                  //                   ),
                  //                   Text(
                  //                     "Title",
                  //                     style: TextStyle(fontSize: 14),
                  //                   )
                  //                 ],
                  //               ),
                  //               SizedBox(
                  //                 height: 10,
                  //               ),
                  //               Text(
                  //                 "Description",
                  //                 style: TextStyle(fontSize: 12),
                  //               ),
                  //               SizedBox(
                  //                 height: 10,
                  //               ),
                  //               Row(
                  //                 children: [
                  //                   SizedBox(
                  //                     height: 20,
                  //                     child: Image.asset(
                  //                         "assets/images/taskperson.png"),
                  //                   ),
                  //                   SizedBox(
                  //                     width: 10,
                  //                   ),
                  //                   Icon(
                  //                     Icons.calendar_today_outlined,
                  //                     size: 18,
                  //                   ),
                  //                   SizedBox(
                  //                     width: 5,
                  //                   ),
                  //                   Text(
                  //                     "22/22/22",
                  //                     style: TextStyle(fontSize: 14),
                  //                   )
                  //                 ],
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    AlertDialog(
                                                      // insetPadding:
                                                      //     EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                                      // contentPadding: EdgeInsets.fromLTRB(24, 8, 24, 24),
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
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
                                                              Icon(Icons.star),
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
                                                              Icon(Icons.star),
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
                                              padding: const EdgeInsets.all(10),
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
                                                    style:
                                                        TextStyle(fontSize: 12),
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
        });
  }
}
