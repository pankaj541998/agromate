import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/text_Input_field.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/Crop_Plan_Model.dart';

final GlobalKey<FormState> _Form = GlobalKey<FormState>();
TextEditingController CropReferenceTextEditingController =
    TextEditingController();
TextEditingController AreaTextEditingController = TextEditingController();
TextEditingController ExpectedYieldTextEditingController =
    TextEditingController();
TextEditingController ExpectedRevenueTextEditingController =
    TextEditingController();
TextEditingController HarvestTextEditingController = TextEditingController();
TextEditingController StartDateTextEditingController = TextEditingController();
TextEditingController ExpectedEndDateTextEditingController =
    TextEditingController();

class AddCropPlan extends StatefulWidget {
  const AddCropPlan({Key? key}) : super(key: key);

  @override
  State<AddCropPlan> createState() => _AddCropPlanState();
}

String cropSelected = 'Select Your Question *';
var crop = [
  'Select Your Question *',
  'crop 1',
  'crop 2',
  'crop 3',
  'crop 4',
];

String CultivarSelected = 'Select Your Question *';
var Cultivar = [
  'Select Your Question *',
  'cultivar 1',
  'cultivar 2',
  'cultivar 3',
  'cultivar 4',
];

String farmSelected = 'Select Your Question *';
var farms = [
  'Select Your Question *',
  'farm 1',
  'farm 2',
  'farm 3',
  'farm 4',
];

String blockSelected = 'Select Your Question *';
var block = [
  'Select Your Question *',
  'block 1',
  'block 2',
  'block 3',
  'block 4',
];

String fieldSelected = 'Select Your Question *';
var field = [
  'Select Your Question *',
  'field 1',
  'field 2',
  'field 3',
  'field 4',
];

Future<String> addWeeklyTask() async {
  debugPrint("reached");
  Map<String, dynamic> updata = {
    "farm_id": '',
    "block_id": '',
    "field_id": '',
    "crop_reference": CropReferenceTextEditingController.text,
    "crop_program_id": '',
    "caltivar": CultivarSelected,
    "start_date": StartDateTextEditingController,
    "expected_end_date": ExpectedEndDateTextEditingController,
    "area": AreaTextEditingController.text,
    "expected_yield": ExpectedYieldTextEditingController.text,
    "expected_revenue": ExpectedRevenueTextEditingController.text,
    "harvest_days": HarvestTextEditingController.text,
  };
  return await addTaskAPI(updata);
}

