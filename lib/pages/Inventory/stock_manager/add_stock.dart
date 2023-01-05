import 'dart:convert';
import 'dart:async';

import 'package:flutter_agro_new/database_api/methods/instructions_api_model.dart';
import 'package:flutter_agro_new/database_api/methods/keyTargets.dart';
import 'package:flutter_agro_new/database_api/methods/modes_api_methods.dart';
import 'package:flutter_agro_new/database_api/methods/prercautions_api_methods.dart';
import 'package:flutter_agro_new/database_api/methods/timeOfApplication.dart';
import 'package:flutter_agro_new/database_api/methods/warnings_api_methods.dart';
import 'package:flutter_agro_new/database_api/models/instructions.dart';
import 'package:flutter_agro_new/database_api/models/keytargets.dart';
import 'package:flutter_agro_new/database_api/models/modes.dart';
import 'package:flutter_agro_new/database_api/models/precautions.dart';
import 'package:flutter_agro_new/database_api/models/timeofapplication.dart';
import 'package:flutter_agro_new/database_api/models/warnings.dart';
import 'package:flutter_agro_new/models/precautions_method.dart';
import 'package:flutter_agro_new/pages/Inventory/modes_of_application/Inventory_modes_of_application.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/dropdown_btn.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:async/async.dart';
import 'package:flutter_agro_new/database_api/methods/category_api_methods.dart';
import 'package:flutter_agro_new/database_api/methods/tyep_api_methods.dart';
import 'package:flutter_agro_new/database_api/models/category.dart';
import 'package:flutter_agro_new/database_api/models/type.dart';
import 'package:flutter_agro_new/models/warnings_model.dart';

import '../../../component/custom_Elevated_Button.dart';

final warningTextEditingController = TextEditingController();
final StreamController<bool> _warningsrefresh = StreamController.broadcast();
final precautionTextEditingController = TextEditingController();
final StreamController<bool> _precautionsrefresh = StreamController.broadcast();
final instructionTextEditingController = TextEditingController();
final StreamController<bool> _instructionsrefresh =
    StreamController.broadcast();
final keyTargetsTextEditingController = TextEditingController();
final StreamController<bool> _keyTargetssrefresh = StreamController.broadcast();
final timeOfApplicationTextEditingController = TextEditingController();
final StreamController<bool> _timeOfApplicationsrefresh =
    StreamController.broadcast();
final modesOfApplicationTextEditingController = TextEditingController();
final StreamController<bool> _modesOfApplicationsrefresh =
    StreamController.broadcast();

class AddStock extends StatefulWidget {
  const AddStock({Key? key}) : super(key: key);

  @override
  State<AddStock> createState() => _AddStockState();
}

