import 'dart:async';
import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agro_new/common/sized_box.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:flutter_agro_new/database_api/methods/stock_planner_api_methods.dart';
import 'package:flutter_agro_new/main.dart';
import 'package:flutter_agro_new/models/CropProgramTasksModel.dart';
import 'package:flutter_agro_new/models/fetch_Warehouse_Model.dart';
import 'package:flutter_agro_new/models/stock_order_model.dart';
import 'package:flutter_agro_new/models/stock_plan_model.dart';
import 'package:flutter_agro_new/Views/pages/growth_stages/dropdown_btn.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:http/http.dart' as http;
import '../../../../component/custom_Elevated_Button.dart';

const List<Widget> options = <Widget>[Text('Grid'), Text('Table')];

class StockPlanner extends StatefulWidget {
  const StockPlanner({Key? key}) : super(key: key);

  @override
  State<StockPlanner> createState() => _StockPlannerState();
}

class _StockPlannerState extends State<StockPlanner> {
  final StreamController<requestResponseState> _stockPlannerGet =
      StreamController.broadcast();
  final TextEditingController _date = TextEditingController();
  final TextEditingController plannerDateTextEditingController =
      TextEditingController();
  final TextEditingController stockPlannerQuantityTextEditingController =
      TextEditingController();
  final format = DateFormat("dd-MM-yyyy");
  String questionsSelected = 'Select Your Question *';
//
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
      Flushbar(
        message: "Stock Planner Added Successfully",
        duration: Duration(seconds: 2),
      ).show(context);
      fetchStockPlan();
      return 'null';
    } else {
      return throw (Exception("Search Error"));
    }
  }

  late stockPlanModel stockplan;

  Future<stockPlanModel> fetchStockPlan() async {
    var client = http.Client();
    final response = await client.get(
        Uri.parse('https://agromate.website/laravel/api/get_stock_planner'));
    final parsed = jsonDecode(response.body);
    //print(response.body);

    if (response.statusCode == 200) {
      stockplan = stockPlanModel.fromJson(parsed);
      myData = stockplan.data;
      _stockPlannerGet.add(requestResponseState.DataReceived);
      return stockplan;
    } else {
      Center(
        child: Text("Please Try Again After Some Time..."),
      );
    }
    return stockplan;
  }

  String? _selectedValue1;
  List<String> listOfValue1 = [
    'Stock 1',
    'Stock 2',
    'Stock 3',
    'Stock 4',
  ];

  var questions = [
    'Select Your Question *',
    'Question 1',
    'Question 2',
    'Question 3',
    'Question 4',
  ];
  var currentDate = DateTime.now();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  String? unitcost;
  String? plantPopulation;
  String? yield;
  String? weeks;
  TextEditingController controller = TextEditingController();

  List<StockData>? myData;

  late final Future warehouse;
  @override
  void initState() {
    super.initState();
    warehouse = stockPlannerAPI.getWarehouse();
    fetchStockPlan();
  }

  String? currentWarehouse;
  int? currentWarehouseId;
  buildPinAlert(screenSize) {
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
                                    DropdownButtonFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
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
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.red.shade900,
                                          ),
                                        ),
                                        errorStyle: TextStyle(
                                          fontSize: 16.0.sp,
                                        ),
                                      ),
                                      items: fetchedwarehouselist.map((e) {
                                        return DropdownMenuItem(
                                          child:
                                              Text(e.warehouseName.toString()),
                                          value: e.warehouseName,
                                        );
                                        //e.warehouseName.toString();
                                      }).toList(),

                                      //  listOfValue1.map((String val) {
                                      //   return DropdownMenuItem(
                                      //   enabled: true,
                                      //   value: val,
                                      //   child: Text(
                                      //     val,
                                      //   ),
                                      // );
                                      // }).toList(),
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
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter stock name';
                                        }
                                        return null;
                                      },
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
                                          top: 16,
                                          bottom: 16,
                                          left: 16,
                                          right: 16,
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
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.red.shade900,
                                          ),
                                        ),
                                        errorStyle: TextStyle(
                                          fontSize: 16.0.sp,
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
                                    DropdownButtonFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter stock name';
                                        }
                                        return null;
                                      },
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.red.shade900,
                                          ),
                                        ),
                                        errorStyle: TextStyle(
                                          fontSize: 16.0.sp,
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
                                            left: 16,
                                            right: 16,
                                            top: 19,
                                            bottom: 19),
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
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.red.shade900,
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
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter quantity';
                                        }
                                        return null;
                                      },
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
                                if (_form.currentState!.validate()) {
                                  addStockplannerAPI();
                                  Navigator.pop(context);
                                }
                                // else{
                                //   Flushbar(
                                //     message: "Enter all fields",
                                //     duration: Duration(seconds: 2),
                                //   );
                                // }
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

  @override
  Widget build(BuildContext context) {
    final List<bool> _selectedFruits = <bool>[true, false];
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          TopBar(),
          SizedBox(
            height: 20.w,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 30.w,
                        )),
                    sizedBoxHeight(30.w),
                    // SizedBox(width: screenSize.width * 0.02),
                    Text(
                      'Stock Planner',
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.bold),
                    ),
                    sizedBoxWidth(20.w),
                    // SizedBox(width: screenSize.width * 0.02),
                    Row(
                      children: [
                        InkWell(
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xff327C04),
                              border: Border.all(
                                color: const Color(0xff327C04),
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0.w, vertical: 3.h),
                              child: Text(
                                'Grid',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => Get.toNamed('/stockplannertable'),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffF7F9EA),
                              border: Border.all(
                                color: const Color(0xff327C04),
                              ),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 3),
                              child: Text(
                                'Table',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // ToggleButtons(
                    //   onPressed: (int index) {
                    //     setState(() {
                    //       // The button that is tapped is set to true, and the others to false.
                    //       for (int i = 0; i < _selectedFruits.length; i++) {
                    //         _selectedFruits[i] = i == index;
                    //       }
                    //     });
                    //   },
                    //   borderRadius:
                    //       const BorderRadius.all(Radius.circular(8)),
                    //   selectedBorderColor: Color(0xFF327c04),
                    //   selectedColor: Colors.white,
                    //   fillColor: Color(0xFF327c04),
                    //   color: Colors.black,
                    //   constraints: const BoxConstraints(
                    //     minHeight: 30.0,
                    //     minWidth: 60.0,
                    //   ),
                    //   isSelected: _selectedFruits,
                    //   children: options,
                    // ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              buildPinAlert(screenSize);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF327C04),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.w, vertical: 9.w),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Color(0xffffffff),
                                      size: 20.w,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      'Add',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Color(0xffffffff)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: SizedBox(
                              width: 180.w,
                              height: 40.w,
                              child: CupertinoSearchTextField(
                                onChanged: (value) {
                                  setState(() {
                                    stockplan.data = myData!
                                        .where((element) => element.stockName!
                                            .toLowerCase()
                                            .contains(value.toLowerCase()))
                                        .toList();
                                    // myData = filterData!
                                    //     .where(
                                    //       (element) => element.name!
                                    //           .toLowerCase()
                                    //           .contains(
                                    //             value.toLowerCase(),
                                    //           ),
                                    //     )
                                    //     .toList();
                                  });
                                },
                                // controller: controller,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xFF327C04),
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                  color:
                                      const Color(0xff327C04).withOpacity(0.11),
                                ),
                                itemSize: 25.w,
                                style: TextStyle(
                                  fontSize: 16.w,
                                  color: Color(0xff000000),
                                ),

                                // prefixInsets:
                                //     const EdgeInsetsDirectional.fromSTEB(
                                //         10, 8, 0, 8),
                                placeholder: 'Search',
                                suffixInsets:
                                    const EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 15, 2),
                                placeholderStyle: TextStyle(
                                  fontSize: 16.sp,
                                  color:
                                      const Color(0xff000000).withOpacity(0.38),
                                ),
                                padding: const EdgeInsets.all(0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.w),
                Divider(
                  // height: 5.w,
                  color: Colors.grey,
                  thickness: 1,
                ),
                SizedBox(height: 20.w),

                // SizedBox(height: screenSize.height * 0.03),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 300.w,
                      // width: screenSize.width * 0.28,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select Warehouse',
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 15.w),
                          SizedBox(
                            // height: 60.w,
                            child: DropdownButtonFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  top: 10.w,
                                  bottom: 10.w,
                                  left: 10.w,
                                  right: 10.w,
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 16.sp,
                                  color:
                                      const Color(0xff327C04).withOpacity(0.5),
                                  fontFamily: 'Helvetica',
                                ),
                                fillColor: Colors.transparent,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.w),
                                  borderSide: const BorderSide(
                                    width: 1,
                                    color: Color(0xff327C04),
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.w),
                                  borderSide: const BorderSide(
                                    width: 1,
                                    color: Color(0xff327C04),
                                  ),
                                ),
                                errorStyle: const TextStyle(
                                  fontSize: 14,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.w),
                                  borderSide: const BorderSide(
                                    width: 1,
                                    color: Color(0xff327C04),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.w),
                                  borderSide: const BorderSide(
                                    width: 1,
                                    color: Color(0xff327C04),
                                  ),
                                ),
                                isDense: true,
                              ),
                              isExpanded: true,
                              value: questionsSelected,
                              iconEnabledColor:
                                  Colors.transparent, // Down Arrow Icon
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Color(0xff327C04),
                              ),
                              iconSize: 30.w,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Color(0xff000000),
                                  fontFamily: 'Helvetica'),
                              items: questions.map((String items) {
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
                          ),
                        ],
                      ),
                    ),
                    sizedBoxWidth(20.w),
                    // SizedBox(width: screenSize.width * 0.03),
                    SizedBox(
                      width: 300.w,
                      // width: screenSize.width * 0.28,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start Date',
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 15.w),
                          SizedBox(
                            // height: 150.w,
                            child: DateTimeField(
                              // hei
                              cursorColor: const Color(0xff000000),
                              decoration: InputDecoration(
                                errorMaxLines: 3,
                                hintText: "Start Date",
                                contentPadding: EdgeInsets.only(
                                  top: 10.w,
                                  bottom: 10.w,
                                  left: 10.w,
                                  right: 10.w,
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 16.sp,
                                  // color: const Color(0xff161723).withOpacity(0.5),
                                  // fontFamily: 'Helvetica',
                                ),
                                // fillColor: Colors.white,
                                filled: true,
                                fillColor: Colors.transparent,
                                suffixIcon: Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(0, 6.w, 10.w, 6.w),
                                  child: Icon(
                                    CupertinoIcons.calendar_today,
                                    color: Color(0xff327C04),
                                    size: 30.w,
                                  ),
                                ),
                                suffixIconConstraints: BoxConstraints(
                                    maxHeight: 45.w, maxWidth: 45.w),
                                // icons
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.w),
                                  borderSide: const BorderSide(
                                    width: 1,
                                    color: Color(0xff327C04),
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.w),
                                  borderSide: const BorderSide(
                                    width: 1,
                                    color: Color(0xff327C04),
                                  ),
                                ),
                                errorStyle: TextStyle(
                                  fontSize: 16.sp,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.w),
                                  borderSide: const BorderSide(
                                    width: 1,
                                    color: Color(0xff327C04),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.w),
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
                                  builder:
                                      (BuildContext context, Widget? child) {
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
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: StreamBuilder<requestResponseState>(
                  stream: _stockPlannerGet.stream,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());

                      default:
                        if (snapshot.hasError) {
                          return Text("Error Occured");
                        } else {
                          return _buildgridview(context, screenSize, stockplan);
                        }
                    }
                  }),
            ),
          ),
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

