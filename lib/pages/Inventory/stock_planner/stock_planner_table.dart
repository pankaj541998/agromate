import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../component/custom_Elevated_Button.dart';

const List<Widget> options = <Widget>[Text('Grid'), Text('Table')];

class StockPlannerTable extends StatefulWidget {
  const StockPlannerTable({Key? key}) : super(key: key);

  @override
  State<StockPlannerTable> createState() => _StockPlannerTableState();
}

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
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                contentPadding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Add New Stock",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Image.asset("assets/images/Group6740.png",
                              height: 70),
                        ],
                      ),
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
                          const SizedBox(
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
                          const SizedBox(
                            width: 25,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 40,
                        width: screenSize.width * 0.21,
                        child: CustomElevatedButton(
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
                  datatable(screenSize),
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

DataRow recentFileDataRow(var data) {
  return DataRow(
    cells: [
      DataCell(
          Align(alignment: Alignment.center, child: Text(data.id ?? "id"))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.warehouse.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.stockname.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.quantity.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.date.toString()))),
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

List<Data> myData = [
  Data(
    id: "1",
    warehouse: 'Lorem Ipsum',
    stockname: 'Nitrogen',
    date: '15-11-2022',
    quantity: '200',
  ),
  Data(
    id: "2",
    warehouse: 'Lorem Ipsum',
    stockname: 'Nitrogen',
    date: '15-11-2022',
    quantity: '200',
  ),
  Data(
    id: "3",
    warehouse: 'Lorem Ipsum',
    stockname: 'Nitrogen',
    date: '15-11-2022',
    quantity: '200',
  ),
  Data(
    id: "4",
    warehouse: 'Lorem Ipsum',
    stockname: 'Nitrogen',
    date: '15-11-2022',
    quantity: '200',
  ),
  Data(
    id: "5",
    warehouse: 'Lorem Ipsum',
    stockname: 'Nitrogen',
    date: '15-11-2022',
    quantity: '200',
  ),
  Data(
    id: "6",
    warehouse: 'Lorem Ipsum',
    stockname: 'Nitrogen',
    date: '15-11-2022',
    quantity: '200',
  ),
  Data(
    id: "7",
    warehouse: 'Lorem Ipsum',
    stockname: 'Nitrogen',
    date: '15-11-2022',
    quantity: '200',
  ),
  Data(
    id: "8",
    warehouse: 'Lorem Ipsum',
    stockname: 'Nitrogen',
    date: '15-11-2022',
    quantity: '200',
  ),
  Data(
    id: "9",
    warehouse: 'Lorem Ipsum',
    stockname: 'Nitrogen',
    date: '15-11-2022',
    quantity: '200',
  ),
  Data(
    id: "10",
    warehouse: 'Lorem Ipsum',
    stockname: 'Nitrogen',
    date: '15-11-2022',
    quantity: '200',
  ),
  Data(
    id: "11",
    warehouse: 'Lorem Ipsum',
    stockname: 'Nitrogen',
    date: '15-11-2022',
    quantity: '200',
  ),
  Data(
    id: "12",
    warehouse: 'Lorem Ipsum',
    stockname: 'Nitrogen',
    date: '15-11-2022',
    quantity: '200',
  ),
  Data(
    id: "13",
    warehouse: 'Lorem Ipsum',
    stockname: 'Nitrogen',
    date: '15-11-2022',
    quantity: '200',
  ),
  Data(
    id: "14",
    warehouse: 'Lorem Ipsum',
    stockname: 'Nitrogen',
    date: '15-11-2022',
    quantity: '200',
  ),
  Data(
    id: "15",
    warehouse: 'Lorem Ipsum',
    stockname: 'Nitrogen',
    date: '15-11-2022',
    quantity: '200',
  ),
  Data(
    id: "16",
    warehouse: 'Lorem Ipsum',
    stockname: 'Nitrogen',
    date: '15-11-2022',
    quantity: '200',
  ),
  Data(
    id: "17",
    warehouse: 'Lorem Ipsum',
    stockname: 'Nitrogen',
    date: '15-11-2022',
    quantity: '200',
  ),
  Data(
    id: "18",
    warehouse: 'Lorem Ipsum',
    stockname: 'Nitrogen',
    date: '15-11-2022',
    quantity: '200',
  ),
  Data(
    id: "19",
    warehouse: 'Lorem Ipsum',
    stockname: 'Nitrogen',
    date: '15-11-2022',
    quantity: '200',
  ),
];