class _AddStockState extends State<AddStock> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final FutureGroup futureGroup = FutureGroup();

  String? unitcost;
  String? plantPopulation;
  String? yield;
  String? weeks;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureGroup.add(CategoryAPI().fetchCategory());
    futureGroup.add(TypeAPI.fetchtype());
    futureGroup.add(WarningsAPI.fetchWarnings());
    futureGroup.add(PrecautionsAPI.fetchPrecautions());
    futureGroup.add(InstructionsAPI.fetchInstructions());
    futureGroup.add(KeyTargetsAPI.fetchKeyTargets());
    futureGroup.add(TimeOfApplicationAPI.fetchTimeOfApplication());
    futureGroup.add(ModesAPI.fetchModes());
    futureGroup.close();
  }

  String? currentCategory;
  int? currentCategoryId;

  String? currentType;
  int? currentTypeId;
  String questionsSelected = 'Select Your Question *';
  var questions = [
    'Select Your Question *',
    'Question 1',
    'Question 2',
    'Question 3',
    'Question 4',
  ];
  String ClassSelected = 'Select Category';
  var iclass = [
    'Select Category',
    'Category 1',
    'Category 2',
    'Category 3',
    'Category 4',
  ];
  String TypeSelected = 'Select Type';
  var type = [
    'Select Type',
    'Type 1',
    'Type 2',
    'Type 3',
    'Type 4',
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return FutureBuilder(
        future: futureGroup.future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            var data = snapshot.data!;
            var fetchedcategory = data.elementAt(0) as List<CategoryPModel>;
            var fetchedtype = data.elementAt(1) as List<TypePModel>;
            var fetchedwarnings = data.elementAt(2) as List<WarningsPModel>;
            var fetchedprecautions =
                data.elementAt(3) as List<PrecautionsPModel>;
            var fetchedinstructions =
                data.elementAt(4) as List<InstructionsPModel>;
            var fetchedkeytargets = data.elementAt(5) as List<KeyTargetsPModel>;
            var fetchedtimeofapplication =
                data.elementAt(6) as List<TimeOFApplicationPModel>;
            var fetchedmodesofapplication =
                data.elementAt(7) as List<ModesPModel>;
            return Scaffold(
              body: Column(
                children: [
                  TopBar(),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.05),
                    child: DefaultTabController(
                      length: 6,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              InkWell(
                                  onTap: () => Navigator.pop(context),
                                  child:
                                      const Icon(Icons.arrow_back_ios_rounded)),
                              SizedBox(width: screenSize.width * 0.02),
                              const Text(
                                'Add Stock',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Divider(
                            height: 5,
                            color: Colors.grey,
                            thickness: 1,
                          ),
                          SizedBox(height: screenSize.height * 0.03),
                          SizedBox(
                            height: screenSize.height * 0.7,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset("assets/images/Group6740.png",
                                          height: 80),
                                      SizedBox(width: screenSize.width * 0.045),
                                      SizedBox(
                                        width: screenSize.width * 0.2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Category',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xff000000),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            SizedBox(
                                              width: 300,
                                              child: DropdownBtn(
                                                items: fetchedcategory.map((e) {
                                                  return e.iclass.toString();
                                                }).toList(),
                                                hint: 'Select Catergory',
                                                onItemSelected: (value) async {
                                                  setState(() {
                                                    currentCategory = value;
                                                    currentCategoryId =
                                                        fetchedcategory
                                                            .singleWhere((element) =>
                                                                element
                                                                    .iclass ==
                                                                currentCategory)
                                                            .id;
                                                  });
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: screenSize.width * 0.045),
                                      SizedBox(
                                        width: screenSize.width * 0.2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Type',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xff000000),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            SizedBox(
                                              width: 300,
                                              child: DropdownBtn(
                                                items: fetchedtype.map((e) {
                                                  return e.type.toString();
                                                }).toList(),
                                                hint: 'Select Type',
                                                onItemSelected: (value) async {
                                                  setState(() {
                                                    currentType = value;
                                                    currentTypeId = fetchedtype
                                                        .singleWhere(
                                                            (element) =>
                                                                element.type ==
                                                                currentType)
                                                        .id;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: screenSize.width * 0.045),
                                      SizedBox(
                                        width: screenSize.width * 0.2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Alternative',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Color(0xff000000),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            DropdownButtonFormField(
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.only(
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
                                                fillColor: Colors.transparent,
                                                filled: true,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xff327C04),
                                                  ),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xff327C04),
                                                  ),
                                                ),
                                                errorStyle: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xff327C04),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xff327C04),
                                                  ),
                                                ),
                                                isDense: true,
                                              ),
                                              isExpanded: true,
                                              value: questionsSelected,
                                              iconEnabledColor: Colors
                                                  .transparent, // Down Arrow Icon
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
                                                  questions.map((String items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(items),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  questionsSelected = newValue!;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: screenSize.height * 0.03),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: screenSize.width * 0.2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'ItemCode',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xff000000),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            TextFormField(
                                              // initialValue: 'enter heritage',
                                              style: const TextStyle(
                                                // color: Color(0xffffffff),
                                                fontFamily: 'Helvetica',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              // readOnly: true,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              decoration: InputDecoration(
                                                fillColor: Colors.transparent,
                                                errorMaxLines: 3,
                                                hintText: "ItemCode",
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        left: 10,
                                                        right: 10,
                                                        top: 15,
                                                        bottom: 15),
                                                hintStyle: const TextStyle(
                                                  fontSize: 16,
                                                  // color: const Color(0xffffffff).withOpacity(0.8),
                                                  fontFamily: 'Helvetica',
                                                ),
                                                // fillColor: Colors.white,
                                                filled: true,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xff327C04),
                                                  ),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xff327C04),
                                                  ),
                                                ),
                                                errorStyle: const TextStyle(
                                                  fontSize: 16.0,
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xff327C04),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                      SizedBox(width: screenSize.width * 0.03),
                                      SizedBox(
                                        width: screenSize.width * 0.2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Description',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xff000000),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            TextFormField(
                                              // initialValue: 'enter heritage',
                                              style: const TextStyle(
                                                // color: Color(0xffffffff),
                                                fontFamily: 'Helvetica',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              // readOnly: true,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              decoration: InputDecoration(
                                                fillColor: Colors.transparent,
                                                errorMaxLines: 3,
                                                hintText: "Description",
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        left: 10,
                                                        right: 10,
                                                        top: 15,
                                                        bottom: 15),
                                                hintStyle: const TextStyle(
                                                  fontSize: 16,
                                                  // color: const Color(0xffffffff).withOpacity(0.8),
                                                  fontFamily: 'Helvetica',
                                                ),
                                                // fillColor: Colors.white,
                                                filled: true,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xff327C04),
                                                  ),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xff327C04),
                                                  ),
                                                ),
                                                errorStyle: const TextStyle(
                                                  fontSize: 16.0,
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xff327C04),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                      SizedBox(width: screenSize.width * 0.03),
                                      SizedBox(
                                        width: screenSize.width * 0.2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Unit Cost',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xff000000),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            TextFormField(
                                              // initialValue: 'enter heritage',
                                              style: const TextStyle(
                                                // color: Color(0xffffffff),
                                                fontFamily: 'Helvetica',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              // readOnly: true,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              decoration: InputDecoration(
                                                fillColor: Colors.transparent,
                                                errorMaxLines: 3,
                                                hintText: "Unit Cost",
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        left: 10,
                                                        right: 10,
                                                        top: 15,
                                                        bottom: 15),
                                                hintStyle: const TextStyle(
                                                  fontSize: 16,
                                                  // color: const Color(0xffffffff).withOpacity(0.8),
                                                  fontFamily: 'Helvetica',
                                                ),
                                                // fillColor: Colors.white,
                                                filled: true,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xff327C04),
                                                  ),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xff327C04),
                                                  ),
                                                ),
                                                errorStyle: const TextStyle(
                                                  fontSize: 16.0,
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xff327C04),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                      SizedBox(width: screenSize.width * 0.03),
                                      SizedBox(
                                        width: screenSize.width * 0.2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Stock Level',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xff000000),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            TextFormField(
                                              // initialValue: 'enter heritage',
                                              style: const TextStyle(
                                                // color: Color(0xffffffff),
                                                fontFamily: 'Helvetica',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              // readOnly: true,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              decoration: InputDecoration(
                                                fillColor: Colors.transparent,
                                                errorMaxLines: 3,
                                                hintText: "Stock Level",
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        left: 10,
                                                        right: 10,
                                                        top: 15,
                                                        bottom: 15),
                                                hintStyle: const TextStyle(
                                                  fontSize: 16,
                                                  // color: const Color(0xffffffff).withOpacity(0.8),
                                                  fontFamily: 'Helvetica',
                                                ),
                                                // fillColor: Colors.white,
                                                filled: true,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xff327C04),
                                                  ),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xff327C04),
                                                  ),
                                                ),
                                                errorStyle: const TextStyle(
                                                  fontSize: 16.0,
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xff327C04),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                  SizedBox(height: screenSize.height * 0.03),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: screenSize.width * 0.2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Active Ingridient',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xff000000),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            TextFormField(
                                              // initialValue: 'enter heritage',
                                              style: const TextStyle(
                                                // color: Color(0xffffffff),
                                                fontFamily: 'Helvetica',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              // readOnly: true,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              decoration: InputDecoration(
                                                fillColor: Colors.transparent,
                                                errorMaxLines: 3,
                                                hintText: "Active Ingridient",
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        left: 10,
                                                        right: 10,
                                                        top: 15,
                                                        bottom: 15),
                                                hintStyle: const TextStyle(
                                                  fontSize: 16,
                                                  // color: const Color(0xffffffff).withOpacity(0.8),
                                                  fontFamily: 'Helvetica',
                                                ),
                                                // fillColor: Colors.white,
                                                filled: true,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xff327C04),
                                                  ),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xff327C04),
                                                  ),
                                                ),
                                                errorStyle: const TextStyle(
                                                  fontSize: 16.0,
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xff327C04),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                      SizedBox(width: screenSize.width * 0.03),
                                      SizedBox(
                                        width: screenSize.width * 0.2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'AI/Kg',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xff000000),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            TextFormField(
                                              // initialValue: 'enter heritage',
                                              style: const TextStyle(
                                                // color: Color(0xffffffff),
                                                fontFamily: 'Helvetica',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              // readOnly: true,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              decoration: InputDecoration(
                                                fillColor: Colors.transparent,
                                                errorMaxLines: 3,
                                                hintText: "AI/Kg",
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        left: 10,
                                                        right: 10,
                                                        top: 15,
                                                        bottom: 15),
                                                hintStyle: const TextStyle(
                                                  fontSize: 16,
                                                  // color: const Color(0xffffffff).withOpacity(0.8),
                                                  fontFamily: 'Helvetica',
                                                ),
                                                // fillColor: Colors.white,
                                                filled: true,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xff327C04),
                                                  ),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xff327C04),
                                                  ),
                                                ),
                                                errorStyle: const TextStyle(
                                                  fontSize: 16.0,
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xff327C04),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xff327C04),
                                                  ),
                                                ),
                                                isDense: true,
                                              ),
                                              keyboardType: TextInputType.text,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      DecoratedBox(
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 227, 252, 224),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: TabBar(
                                            labelColor: Colors.white,
                                            unselectedLabelColor: Colors.black,
                                            indicator: ShapeDecoration(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                color: Color(0xFF327C04)),
                                            tabs: <Widget>[
                                              Tab(
                                                text: "Warnings",
                                              ),
                                              Tab(
                                                text: "Precautions",
                                              ),
                                              Tab(
                                                text: "Instructions",
                                              ),
                                              Tab(
                                                text: "Key Targets",
                                              ),
                                              Tab(
                                                text: "Time of Application",
                                              ),
                                              Tab(
                                                text: "Modes of Application",
                                              )
                                            ]),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 400,
                                    child: TabBarView(children: [
                                      Warnings(fetcwar: fetchedwarnings),
                                      Precautions(
                                          fetchprec: fetchedprecautions),
                                      Instructions(
                                          fetchinst: fetchedinstructions),
                                      KeyTargets(
                                          fetchtarget: fetchedkeytargets),
                                      TimeOfApplication(
                                          fetchApplication:
                                              fetchedtimeofapplication),
                                      ModeApplication(
                                          fetchmode: fetchedmodesofapplication),
                                    ]),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    width: 353,
                                    child: CustomElevatedButton(
                                      onPressed: () => Navigator.pop(context),
                                      title: 'Submit',
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return Scaffold(
            body: Column(
              children: [
                TopBar(),
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

Future<String> addWarnings() async {
  Map<String, String> updata = {
    "warning_name": warningTextEditingController.text.toString(),
  };
  return await addNewWarnings(updata);
}

Future<String> addNewWarnings(Map<String, String> updata) async {
  final _chuckerHttpClient = await http.Client();
  print(updata);
  http.Response response = await _chuckerHttpClient.post(
    Uri.parse('https://agromate.website/laravel/api/add_warning'),
    body: updata,
  );
  print(response.body);
  if (response.statusCode == 200) {
    print(response.body);
    return "null";
  } else {
    return 'throw (Exception("Search Error"))';
  }
}

class Warnings extends StatefulWidget {
  Warnings({Key? key, required this.fetcwar}) : super(key: key);

  List<WarningsPModel> fetcwar;
  @override
  State<Warnings> createState() => _WarningsState();
}

class _WarningsState extends State<Warnings> {
  bool check11 = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  'Choose Warnings',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(
                      width: 800,
                      child: TextFormField(
                          // initialValue: 'enter heritage',
                          style: const TextStyle(
                            // color: Color(0xffffffff),
                            fontFamily: 'Helvetica',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          // readOnly: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            errorMaxLines: 3,
                            hintText: "Add New Warning",
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
                          controller: warningTextEditingController,
                          keyboardType: TextInputType.text),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    InkWell(
                      onTap: () {
                        addWarnings();
                        _warningsrefresh.add(true);
                        warningTextEditingController.clear();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF327C04),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 9),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.add,
                                color: Color(0xffffffff),
                                size: 20,
                              ),
                              SizedBox(width: 6),
                              Text(
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
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ],
        ),
        SingleChildScrollView(
          child: ListView.builder(
            padding: EdgeInsets.only(left: 13.0, right: 13.0, bottom: 25.0),
            shrinkWrap: true,
            itemCount: widget.fetcwar.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Row(
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
                      value: check11,
                      onChanged: (check) {
                        check11 = check!;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.fetcwar.elementAt(index).warnings!,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

Future<String> addPrecautions() async {
  Map<String, String> updata = {
    "precaution_name": precautionTextEditingController.text.toString(),
  };
  return await addNewPrecautions(updata);
}

Future<String> addNewPrecautions(Map<String, String> updata) async {
  final _chuckerHttpClient = await http.Client();
  print(updata);
  http.Response response = await _chuckerHttpClient.post(
    Uri.parse('https://agromate.website/laravel/api/add_precaution'),
    body: updata,
  );
  print(response.body);
  if (response.statusCode == 200) {
    print(response.body);
    return "null";
  } else {
    return 'throw (Exception("Search Error"))';
  }
}

class Precautions extends StatefulWidget {
  Precautions({Key? key, required this.fetchprec}) : super(key: key);

  List<PrecautionsPModel> fetchprec;
  @override
  State<Precautions> createState() => _PrecautionsState();
}

class _PrecautionsState extends State<Precautions> {
  bool check11 = false;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: _precautionsrefresh.stream,
        builder: (context, snapshot) {
          return Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Choose Precautions',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          SizedBox(
                            width: 800,
                            child: TextFormField(
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
                                  hintText: "Add New Precaution",
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
                                controller: precautionTextEditingController,
                                keyboardType: TextInputType.text),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          InkWell(
                            onTap: () {
                              addPrecautions();
                              precautionTextEditingController.clear();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF327C04),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 9),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.add,
                                      color: Color(0xffffffff),
                                      size: 20,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
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
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ],
              ),
              ListView.builder(
                padding: EdgeInsets.only(left: 13.0, right: 13.0, bottom: 25.0),
                shrinkWrap: true,
                itemCount: widget.fetchprec.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Row(
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
                          value: check11,
                          onChanged: (check) {
                            check11 = check!;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.fetchprec.elementAt(index).precautions!,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  );
                },
              ),
            ],
          );
        });
  }
}

Future<String> addInstructions() async {
  Map<String, String> updata = {
    "instruction_name": instructionTextEditingController.text.toString(),
  };
  return await addNewInstructions(updata);
}

Future<String> addNewInstructions(Map<String, String> updata) async {
  final _chuckerHttpClient = await http.Client();
  print(updata);
  http.Response response = await _chuckerHttpClient.post(
    Uri.parse('https://agromate.website/laravel/api/add_instruction'),
    body: updata,
  );
  print(response.body);
  if (response.statusCode == 200) {
    print(response.body);
    return "null";
  } else {
    return 'throw (Exception("Search Error"))';
  }
}

class Instructions extends StatefulWidget {
  Instructions({Key? key, required this.fetchinst}) : super(key: key);

  List<InstructionsPModel> fetchinst;
  @override
  State<Instructions> createState() => _InstructionsState();
}

class _InstructionsState extends State<Instructions> {
  bool check11 = false;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: _precautionsrefresh.stream,
        builder: (context, snapshot) {
          return Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Choose Instructions',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          SizedBox(
                            width: 800,
                            child: TextFormField(
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
                                  hintText: "Add New Instructions",
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
                                controller: instructionTextEditingController,
                                keyboardType: TextInputType.text),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          InkWell(
                            onTap: () {
                              addInstructions();
                              instructionTextEditingController.clear();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF327C04),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 9),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.add,
                                      color: Color(0xffffffff),
                                      size: 20,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
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
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ],
              ),
              ListView.builder(
                padding: EdgeInsets.only(left: 13.0, right: 13.0, bottom: 25.0),
                shrinkWrap: true,
                itemCount: widget.fetchinst.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Row(
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
                          value: check11,
                          onChanged: (check) {
                            check11 = check!;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.fetchinst.elementAt(index).instructions!,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  );
                },
              ),
            ],
          );
        });
  }
}

