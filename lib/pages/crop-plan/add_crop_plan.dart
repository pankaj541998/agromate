import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddCropPlan extends StatefulWidget {
  const AddCropPlan({Key? key}) : super(key: key);

  @override
  State<AddCropPlan> createState() => _AddCropPlanState();
}

class _AddCropPlanState extends State<AddCropPlan> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("dd-MM-yyyy");

    String questionsSelected = 'Select Your Question *';

    var questions = [
      'Select Your Question *',
      'Question 1',
      'Question 2',
      'Question 3',
      'Question 4',
    ];
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
                                color: const Color(0xff327C04).withOpacity(0.5),
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
                        children: [
                          const Text(
                            'Irrigation Types',
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
                        children: [
                          const Text(
                            'Caltivar',
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
                  onPressed: () => Get.toNamed('/crop_plan'),
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
