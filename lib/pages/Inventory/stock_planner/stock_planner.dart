import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import '../../../component/custom_Elevated_Button.dart';

const List<Widget> options = <Widget>[Text('Grid'), Text('Table')];

class StockPlanner extends StatefulWidget {
  const StockPlanner({Key? key}) : super(key: key);

  @override
  State<StockPlanner> createState() => _StockPlannerState();
}

class _StockPlannerState extends State<StockPlanner> {
  final TextEditingController _date = TextEditingController();
  final format = DateFormat("dd-MM-yyyy");
  String questionsSelected = 'Select Your Question *';
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

  buildPinAlertDialog(screenSize) {
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
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
                      "Add New Stock",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                content: Form(
                  key: _form,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Image.asset(
                              height: 70, "assets/images/Group6740.png"),
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
                                  'Select Warehouse',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                TextFormField(
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
                                    hintText: "Enter Warehouse",
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
                            width: 25,
                          ),
                          SizedBox(
                            width: screenSize.width * 0.21,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'End Date',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                DateTimeField(
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
                                          DateTime.now().subtract(
                                              const Duration(days: 4745)),
                                      // lastDate: DateTime(2100));
                                      lastDate: DateTime.now(),
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
                                TextFormField(
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
                                    hintText: "Enter Stock Name",
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
                            width: 25,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 40,
                        width: screenSize.width * 0.21,
                        child: customElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
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
        },
      ),
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
                          child: Icon(Icons.arrow_back_ios_rounded)),
                      SizedBox(width: screenSize.width * 0.02),
                      Text(
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
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 3),
                                child: Text(
                                  'Grid',
                                  style: TextStyle(
                                    fontSize: 16,
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
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 3),
                                child: Text(
                                  'Table',
                                  style: TextStyle(
                                    fontSize: 16,
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
                                  placeholder: 'Search Celeb....',
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
                  Divider(
                    height: 5,
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  SizedBox(height: screenSize.height * 0.03),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: screenSize.width * 0.28,
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
                              value: questionsSelected,
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
                          ],
                        ),
                      ),
                      SizedBox(width: screenSize.width * 0.03),
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
                              cursorColor: const Color(0xff000000),
                              decoration: InputDecoration(
                                errorMaxLines: 3,
                                hintText: "Start Date",
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
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: screenSize.height * 0.57,
                    child: _buildgridview(context, screenSize),
                  ),
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

Widget _buildgridview(context, screenSize) {
  return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: (0.5 / 0.2),
        crossAxisCount: 4,
      ),
      itemCount: 12,
      itemBuilder: (BuildContext ctx, index) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            color: Color(0xfff7f9ea),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(height: 40, "assets/images/Group6740.png"),
                        SizedBox(width: screenSize.width * 0.01),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nitrogen",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: screenSize.height * 0.01),
                            Text("Quantity : 200ml"),
                            SizedBox(height: screenSize.height * 0.01),
                            Text("Required : 200ml"),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      });
}