Future<String> addKeyTargets() async {
  Map<String, String> updata = {
    "key_target_name": keyTargetsTextEditingController.text.toString(),
  };
  return await addNewKeyTargets(updata);
}

Future<String> addNewKeyTargets(Map<String, String> updata) async {
  final _chuckerHttpClient = await http.Client();
  print(updata);
  http.Response response = await _chuckerHttpClient.post(
    Uri.parse('https://agromate.website/laravel/api/add_key_targets'),
    body: updata,
  );
  print(response.body);
  if (response.statusCode == 200) {
    print(response.body);
    return "null";
  } else {
    return 'throw (Exception("Search Error"))';
  }
}

class KeyTargets extends StatefulWidget {
  KeyTargets({Key? key, required this.fetchtarget}) : super(key: key);

  List<KeyTargetsPModel> fetchtarget;
  @override
  State<KeyTargets> createState() => _KeyTargetsState();
}

class _KeyTargetsState extends State<KeyTargets> {
  bool check11 = false;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: _precautionsrefresh.stream,
        builder: (context, snapshot) {
          return Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Choose Key Targets',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          SizedBox(
                            width: 800,
                            child: TextFormField(
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
                                  hintText: "Add New Key Target",
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
                                controller: keyTargetsTextEditingController,
                                keyboardType: TextInputType.text),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          InkWell(
                            onTap: () {
                              addKeyTargets();
                              keyTargetsTextEditingController.clear();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF327C04),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 9),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.add,
                                      color: Color(0xffffffff),
                                      size: 20,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
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
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ],
              ),
              ListView.builder(
                padding: EdgeInsets.only(left: 13.0, right: 13.0, bottom: 25.0),
                shrinkWrap: true,
                itemCount: widget.fetchtarget.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Row(
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
                          value: check11,
                          onChanged: (check) {
                            check11 = check!;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.fetchtarget.elementAt(index).keyTargets!,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  );
                },
              ),
            ],
          );
        });
  }
}