Future<String> addTaskAPI(Map<String, dynamic> updata) async {
  final _chuckerHttpClient = await http.Client();
  print(updata);
  final prefs = await SharedPreferences.getInstance();
  http.Response response = await _chuckerHttpClient.post(
    Uri.parse("https://agromate.website/laravel/api/addCropPlan"),
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

class _AddCropPlanState extends State<AddCropPlan> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("dd-MM-yyyy");

    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopBar(),
          const SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: const Icon(Icons.arrow_back_ios),
                      onTap: () {
                        Get.back();
                      },
                    ),
                    const Text(
                      'Crop Plans',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
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
            child: SizedBox(
              height: screenSize.height * 1 - 280,
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 25,
                  runSpacing: 25,
                  children: [
                    SizedBox(
                      width: screenSize.width * 0.28,
                      child: Form(
                        key: _Form,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Farm',
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
                                  color:
                                      const Color(0xff327C04).withOpacity(0.5),
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
                              value: farmSelected,
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
                              items: farms.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  farmSelected = newValue!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width * 0.28,
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
                              fillColor: Colors.transparent,
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
                            value: blockSelected,
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
                            items: block.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                blockSelected = newValue!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width * 0.28,
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
                              fillColor: Colors.transparent,
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
                            value: fieldSelected,
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
                                fieldSelected = newValue!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width * 0.28,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Crop Reference',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: CropReferenceTextEditingController,
                            // initialValue: 'enter heritage',
                            style: const TextStyle(
                              // color: Color(0xffffffff),
                              fontFamily: 'Helvetica',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            // readOnly: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              errorMaxLines: 3,
                              hintText: "Crop Reference",
                              contentPadding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 15, bottom: 15),
                              hintStyle: const TextStyle(
                                fontSize: 16,
                                // color: const Color(0xffffffff).withOpacity(0.8),
                                fontFamily: 'Helvetica',
                              ),
                              // fillColor: Colors.white,
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
                                fontSize: 16.0,
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
                            // controller: _email,
                            keyboardType: TextInputType.text,
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter your email Id';
                            //   }
                            //   return null;
                            // },
                            // onSaved: (name) {},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width * 0.28,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Crop',
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
                              fillColor: Colors.transparent,
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
                            value: cropSelected,
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
                                cropSelected = newValue!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width * 0.28,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Cultivar',
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
                              fillColor: Colors.transparent,
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
                            value: CultivarSelected,
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
                            items: Cultivar.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                CultivarSelected = newValue!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width * 0.28,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Start Date',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 15),
                          DateTimeField(
                            controller: StartDateTextEditingController,
                            cursorColor: const Color(0xff000000),
                            decoration: InputDecoration(
                              errorMaxLines: 3,
                              hintText: "Date",
                              contentPadding: const EdgeInsets.only(
                                top: 10,
                                bottom: 10,
                                left: 10,
                                right: 10,
                              ),
                              hintStyle: const TextStyle(
                                fontSize: 16,
                                // color: const Color(0xff161723).withOpacity(0.5),
                                // fontFamily: 'Helvetica',
                              ),
                              // fillColor: Colors.white,
                              filled: true,
                              fillColor: Colors.transparent,
                              suffixIcon: const Icon(
                                CupertinoIcons.calendar_today,
                                color: Color(0xff327C04),
                                size: 25,
                              ),
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
                                fontSize: 16.0,
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
                            format: format,
                            onShowPicker: (context, currentValue) {
                              return showDatePicker(
                                helpText: 'Select Date',
                                context: context,
                                firstDate: DateTime(1970),
                                // initialDate: currentValue ?? DateTime.now().subtract(const Duration(days: 365)),
                                initialDate: currentValue ??
                                    DateTime.now()
                                        .subtract(const Duration(days: 4745)),
                                // lastDate: DateTime(2100));
                                lastDate: DateTime.now(),
                                builder: (BuildContext context, Widget? child) {
                                  return Theme(
                                    data: ThemeData.dark().copyWith(
                                      colorScheme: const ColorScheme.dark(
                                        primary: Color(0xff327C04),
                                        // onPrimary: Colors.black,
                                        surface: Color(0xff327C04),
                                        // onSurface: Color(0xff000000),
                                      ),
                                      dialogBackgroundColor:
                                          const Color(0xff000000),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (date) => date == null
                                ? 'Date of birth is required'
                                : null,
                            onChanged: (date) {
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width * 0.28,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Expected End Date',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 15),
                          DateTimeField(
                            controller: ExpectedEndDateTextEditingController,
                            cursorColor: const Color(0xff000000),
                            decoration: InputDecoration(
                              errorMaxLines: 3,
                              hintText: "Date",
                              contentPadding: const EdgeInsets.only(
                                top: 10,
                                bottom: 10,
                                left: 10,
                                right: 10,
                              ),
                              hintStyle: const TextStyle(
                                fontSize: 16,
                                // color: const Color(0xff161723).withOpacity(0.5),
                                // fontFamily: 'Helvetica',
                              ),
                              // fillColor: Colors.white,
                              filled: true,
                              fillColor: Colors.transparent,
                              suffixIcon: const Icon(
                                CupertinoIcons.calendar_today,
                                color: Color(0xff327C04),
                                size: 25,
                              ),
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
                                fontSize: 16.0,
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
                            format: format,
                            onShowPicker: (context, currentValue) {
                              return showDatePicker(
                                helpText: 'Select Date',
                                context: context,
                                firstDate: DateTime(1970),
                                // initialDate: currentValue ?? DateTime.now().subtract(const Duration(days: 365)),
                                initialDate: currentValue ??
                                    DateTime.now()
                                        .subtract(const Duration(days: 4745)),
                                // lastDate: DateTime(2100));
                                lastDate: DateTime.now(),
                                builder: (BuildContext context, Widget? child) {
                                  return Theme(
                                    data: ThemeData.dark().copyWith(
                                      colorScheme: const ColorScheme.dark(
                                        primary: Color(0xff327C04),
                                        // onPrimary: Colors.black,
                                        surface: Color(0xff327C04),
                                        // onSurface: Color(0xff000000),
                                      ),
                                      dialogBackgroundColor:
                                          const Color(0xff000000),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (date) => date == null
                                ? 'Date of birth is required'
                                : null,
                            onChanged: (date) {
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width * 0.28,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Area',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: AreaTextEditingController,
                            // initialValue: 'enter heritage',
                            style: const TextStyle(
                              // color: Color(0xffffffff),
                              fontFamily: 'Helvetica',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            // readOnly: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              errorMaxLines: 3,
                              hintText: "Area",
                              contentPadding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 15, bottom: 15),
                              hintStyle: const TextStyle(
                                fontSize: 16,
                                // color: const Color(0xffffffff).withOpacity(0.8),
                                fontFamily: 'Helvetica',
                              ),
                              // fillColor: Colors.white,
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
                                fontSize: 16.0,
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
                            // controller: _email,
                            keyboardType: TextInputType.text,
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter your email Id';
                            //   }
                            //   return null;
                            // },
                            // onSaved: (name) {},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width * 0.28,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Expected Yield',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: ExpectedYieldTextEditingController,
                            // initialValue: 'enter heritage',
                            style: const TextStyle(
                              // color: Color(0xffffffff),
                              fontFamily: 'Helvetica',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            // readOnly: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              errorMaxLines: 3,
                              hintText: "Expected Yield",
                              contentPadding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 15, bottom: 15),
                              hintStyle: const TextStyle(
                                fontSize: 16,
                                // color: const Color(0xffffffff).withOpacity(0.8),
                                fontFamily: 'Helvetica',
                              ),
                              // fillColor: Colors.white,
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
                                fontSize: 16.0,
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
                            // controller: _email,
                            keyboardType: TextInputType.text,
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter your email Id';
                            //   }
                            //   return null;
                            // },
                            // onSaved: (name) {},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width * 0.28,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Expected Revenue',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: ExpectedRevenueTextEditingController,
                            // initialValue: 'enter heritage',
                            style: const TextStyle(
                              // color: Color(0xffffffff),
                              fontFamily: 'Helvetica',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            // readOnly: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              errorMaxLines: 3,
                              hintText: "Expected Revenue",
                              contentPadding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 15, bottom: 15),
                              hintStyle: const TextStyle(
                                fontSize: 16,
                                // color: const Color(0xffffffff).withOpacity(0.8),
                                fontFamily: 'Helvetica',
                              ),
                              // fillColor: Colors.white,
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
                                fontSize: 16.0,
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
                            // controller: _email,
                            keyboardType: TextInputType.text,
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter your email Id';
                            //   }
                            //   return null;
                            // },
                            // onSaved: (name) {},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width * 0.28,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Harvest Days',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: HarvestTextEditingController,
                            // initialValue: 'enter heritage',
                            style: const TextStyle(
                              // color: Color(0xffffffff),
                              fontFamily: 'Helvetica',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            // readOnly: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              errorMaxLines: 3,
                              hintText: "Harvest Days",
                              contentPadding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 15, bottom: 15),
                              hintStyle: const TextStyle(
                                fontSize: 16,
                                // color: const Color(0xffffffff).withOpacity(0.8),
                                fontFamily: 'Helvetica',
                              ),
                              // fillColor: Colors.white,
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
                                fontSize: 16.0,
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
                            // controller: _email,
                            keyboardType: TextInputType.text,
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter your email Id';
                            //   }
                            //   return null;
                            // },
                            // onSaved: (name) {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final isValid = _Form.currentState?.validate();
                    debugPrint('');
                    debugPrint('');
                    debugPrint('');
                    debugPrint(CropReferenceTextEditingController.text);
                    debugPrint('');
                    debugPrint(CultivarSelected);
                    debugPrint(StartDateTextEditingController.text);
                    debugPrint(ExpectedEndDateTextEditingController.text);
                    debugPrint(AreaTextEditingController.text);
                    debugPrint(ExpectedYieldTextEditingController.text);
                    debugPrint(ExpectedRevenueTextEditingController.text);
                    debugPrint(HarvestTextEditingController.text);
                    //addWeeklyTask();
                    Get.toNamed('/crop_plan');
                    if (isValid!) {
                      // setState(() {
                      //   addCropProgram().then((value) =>
                      //       Navigator.pushNamed(
                      //           context, '/table_view_crop'));
                      // });
                    } else {
                      // Flushbar(
                      //   duration: const Duration(seconds: 2),
                      //   message: "Please Enter All Details",
                      // ).show(context);
                    }
                    // addCropProgram();
                    // Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff327C04),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 15),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
