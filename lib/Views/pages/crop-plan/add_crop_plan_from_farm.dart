import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_agro_new/Views/pages/crop-plan/controller.dart';
import 'package:flutter_agro_new/component/text_Input_field.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:flutter_agro_new/models/crop.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../component/dropdown_btn.dart';
import '../../../database_api/methods/crop_program_api_method.dart';

final CropReferenceTextEditingController = TextEditingController();
final AreaTextEditingController = TextEditingController();
final ExpectedYieldTextEditingController = TextEditingController();
final CultivarTextEditingController = TextEditingController();
final ExpectedRevenueTextEditingController = TextEditingController();
final HarvestTextEditingController = TextEditingController();
final StartDateTextEditingController = TextEditingController();
final ExpectedEndDateTextEditingController = TextEditingController();




class AddCropPlanFromFarm extends StatefulWidget {
  AddCropPlanFromFarm({Key? key}) : super(key: key);

  @override
  State<AddCropPlanFromFarm> createState() => _AddCropPlanFromFarmState();
}


String UnitSelected = 'ZWL';
var Unit = ['ZWL', 'USD', 'NAD'];

String AreaSelected = 'Hectare';
var Area = ['Hectare', 'Acre'];


final GlobalKey<FormState> _Form = GlobalKey<FormState>();
Future<String> addCropSchedule(selectedFarmId, selectedBlockId, selectedFieldId,
    selectedCropId, UnitSelected, AreaSelected) async {
  debugPrint("reached");
  Map updata = {
    "farm_id": selectedFarmId.toString(),
    "block_id": selectedBlockId.toString(),
    "field_id": selectedFieldId.toString(),
    "crop_reference": CropReferenceTextEditingController.text,
    "crop_program_id": selectedCropId.toString(),
    "caltivar": CultivarTextEditingController.text,
    "start_date": StartDateTextEditingController.text,
    "expected_end_date": ExpectedEndDateTextEditingController.text,
    "area": AreaTextEditingController.text,
    "unit": AreaSelected.toString(),
    "unit_value": ExpectedYieldTextEditingController.text,
    "currency": UnitSelected.toString(),
    "currency_value": ExpectedRevenueTextEditingController.text,
    "harvest_days": HarvestTextEditingController.text,
  };
  return await addCropScheduleAPI(updata);
}