Future<String> addTimeOfApplication() async {
  Map<String, String> updata = {
    "time_of_application_name":
        timeOfApplicationTextEditingController.text.toString(),
  };
  return await addNewTimeOfApplication(updata);
}

Future<String> addNewTimeOfApplication(Map<String, String> updata) async {
  final _chuckerHttpClient = await http.Client();
  print(updata);
  http.Response response = await _chuckerHttpClient.post(
    Uri.parse('https://agromate.website/laravel/api/add_time_of_application'),
    body: updata,
  );
  print(response.body);
  if (response.statusCode == 200) {
    print(response.body);
    return "null";
  } else {
    return 'throw (Exception("Search Error"))';
  }
}

class TimeOfApplication extends StatefulWidget {
  TimeOfApplication({Key? key, required this.fetchApplication})
      : super(key: key);

  List<TimeOFApplicationPModel> fetchApplication;
  @override
  State<TimeOfApplication> createState() => _TimeOfApplicationState();
}

class _TimeOfApplicationState extends State<TimeOfApplication> {
  bool check11 = false;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: _precautionsrefresh.stream,
        builder: (context, snapshot) {
          return Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Choose Time of Applications',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          SizedBox(
                            width: 800,
                            child: TextFormField(
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
                                  hintText: "Add New Time of Application",
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
                                controller:
                                    timeOfApplicationTextEditingController,
                                keyboardType: TextInputType.text),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          InkWell(
                            onTap: () {
                              addTimeOfApplication();
                              timeOfApplicationTextEditingController.clear();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF327C04),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 9),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.add,
                                      color: Color(0xffffffff),
                                      size: 20,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
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
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ],
              ),
              ListView.builder(
                padding: EdgeInsets.only(left: 13.0, right: 13.0, bottom: 25.0),
                shrinkWrap: true,
                itemCount: widget.fetchApplication.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Row(
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
                          value: check11,
                          onChanged: (check) {
                            check11 = check!;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.fetchApplication
                            .elementAt(index)
                            .timeOFApplication!,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  );
                },
              ),
            ],
          );
        });
  }
}

