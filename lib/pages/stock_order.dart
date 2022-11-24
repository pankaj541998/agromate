import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:flutter_agro_new/pages/stock_planner.dart';

import '../component/custom_Elevated_Button.dart';
import '../component/text_Input_field.dart';

class StockOrder extends StatefulWidget {
  const StockOrder({Key? key}) : super(key: key);

  @override
  State<StockOrder> createState() => _StockOrderState();
}

class _StockOrderState extends State<StockOrder> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  String? crop;
  String? plantPopulation;
  String? yield;
  String? weeks;
  TextEditingController controller = TextEditingController();

  buildPinAlertDialog() {
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
                      "Add New Crop Program",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Farm",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 70,
                                width: 250,
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(25),
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-zA-Z]')),
                                  ],
                                  onChanged: (value) => crop = value,
                                  decoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2.0),
                                    ),
                                    contentPadding: EdgeInsets.all(10),
                                    hintText: 'Enter Farm Name',
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Color(0xFF707070), width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Color(0xFF707070), width: 1.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter Farm";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Block",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 70,
                                width: 250,
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(25),
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-zA-Z]')),
                                  ],
                                  onChanged: (value) => crop = value,
                                  decoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2.0),
                                    ),
                                    contentPadding: EdgeInsets.all(10),
                                    hintText: 'Enter Block Name',
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Color(0xFF707070), width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Color(0xFF707070), width: 1.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter Block";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 25,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Field",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 70,
                                width: 250,
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(25),
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-zA-Z]')),
                                  ],
                                  onChanged: (value) => crop = value,
                                  decoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2.0),
                                    ),
                                    contentPadding: EdgeInsets.all(10),
                                    hintText: 'Enter Field Name',
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Color(0xFF707070), width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Color(0xFF707070), width: 1.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter Field";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Crop",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 70,
                                width: 250,
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(25),
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-zA-Z]')),
                                  ],
                                  onChanged: (value) => crop = value,
                                  decoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2.0),
                                    ),
                                    contentPadding: EdgeInsets.all(10),
                                    hintText: 'Enter Crop Name',
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Color(0xFF707070), width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Color(0xFF707070), width: 1.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter Crop";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 25,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Warehouse",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 70,
                                width: 250,
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(25),
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-zA-Z]')),
                                  ],
                                  onChanged: (value) => crop = value,
                                  decoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2.0),
                                    ),
                                    contentPadding: EdgeInsets.all(10),
                                    hintText: 'Enter Warehouse Name',
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Color(0xFF707070), width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Color(0xFF707070), width: 1.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter Warehouse";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Person",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 70,
                                width: 250,
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(25),
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-zA-Z]')),
                                  ],
                                  onChanged: (value) => crop = value,
                                  decoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2.0),
                                    ),
                                    contentPadding: EdgeInsets.all(10),
                                    hintText: 'Enter Person Name',
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Color(0xFF707070), width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Color(0xFF707070), width: 1.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter Person";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
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
                        width: 298,
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
                        'Stock order',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff000000),
                            fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                buildPinAlertDialog();
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
                                  controller: controller,
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
                  SizedBox(
                    height: screenSize.height * 0.7,
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

Widget _buildgridview(context, screenSize) {
  return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 2,
        crossAxisCount: 3,
      ),
      itemCount: 5,
      itemBuilder: (BuildContext ctx, index) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: Card(
            color: Color(0xfff7f9ea),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                    height: 40, "assets/images/Group308.png"),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Farm",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Varkaplass",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                    height: 40, "assets/images/Group309.png"),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Block",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "A",
                                      // cropPlan
                                      //     .elementAt(index)
                                      //     .hectarage
                                      //     .toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                    height: 40, "assets/images/Group310.png"),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Field",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "A1A",
                                      // cropPlan
                                      //     .elementAt(index)
                                      //     .farmerId
                                      //     .toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                    height: 40, "assets/images/Group311.png"),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Person",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Raj",
                                      // cropPlan
                                      //     .elementAt(index)
                                      //     .fieldId
                                      //     .toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                    height: 40, "assets/images/Group312.png"),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Crop",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Potato",
                                      // cropPlan
                                      //     .elementAt(index)
                                      //     .planneddate
                                      //     .toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                    height: 40, "assets/images/Group313.png"),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Stage",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Pre Planting",
                                      // cropPlan
                                      //     .elementAt(index)
                                      //     .stageId
                                      //     .toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
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



// buildPin(context) {
//   return showDialog(
//     context: context,
//     builder: (context) => StatefulBuilder(
//       builder: (context, setState) {
//         return Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             AlertDialog(
//               content: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         "Add New Growth Stage",
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.w500),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Select Crop",
//                             style: TextStyle(
//                               fontSize: 18,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 15,
//                           ),
//                           SizedBox(
//                               height: 50,
//                               width: 300,
//                               child: TextDropdown(
//                                   items: const ['Onion', 'Potato', 'Carrot'],
//                                   controller: crop,
//                                   showDropDown: true))
//                         ],
//                       ),
//                       SizedBox(
//                         width: 35,
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Growth Name",
//                             style: TextStyle(
//                               fontSize: 18,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 15,
//                           ),
//                           SizedBox(
//                               height: 50,
//                               width: 300,
//                               child: TextInputField(
//                                   hintText: "", validatorText: ""))
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 18,
//                   ),
//                   Text(
//                     "Description",
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   SizedBox(
//                       height: 100,
//                       width: 629,
//                       child: TextFormField(
//                         maxLines: 5,
//                         cursorColor: Color(0xFF327C04),
//                         autovalidateMode: AutovalidateMode.onUserInteraction,
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: Colors.white,
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide:
//                                 const BorderSide(color: Color(0xFFA1B809)),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide:
//                                 const BorderSide(color: Color(0xFFA1B809)),
//                           ),
//                           errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: const BorderSide(color: Colors.red),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: const BorderSide(color: Colors.red),
//                           ),
//                           hintStyle: const TextStyle(
//                               color: Color(0x80000000), fontSize: 18),
//                           hintText: "",
//                         ),
//                         validator: (value) {
//                           if (value != null && value.isEmpty) {
//                             return "Password cannot be empty";
//                           }
//                           return null;
//                         },
//                       )),
//                   SizedBox(
//                     height: 14,
//                   ),
//                   Row(
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Start Week",
//                             style: TextStyle(
//                               fontSize: 18,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 15,
//                           ),
//                           SizedBox(
//                               height: 50,
//                               width: 300,
//                               child: TextDropdown(
//                                   items: const ['Onion', 'Potato', 'Carrot'],
//                                   controller: crop,
//                                   showDropDown: true))
//                         ],
//                       ),
//                       SizedBox(
//                         width: 35,
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "End Week",
//                             style: TextStyle(
//                               fontSize: 18,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 15,
//                           ),
//                           SizedBox(
//                               height: 50,
//                               width: 300,
//                               child: TextDropdown(
//                                   items: const ['Onion', 'Potato', 'Carrot'],
//                                   controller: crop,
//                                   showDropDown: true))
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 25,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         height: 40,
//                         width: 298,
//                         child: customElevatedButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           title: "Submit",
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     ),
//   );
// }
