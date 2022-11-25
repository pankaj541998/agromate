import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_agro_new/component/top_bar.dart';

import '../../../component/custom_Elevated_Button.dart';

class AddStock extends StatefulWidget {
  const AddStock({Key? key}) : super(key: key);

  @override
  State<AddStock> createState() => _AddStockState();
}

class _AddStockState extends State<AddStock> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  String? unitcost;
  String? plantPopulation;
  String? yield;
  String? weeks;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopBar(),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back_ios_rounded)),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Class',
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
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: InputDecoration(
                                        fillColor: Colors.transparent,
                                        errorMaxLines: 3,
                                        hintText: "Class",
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
                              SizedBox(width: screenSize.width * 0.045),
                              SizedBox(
                                width: screenSize.width * 0.2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        hintText: "Type",
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
                              SizedBox(width: screenSize.width * 0.045),
                              SizedBox(
                                width: screenSize.width * 0.2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            ],
                          ),
                          SizedBox(height: screenSize.height * 0.03),
                          Row(
                            children: [
                              SizedBox(
                                width: screenSize.width * 0.2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: InputDecoration(
                                        fillColor: Colors.transparent,
                                        errorMaxLines: 3,
                                        hintText: "ItemCode",
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
                              SizedBox(width: screenSize.width * 0.03),
                              SizedBox(
                                width: screenSize.width * 0.2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              SizedBox(width: screenSize.width * 0.03),
                              SizedBox(
                                width: screenSize.width * 0.2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: InputDecoration(
                                        fillColor: Colors.transparent,
                                        errorMaxLines: 3,
                                        hintText: "Unit Cost",
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
                              SizedBox(width: screenSize.width * 0.03),
                              SizedBox(
                                width: screenSize.width * 0.2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: InputDecoration(
                                        fillColor: Colors.transparent,
                                        errorMaxLines: 3,
                                        hintText: "Stock Level",
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
                            ],
                          ),
                          SizedBox(height: screenSize.height * 0.03),
                          Row(
                            children: [
                              SizedBox(
                                width: screenSize.width * 0.2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: InputDecoration(
                                        fillColor: Colors.transparent,
                                        errorMaxLines: 3,
                                        hintText: "Active Ingridient",
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
                              SizedBox(width: screenSize.width * 0.03),
                              SizedBox(
                                width: screenSize.width * 0.2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: InputDecoration(
                                        fillColor: Colors.transparent,
                                        errorMaxLines: 3,
                                        hintText: "AI/Kg",
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
                            ],
                          ),
                          SizedBox(height: screenSize.height * 0.03),
                          SizedBox(
                            width: screenSize.width * 0.6,
                            child: Card(
                              color: Color(0xfff7f9ea),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Card(
                                      color: Color(0xff327c04),
                                      child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(
                                            "Warnings",
                                            style: const TextStyle(
                                              color: Color(0xffffffff),
                                              fontFamily: 'Helvetica',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ))),
                                  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "Precautions",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Helvetica',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "Instructions",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Helvetica',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "Key Targets",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Helvetica',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "Time Of Application",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Helvetica',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "Modes Of Application",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Helvetica',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.03),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: screenSize.width * 0.3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Choose Warning',
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
                                              hintText: "Choose Warning",
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
                                    SizedBox(height: screenSize.height * 0.03),
                                    Row(
                                      children: const [
                                        Icon(Icons.check_box_outlined),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "This product is toxic to animals, bees, fish and other aquatic organisms",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenSize.height * 0.03),
                                    Row(
                                      children: const [
                                        Icon(Icons.check_box_outlined),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Highly Poisonous",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenSize.height * 0.03),
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
                              ]),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