class ModeApplication extends StatefulWidget {
  ModeApplication({Key? key, required this.fetchmode}) : super(key: key);

  List<ModesPModel> fetchmode;
  @override
  State<ModeApplication> createState() => _ModeApplicationState();
}

class _ModeApplicationState extends State<ModeApplication> {
  bool check11 = false;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: _precautionsrefresh.stream,
        builder: (context, snapshot) {
          return Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Choose Modes of Applications',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          SizedBox(
                            width: 800,
                            child: TextFormField(
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
                                  hintText: "Add New Modes of Application",
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
                                controller:
                                    modesOfApplicationTextEditingController,
                                keyboardType: TextInputType.text),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          InkWell(
                            onTap: () {
                              addPrecautions();
                              modesOfApplicationTextEditingController.clear();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF327C04),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 9),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.add,
                                      color: Color(0xffffffff),
                                      size: 20,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
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
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ],
              ),
              ListView.builder(
                padding: EdgeInsets.only(left: 13.0, right: 13.0, bottom: 25.0),
                shrinkWrap: true,
                itemCount: widget.fetchmode.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Row(
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
                          value: check11,
                          onChanged: (check) {
                            check11 = check!;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.fetchmode.elementAt(index).modes!,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  );
                },
              ),
            ],
          );
        });
  }
}