Widget _buildgridview(context, screenSize, stockPlanModel stockplan) {
  return GridView.builder(
      shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      // scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: (
            // screenSize.height/screenSize.width
            1 / 0.5),
        crossAxisCount: 4,
      ),
      itemCount: stockplan.data!.length,
      itemBuilder: (BuildContext ctx, index) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            color: Color(0xfff7f9ea),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/Group6740.png",
                        // height: 40
                        height: 60.w,
                        width: 60.w,
                      ),

                      // sizedBoxHeight(15.w),
                      sizedBoxWidth(15.w),
                      // size
                      // size
                      // SizedBox(width: screenSize.width * 0.01),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            stockplan.data!.elementAt(index).stockName!,
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                          // sizedBoxHeight(10.w),
                          // SizedBox(height: screenSize.height * 0.01),
                          Row(
                            children: [
                              Text("Quantity : ",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    // fontWeight: FontWeight.bold
                                  )),
                              Text(
                                  stockplan.data!
                                      .elementAt(index)
                                      .quantity!
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    // fontWeight: FontWeight.bold
                                  ))
                            ],
                          ),
                          // sizedBoxHeight(10.w),

                          // SizedBox(height: screenSize.height * 0.01),
                          Row(
                            children: [
                              Text("Required : ",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    // fontWeight: FontWeight.bold
                                  )),
                              Text(
                                  stockplan.data!
                                      .elementAt(index)
                                      .quantity!
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    // fontWeight: FontWeight.bold
                                  ))
                            ],
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
}
