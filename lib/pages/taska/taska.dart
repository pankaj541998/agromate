import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:get/get.dart';

import '../../test.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  String questionsSelected = 'Potato';
  var questions = ['Potato', 'Carrot', 'Onion', 'Cabbage'];
  String filterSelected = 'Complete';
  var filter = ['Complete', 'InComplete', 'Ongoing'];
  String landeholderSelected = 'Kishan';
  var landeholder = ['Kishan', 'Raj', 'Reethik'];
  String cropselected = 'Carrots';
  var crop = ['Green Mielies', 'Carrots', 'Sweet Corn'];
  List<bool> expanded = [false, false];
  int selected = 0; //attention
  int subselected = 0; //attention
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          TopBar(),
          const SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          const Text(
                            'Tasks',
                            style: TextStyle(
                                fontSize: 20,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(width: 15),
                          SizedBox(
                            width: 150,
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
                          ),
                          const SizedBox(width: 15),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xff327C04),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: 150,
                            height: 42,
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                canvasColor: const Color(0xff327C04),
                              ),
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
                                  fillColor: const Color(0xff327C04),
                                  filled: true,
                                  prefixIcon: const Icon(
                                    Icons.filter_alt_rounded,
                                    size: 25,
                                    color: Color(0xffffffff),
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
                                value: filterSelected,
                                iconEnabledColor:
                                    Colors.transparent, // Down Arrow Icon
                                icon: const Visibility(
                                    visible: false,
                                    child: Icon(Icons.arrow_downward)),
                                iconSize: 0,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xffffffff),
                                    fontFamily: 'Helvetica'),
                                items: filter.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    filterSelected = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () => Get.toNamed('/add_tasks'),
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
                                        color: Color(0xffffffff),
                                      ),
                                    )
                                  ],
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
              ],
            ),
          ),
          const Divider(
            height: 5,
            color: Colors.grey,
            thickness: 1,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: screenSize.width * 0.18,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Landholder',
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
                            value: landeholderSelected,
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
                            items: landeholder.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                landeholderSelected = newValue!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 50),
                    SizedBox(
                      width: screenSize.width * 0.18,
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
                            value: cropselected,
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
                                cropselected = newValue!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                accordian()
              ],
            ),
          ),
        ],
      ),
    );
  }

  accordian() {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      color: const Color(0xfffafafa),
      height: screenSize.height * 1 - 320,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              key: Key('builder ${selected.toString()}'), //attention
              padding:
                  const EdgeInsets.only(left: 13.0, right: 13.0, bottom: 25.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 15,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    Theme(
                      data: ThemeData()
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        iconColor: const Color(0xff327C04),
                        key: Key(
                          index.toString(),
                        ), //attention
                        initiallyExpanded: index == selected, //attention
                        tilePadding: const EdgeInsets.all(0),
                        title: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffffffff),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: const Color(0xff327C04),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Week - ${index + 1}',
                              style: const TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 16.0,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: subAccordian(),
                          ),
                        ],
                        onExpansionChanged: ((newState) {
                          if (newState) {
                            setState(() {
                              const Duration(seconds: 20000);
                              selected = index;
                            });
                          } else {
                            setState(() {
                              selected = -1;
                            });
                          }
                        }),
                      ),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  subAccordian() {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      color: const Color(0xfffafafa),
      height: screenSize.height * 0.4,
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            ListView.builder(
              key: Key('builder ${subselected.toString()}'), //attention
              padding:
                  const EdgeInsets.only(left: 13.0, right: 13.0, bottom: 25.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Theme(
                        data: ThemeData()
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          iconColor: const Color(0xff327C04),
                          childrenPadding: const EdgeInsets.only(
                              top: 10, left: 0, right: 0, bottom: 10),
                          key: Key(index.toString()), //attention
                          initiallyExpanded: index == subselected, //attention
                          title: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffffffff),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: const Color(0xff327C04),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Day - ${index + 1}',
                                style: const TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 16.0,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Column(
                                children: [
                                  RichText(
                                    text: const TextSpan(
                                      text: 'Task - 1 :',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              ' Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  RichText(
                                    text: const TextSpan(
                                      text: 'Task - 2 :',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              ' Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  RichText(
                                    text: const TextSpan(
                                      text: 'Task - 3 :',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              ' Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                          onExpansionChanged: ((newState) {
                            if (newState) {
                              setState(() {
                                const Duration(seconds: 20000);
                                subselected = index;
                              });
                            } else {
                              setState(() {
                                subselected = -1;
                              });
                            }
                          }),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