Future<String> addCropScheduleAPI(Map updata) async {
  final _chuckerHttpClient = await http.Client();
  print(updata);
  final prefs = await SharedPreferences.getInstance();
  http.Response response = await _chuckerHttpClient.post(
    Uri.parse("https://agromate.website/laravel/api/add_plan"),
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

class _AddCropPlanFromFarmState extends State<AddCropPlanFromFarm> {
  final TextEditingController controller = TextEditingController();
  final FutureGroup futureGroup = FutureGroup();
  final TextEditingController tecFarm = TextEditingController();
  final TextEditingController tecBlock = TextEditingController();
  final TextEditingController tecField = TextEditingController();
  final TextEditingController tecCrop = TextEditingController();
  List? argData;

  bool isLoading = true;
  

  getArg() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var prefData = prefs.getString('argData');
    argData = json.decode(prefData!);
    tecFarm.text = argData![0]["farm"];
    currentFarmId = argData![0]["farmId"];
    tecBlock.text = argData![0]["block"];
    currentBlockId = argData![0]["blockId"];
    tecField.text = argData![0]["field"];
    currentFieldId = argData![0]["fieldId"];
    isLoading = false;
    setState(() {
      
    });
  }

  @override
  void initState() {
    super.initState();
    getArg();
    print("init $argData");
    HarvestTextEditingController.text = "14";
    futureGroup.add(CropApiMethods.fetchCrops());
    futureGroup.close();
    CropReferenceTextEditingController.clear();
    AreaTextEditingController.clear();
    StartDateTextEditingController.clear();
    ExpectedEndDateTextEditingController.clear();
    ExpectedYieldTextEditingController.clear();
    ExpectedRevenueTextEditingController.clear();
  }

  @override
  void dispose() {
    CropReferenceTextEditingController.clear();
    AreaTextEditingController.clear();
    StartDateTextEditingController.clear();
    ExpectedEndDateTextEditingController.clear();
    ExpectedYieldTextEditingController.clear();
    ExpectedRevenueTextEditingController.clear();

    super.dispose();
  }

  String? currentFarm;
  int? currentFarmId;

  String? currentBlock;
  int? currentBlockId;

  String? currentField;
  int? currentFieldId;

  String? currentCrop;
  int? currentCropId;

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("dd-MM-yyyy");
    var currentDate = DateTime.now();
    final screenSize = MediaQuery.of(context).size;
    return FutureBuilder(
      future: futureGroup.future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          var data = snapshot.data!;
          var fetchedcrop = data.elementAt(0) as List<CropPModel>;

          return isLoading 
          ? Center(child: CircularProgressIndicator()) 
          : Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopBar(),
                const SizedBox(height: 30),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
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
                  padding:
                      EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
                  child: SizedBox(
                    height: screenSize.height * 1 - 280,
                    child: SingleChildScrollView(
                      child: Form(
                        key: _Form,
                        child: Wrap(
                          spacing: 25,
                          runSpacing: 25,
                          children: [
                            SizedBox(
                              width: screenSize.width * 0.28,
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
                                  TextFormField(
                                    readOnly: true,
                                    controller:
                                        tecFarm,
                                    style: const TextStyle(
                                      fontFamily: 'Helvetica',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      fillColor: Colors.transparent,
                                      errorMaxLines: 3,
                                      contentPadding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 15,
                                          bottom: 15),
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
                                    keyboardType: TextInputType.text,
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
                                    'Block',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  TextFormField(
                                    readOnly: true,
                                    controller:
                                        tecBlock,
                                    style: const TextStyle(
                                      fontFamily: 'Helvetica',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      fillColor: Colors.transparent,
                                      errorMaxLines: 3,
                                      contentPadding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 15,
                                          bottom: 15),
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
                                    keyboardType: TextInputType.text,
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
                      
                                  TextFormField(
                                    readOnly: true,
                                    controller:
                                        tecField,
                                    style: const TextStyle(
                                      fontFamily: 'Helvetica',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      fillColor: Colors.transparent,
                                      errorMaxLines: 3,
                                      contentPadding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 15,
                                          bottom: 15),
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
                                    keyboardType: TextInputType.text,
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
                      
                                  SizedBox(
                                    width: 500,
                                    child: DropdownBtn(
                                      items: fetchedcrop.map((e) {
                                        return e.crop.toString();
                                      }).toList(),
                                      hint: 'Select Crop',
                                      onItemSelected: (value) async {
                                        debugPrint(value);
                                        currentCrop = value;
                                        currentCropId = fetchedcrop
                                            .singleWhere((element) =>
                                                element.crop == value)
                                            .id;
                                      },
                                    ),
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
                                    controller:
                                        CropReferenceTextEditingController,
                                    style: const TextStyle(
                                      fontFamily: 'Helvetica',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    validator: (value) {
                                      if (value == null && value!.isEmpty) {
                                        return "Please enter Crop Reference";
                                      }
                                      return null;
                                    },
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      fillColor: Colors.transparent,
                                      errorMaxLines: 3,
                                      hintText: "Crop Reference",
                                      contentPadding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 15,
                                          bottom: 15),
                                      hintStyle: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Helvetica',
                                      ),
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
                                    keyboardType: TextInputType.text,
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
                      
                                  TextFormField(
                                    controller: CultivarTextEditingController,
                                    style: const TextStyle(
                                      fontFamily: 'Helvetica',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      fillColor: Colors.transparent,
                                      errorMaxLines: 3,
                                      hintText: "Cultivar",
                                      contentPadding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 15,
                                          bottom: 15),
                                      hintStyle: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Helvetica',
                                      ),
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
                                    keyboardType: TextInputType.text,
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
                                      ),
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
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2050),
                                        builder: (BuildContext context,
                                            Widget? child) {
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
                                    controller:
                                        ExpectedEndDateTextEditingController,
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
                                      ),
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
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2050),
                                        builder: (BuildContext context,
                                            Widget? child) {
                                          return Theme(
                                            data: ThemeData.dark().copyWith(
                                              colorScheme: const ColorScheme.dark(
                                                primary: Color(0xff327C04),
                                                surface: Color(0xff327C04),
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
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(12),
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: AreaTextEditingController,
                                    style: const TextStyle(
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
                                          left: 10,
                                          right: 10,
                                          top: 15,
                                          bottom: 15),
                                      hintStyle: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Helvetica',
                                      ),
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
                                    keyboardType: TextInputType.text,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: screenSize.width * 0.28,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Yield Per Hectare/Acre",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        width: 135,
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
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color(0xff327C04),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
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
                                          value: AreaSelected,
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
                                          items: Area.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(items),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              AreaSelected = newValue!;
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        height: 40,
                                        width: 180,
                                        child: TextInputField(
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(6),
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            textEditingController:
                                                ExpectedYieldTextEditingController,
                                            hintText: "",
                                            validatorText: ""),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: screenSize.width * 0.28,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Expected Revenue",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        width: 135,
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
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color(0xff327C04),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
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
                                          value: UnitSelected,
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
                                          items: Unit.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(items),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              UnitSelected = newValue!;
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        height: 40,
                                        width: 210,
                                        child: TextInputField(
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  12),
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            textEditingController:
                                                ExpectedRevenueTextEditingController,
                                            hintText: "",
                                            validatorText: ""),
                                      ),
                                    ],
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
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(12),
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: HarvestTextEditingController,
                                    style: const TextStyle(
                                      fontFamily: 'Helvetica',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      fillColor: Colors.transparent,
                                      errorMaxLines: 3,
                                      hintText: "",
                                      contentPadding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 15,
                                          bottom: 15),
                                      hintStyle: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Helvetica',
                                      ),
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
                                    keyboardType: TextInputType.text,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          final isValid = _Form.currentState?.validate();
                          if (isValid!) {
                            print("isvlaid");
                            setState(() {
                              addCropSchedule(
                                  currentFarmId.toString(),
                                  currentBlockId.toString(),
                                  currentFieldId.toString(),
                                  currentCropId.toString(),
                                  UnitSelected.toString(),
                                  AreaSelected.toString());

                            });
                          } else {
                            Flushbar(
                              duration: const Duration(seconds: 2),
                              message: "Please Enter All Details",
                            ).show(context);
                          }
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
      },
    );

  }
}
