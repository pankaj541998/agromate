import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/custom_Elevated_Button.dart';
import 'package:flutter_agro_new/component/dropdown_btn.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:flutter_agro_new/database_api/methods/stock_planner_api_methods.dart';
import 'package:flutter_agro_new/main.dart';
import 'package:flutter_agro_new/models/fetch_Warehouse_Model.dart';
import 'package:flutter_agro_new/models/stock_plan_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

const List<Widget> options = <Widget>[Text('Grid'), Text('Table')];

class StockPlannerTable extends StatefulWidget {
  const StockPlannerTable({Key? key}) : super(key: key);

  @override
  State<StockPlannerTable> createState() => _StockPlannerTableState();
}

late stockPlanModel stockplan;

class _StockPlannerTableState extends State<StockPlannerTable> {
  var currentDate = DateTime.now();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _date = TextEditingController();
  final format = DateFormat("dd-MM-yyyy");
  String? unitcost;
  String? plantPopulation;
  String? yield;
  String? weeks;
  TextEditingController controller = TextEditingController();
  final TextEditingController plannerDateTextEditingController =
      TextEditingController();
  final TextEditingController stockPlannerQuantityTextEditingController =
      TextEditingController();
  final StreamController<requestResponseState> _stockPlannerGet =
      StreamController.broadcast();
  late final Future warehouse;
  @override
  void initState() {
    super.initState();
    warehouse = stockPlannerAPI.getWarehouse();
    fetchStockPlan();
  }

  Future<stockPlanModel> fetchStockPlan() async {
    var client = http.Client();
    final response = await client.get(
        Uri.parse('https://agromate.website/laravel/api/get_stock_planner'));
    final parsed = jsonDecode(response.body);
    //print(response.body);

    if (response.statusCode == 200) {
      stockplan = stockPlanModel.fromJson(parsed);
      _stockPlannerGet.add(requestResponseState.DataReceived);
      return stockplan;
    } else {
      Center(
        child: Text("Please Try Again After Some Time..."),
      );
    }
    return stockplan;
  }

  Future<String> addStockplannerAPI() async {
    print("reached");
    final _chuckerHttpClient = await http.Client();
    final http.Response response = await http.post(
        Uri.parse("https://agromate.website/laravel/api/add_stock_planner"),
        body: {
          "warehouse_id": currentWarehouseId.toString(),
          "start_date": plannerDateTextEditingController.text,
          "stock_name": _selectedValue1.toString(),
          "quantity": stockPlannerQuantityTextEditingController.text
        });
    print("api resp is ${response.body}");
    if (response.statusCode == 200) {
      fetchStockPlan();
      Flushbar(
        message: "Stock Planner Added Successfully",
        duration: Duration(seconds: 2),
      );
     Navigator.pop(context);

      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => StockPlannerTable()));
      
