import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final _formKey = GlobalKey<FormState>();

    final format = DateFormat("dd-MM-yyyy");

    String questionsSelected = 'Select Person';
    String CategorySelected = 'Select Category';
    var categories = [
      'Select Category',
      'Cat1',
      'Cat2',
      'Cat3',
      'Cat4',
      'Cat5'
    ];
    var questions = ['Select Person', '1', '2', '3', '4'];
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
                      'Add Task',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Divider(
            height: 5,
            color: Colors.grey,
            thickness: 1,
          ),
          const SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
            child: SizedBox(
              height: screenSize.height * 1 - 180,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      // key: _formKey,
                      child: Wrap(
                        spacing: 25,
                        runSpacing: 25,
                        children: [
                          SizedBox(
                            width: screenSize.width * 0.28,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Date',
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
                                    hintText: "Select Date",
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
                                    filled: false,
                                    fillColor: Colors.white,
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
                            width: screenSize.width * 0.28,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Person',
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
                          SizedBox(
                            width: screenSize.width * 0.28,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Title',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                TextFormField(
                                  style: const TextStyle(
                                    // color: Color(0xffffffff),
                                    fontFamily: 'Helvetica',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
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
                                      // color: const Color(0xffffffff).withOpacity(0.8),
                                      fontFamily: 'Helvetica',
                                    ),
                                    // fillColor: Colors.white,
                                    // filled: true,
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
                                  onSaved: (String? value) {
                                    debugPrint(
                                        'Value for field saved as "$value"');
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.28,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Description',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                TextFormField(
                                  style: const TextStyle(
                                    // color: Color(0xffffffff),
                                    fontFamily: 'Helvetica',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    fillColor: Colors.transparent,
                                    errorMaxLines: 3,
                                    hintText: "Description",
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
                                    // filled: true,
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
                                  onSaved: (String? value) {
                                    debugPrint(
                                        'Value for field saved as "$value"');
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.28,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Category',
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
                              ],
                            ),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.28,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Chemical',
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
                              ],
                            ),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.28,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Active Ingredients',
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
                              ],
                            ),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.28,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Quantity',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        style: const TextStyle(
                                          // color: Color(0xffffffff),
                                          fontFamily: 'Helvetica',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        decoration: InputDecoration(
                                          fillColor: Colors.transparent,
                                          errorMaxLines: 3,
                                          hintText: "Description",
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
                                          // filled: true,
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
                                        onSaved: (String? value) {
                                          debugPrint(
                                              'Value for field saved as "$value"');
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
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
                                        value: CategorySelected,
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
                              ],
                            ),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.28,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Time Of Application',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                TextFormField(
                                  style: const TextStyle(
                                    // color: Color(0xffffffff),
                                    fontFamily: 'Helvetica',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    fillColor: Colors.transparent,
                                    errorMaxLines: 3,
                                    hintText: "Time Of Application",
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
                                    // filled: true,
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
                                  onSaved: (String? value) {
                                    debugPrint(
                                        'Value for field saved as "$value"');
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.28,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Mode Of Application',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                TextFormField(
                                  style: const TextStyle(
                                    // color: Color(0xffffffff),
                                    fontFamily: 'Helvetica',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    fillColor: Colors.transparent,
                                    errorMaxLines: 3,
                                    hintText: "Mode Of Application",
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
                                    // filled: true,
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
                                  onSaved: (String? value) {
                                    debugPrint(
                                        'Value for field saved as "$value"');
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () => Get.toNamed('/tasks'),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
