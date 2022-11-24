import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/text_Input_field.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:get/get.dart';

class SelectField extends StatefulWidget {
  SelectField({Key? key}) : super(key: key);

  @override
  State<SelectField> createState() => _SelectFieldState();
}

class _SelectFieldState extends State<SelectField> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopBar(),
            SizedBox(
              height: 45,
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Start plotting your Field",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 30,
                          width: 144,
                          child: ElevatedButton(
                              onPressed: () {
                                Get.toNamed('/view_farm');
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xFF327C04))),
                              child: Text(
                                'View Farm',
                                style: TextStyle(fontSize: 16),
                              )),
                        )
                      ]),
                  Divider(
                    thickness: 1,
                    color: Color(0xFFD6D6D6),
                  ),
                  SizedBox(
                    height: 23,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Instructions",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(size: 10, Icons.circle),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Start by choosing a point on map",
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(size: 10, Icons.circle),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Then plot points according to the farm size you want and complete the polygon",
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          SizedBox(
                            height: 40,
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
                                color:
                                    const Color(0xff327C04).withOpacity(0.11),
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
                                color:
                                    const Color(0xff000000).withOpacity(0.38),
                              ),
                              padding: const EdgeInsets.only(
                                left: 5,
                                top: 0,
                                bottom: 0,
                                right: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Image.asset("assets/images/field.png"),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name of the field",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: 304,
                            child: TextInputField(
                                hintText: "Enter field name",
                                validatorText: ""),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 40,
                                width: 185,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        side: const BorderSide(
                                          color: Color(0xFF327C04),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    'Undo Point',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Color(0XFF000000),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              SizedBox(
                                height: 40,
                                width: 185,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        side: const BorderSide(
                                          color: Color(0xFF327C04),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    'Clear Point',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Color(0XFF000000),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              SizedBox(
                                height: 40,
                                width: 185,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0xFF327C04)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        side: const BorderSide(
                                          color: Color(0xFF327C04),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Submit Plot',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 38,
            ),
          ],
        ),
      ),
    );
  }
}