      return 'null';
    } else {
      return throw (Exception("Search Error"));
    }
  }

  String? _selectedValue1;
  List<String> listOfValue1 = [
    'Stock 1',
    'Stock 2',
    'Stock 3',
    'Stock 4',
  ];

  String? currentWarehouse;
  int? currentWarehouseId;
  buildPinAlertDialog(screenSize) {
    return showDialog(
        context: context,
        builder: (context) => _buildbody(context, screenSize));
  }

  Widget _buildbody(context, screenSize) {
    return StatefulBuilder(
      builder: (context, setState) {
        return FutureBuilder(
            future: warehouse,
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
              var fetchedwarehouselist = data as List<fetchWarehouse>;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AlertDialog(
                    insetPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    contentPadding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Add New Stock",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.cancel_outlined,
                            color: Color(0xFF4E944F),
                          ),
                        )
                      ],
                    ),
                    content: Form(
                      key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     SizedBox(
                          //       height: 10,
                          //     ),
                          //     Image.asset("assets/images/Group6740.png",
                          //         height: 70),
                          //   ],
                          // ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: screenSize.width * 0.21,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Select Warehouse',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    SizedBox(
                                      height: 40,
                                      child: DropdownButtonFormField(
                                        hint: Text("Select Warehouse"),
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
                                        items: fetchedwarehouselist.map((e) {
                                          return DropdownMenuItem(
                                            child: Text(
                                                e.warehouseName.toString()),
                                            value: e.warehouseName,
                                          );
                                          //e.warehouseName.toString();
                                        }).toList(),
                                        onChanged: (value) async {
                                          setState(() {
                                            currentWarehouse = value.toString();
                                            currentWarehouseId =
                                                fetchedwarehouselist
                                                    .singleWhere((element) =>
                                                        element.warehouseName ==
                                                        currentWarehouse)
                                                    .id;
                                          });
                                        },
                                      ),

                                      // DropdownBtn(
                                      //   items: fetchedwarehouselist.map((e) {
                                      //     return e.warehouseName.toString();
                                      //   }).toList(),
                                      //   hint: "Select Warehouse",
                                      //   onItemSelected: (value) async {
                                      //     setState(() {
                                      //       currentWarehouse = value;
                                      //       currentWarehouseId =
                                      //           fetchedwarehouselist
                                      //               .singleWhere((element) =>
                                      //                   element
                                      //                       .warehouseName ==
                                      //                   currentWarehouse)
                                      //               .id;
                                      //     });
                                      //   },
                                      // )
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              SizedBox(
                                width: screenSize.width * 0.21,
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
                                      controller:
                                          plannerDateTextEditingController,
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
                                      format: format,
                                      onShowPicker: (context, currentValue) {
                                        return showDatePicker(
                                          helpText: 'Select Date',
                                          context: context,
                                          firstDate: DateTime(1970),
                                          // initialDate: currentValue ?? DateTime.now().subtract(const Duration(days: 365)),
                                          initialDate: currentValue ??
                                              DateTime.now().subtract(
                                                  const Duration(days: 4745)),
                                          // lastDate: DateTime(2100));
                                          lastDate: DateTime(2025),
                                          builder: (BuildContext context,
                                              Widget? child) {
                                            return Theme(
                                              data: ThemeData.dark().copyWith(
                                                colorScheme:
                                                    const ColorScheme.dark(
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
                              const SizedBox(
                                width: 25,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: screenSize.width * 0.21,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Stock Name',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    SizedBox(
                                      height: 40,
                                      child: DropdownButtonFormField(
                                        hint: Text("Select Name"),
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
                                            _selectedValue1 = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              SizedBox(
                                width: screenSize.width * 0.21,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Enter Quantity',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    TextFormField(
                                      controller:
                                          stockPlannerQuantityTextEditingController,
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
                                        hintText: "Enter Quantity",
                                        contentPadding: const EdgeInsets.only(
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
                              const SizedBox(
                                width: 25,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: screenSize.width * 0.21,
                            height: 40,
                            child: CustomElevatedButton(
                              onPressed: () {
                                addStockplannerAPI();
                               // Navigator.pop(context);
                              },
                              title: "Submit",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            });
      },
    );
  }

  datatable(screenSize) {
    return Container(
      height: screenSize.height * 0.7,
      padding: const EdgeInsets.all(0.0),
      decoration: const BoxDecoration(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: PaginatedDataTable(
                sortColumnIndex: 0,
                // sortAscending: sort,
                source: RowSource(
                  myData: myData,
                  count: myData.length,
                ),
                rowsPerPage: 9,
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
                        child: const Center(
                          child: Text(
                            "ID",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
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
                        child: const Center(
                          child: Text(
                            "Warehouse",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
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
                        child: const Center(
                          child: Text(
                            "Stock Name",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
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
                        child: const Center(
                          child: Text(
                            "Quantity",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
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
                        child: const Center(
                          child: Text(
                            "Date",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<bool> _selectedFruits = <bool>[false, true];
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          TopBar(),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back_ios_rounded)),
                      SizedBox(width: screenSize.width * 0.02),
                      const Text(
                        'Stock Planner',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff000000),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: screenSize.width * 0.02),
                      Row(
                        children: [
                          InkWell(
                            onTap: () => Get.toNamed("/stockplanner"),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xffF7F9EA),
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
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            hoverColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () => {},
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff327C04),
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
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                buildPinAlertDialog(screenSize);
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
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: SizedBox(
                                width: 250,
                                child: CupertinoSearchTextField(
                                  onChanged: (value) {
                                    // setState(() {
                                    //   myData = filterData!
                                    //       .where(
                                    //         (element) => element.name!
                                    //             .toLowerCase()
                                    //             .contains(
                                    //               value.toLowerCase(),
                                    //             ),
                                    //       )
                                    //       .toList();
                                    // }
                                    // );
                                  },
                                  // controller: controller,
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
                  const SizedBox(height: 20),
                  const Divider(
                    height: 5,
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  SizedBox(height: screenSize.height * 0.03),
                 StreamBuilder<requestResponseState>(
                          stream: _stockPlannerGet.stream,
                          builder: (context, snapshot) {
                            fetchStockPlan();
                            return SizedBox(
                              child: datatable(screenSize),
                            );
                          })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TextDropdown extends StatefulWidget {
  const TextDropdown({
    Key? key,
    this.hinttext,
    this.prefix,
    this.errortext,
    this.items,
    required this.controller,
    required this.showDropDown,
    this.onInput,
  }) : super(key: key);
  final String? errortext;
  final TextEditingController controller;
  final String? prefix;
  final String? hinttext;
  final bool showDropDown;
  final List<String>? items;
  final void Function(String)? onInput;
  @override
  State<TextDropdown> createState() => _TextDropdownState();
}

class _TextDropdownState extends State<TextDropdown> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var items =
        widget.items ?? ['Reetik', 'Hemant', 'Salman', 'Kisan', 'Chinmay'];
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: TextFormField(
            onChanged: widget.onInput,
            textAlignVertical: TextAlignVertical.top,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return widget.errortext ?? "Please Enter Data";
              }
              return null;
            },
            controller: controller,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              // prefixIcon: const Icon(Icons.search),
              suffixIcon: widget.showDropDown
                  ? PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.expand_circle_down_rounded,
                      ),
                      onSelected: (String value) {
                        setState(() {
                          controller.text = value;
                        });
                      },
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          )),
                      itemBuilder: (BuildContext context) {
                        return items.map<PopupMenuItem<String>>((String value) {
                          return PopupMenuItem(
                              child: Text(value), value: value);
                        }).toList();
                      },
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}

class RowSource extends DataTableSource {
  var myData;
  final count;
  RowSource({
    required this.myData,
    required this.count,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRow(myData![index]);
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

DataRow recentFileDataRow(StockData data) {
  return DataRow(
    cells: [
      DataCell(
          Align(alignment: Alignment.center, child: Text(data.id.toString()))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Text(data.warehouseId.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.stockName.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.quantity.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.startDate.toString()))),
    ],
  );
}

class Data {
  String? id;
  String? warehouse;
  String? stockname;
  String? date;
  String? quantity;

  Data({
    required this.id,
    required this.warehouse,
    required this.stockname,
    required this.date,
    required this.quantity,
  });
}

List<StockData> myData = stockplan.data!;
