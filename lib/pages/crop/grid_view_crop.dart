import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_agro_new/component/custom_Elevated_Button.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:flutter_agro_new/models/cropPorgramModel.dart';
import 'package:flutter_agro_new/pages/crop/table_view_crop.dart';
import 'package:flutter_agro_new/pages/crop/view_details.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../component/text_Input_field.dart';

late CropProgramModel cropdata;

final GlobalKey<FormState> _form = GlobalKey<FormState>();
Future<CropProgramModel> fetchCropProgram() async {
  var client = http.Client();
  final response = await client
      .get(Uri.parse('https://agromate.website/laravel/api/get/program'));
  final parsed = jsonDecode(response.body);
  print(response.body);
  cropdata = CropProgramModel.fromJson(parsed);

  return cropdata;
}

class Crop extends StatefulWidget {
  const Crop({Key? key}) : super(key: key);

  @override
  State<Crop> createState() => _CropState();
}

class _CropState extends State<Crop> {
  final harvestTextEditingController = TextEditingController();
  @override
  void initState() {
    harvestTextEditingController.text = "14";
    super.initState();
  }

  late String _selectedValue;
  List<String> listOfValue = [
    'Week 1',
    'Week 2',
    'Week 3',
    'Week 4',
  ];
  buildPin() {
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  contentPadding: EdgeInsets.only(top: 10.0),
                  content: Padding(
                    padding: EdgeInsets.only(
                        top: 0, left: 25, right: 25, bottom: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.cancel_outlined))
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Add New Crop program",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Crop",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                        height: 40,
                                        width: 300,
                                        child: TextInputField(
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  25),
                                              FilteringTextInputFormatter.allow(
                                                  RegExp('[a-zA-Z]')),
                                            ],
                                            textEditingController:
                                                cropTextEditingController,
                                            hintText: "",
                                            validator: (value) {
                                              if (value != null &&
                                                  value.isEmpty) {
                                                return "Please Enter Crop Name";
                                              }
                                              return null;
                                            },
                                            validatorText: ""))
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Plant population",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                        height: 40,
                                        width: 300,
                                        child: TextInputField(
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  6),
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            textEditingController:
                                                populationTextEditingController,
                                            hintText: "",
                                            validator: (value) {
                                              if (value != null &&
                                                  value.isEmpty) {
                                                return "Please Enter plant population";
                                              }
                                              return null;
                                            },
                                            validatorText: ""))
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Week",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                        height: 40,
                                        width: 300,
                                        child: TextInputField(
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  6),
                                              FilteringTextInputFormatter.allow(
                                                  RegExp('[0-9]')),
                                            ],
                                            textEditingController:
                                                weeksTextEditingController,
                                            hintText: "",
                                            validator: (value) {
                                              if (value != null &&
                                                  value.isEmpty) {
                                                return "Please Enter week";
                                              }
                                              return null;
                                            },
                                            validatorText: "Please Enter Week"))
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Crop Season Description",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                      height: 40,
                                      width: 300,
                                      child: TextInputField(
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(
                                                25),
                                            FilteringTextInputFormatter.allow(
                                                RegExp('[a-zA-Z]')),
                                          ],
                                          textEditingController:
                                              cropseasonTextEditingController,
                                          hintText: "",
                                          validator: (value) {
                                            if (value != null &&
                                                value.isEmpty) {
                                              return "Please Enter Crop Season Description";
                                            }
                                            return null;
                                          },
                                          validatorText:
                                              "Please Enter Crop Season Description"),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Yield Per Hectare",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                        height: 40,
                                        width: 300,
                                        child: TextInputField(
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  6),
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            textEditingController:
                                                yieldTextEditingController,
                                            hintText: "",
                                            validator: (value) {
                                              if (value != null &&
                                                  value.isEmpty) {
                                                return "Please Enter yield Per Hectare";
                                              }
                                              return null;
                                            },
                                            validatorText: "")),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Harvest Days",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                        height: 40,
                                        width: 300,
                                        child: TextInputField(
                                            textEditingController:
                                                harvestTextEditingController,
                                            hintText: "Harvest Days",
                                            validatorText:
                                                "Please Enter harvest Days")),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 40,
                              width: 296,
                              child: CustomElevatedButton(
                                onPressed: () {
                                  final isValid =
                                      _form.currentState?.validate();
                                  if (isValid!) {
                                    addCropProgram().then((value) =>
                                        Navigator.pushNamed(
                                            context, '/grid_view_crop'));
                                    Flushbar(
                                      duration: const Duration(seconds: 2),
                                      message:
                                          "Crop Program Added Successfully",
                                    ).show(context);
                                  } else {
                                    Flushbar(
                                      duration: const Duration(seconds: 2),
                                      message: "Please Enter All Details",
                                    ).show(context);
                                  }
                                  // addCropProgram();
                                  // Navigator.pop(context);
                                },
                                title: "Add",
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopBar(),
          const SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Text(
                        'Select A Crop Program',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 20),
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
                            onTap: () => Get.toNamed('/table_view_crop'),
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
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          buildPin();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF327C04),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 4),
                            child: Text(
                              'Add Crop Program',
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xffffffff)),
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
              height: screenSize.height * 1 - 180,
              child: SingleChildScrollView(
                child: FutureBuilder<CropProgramModel>(
                  future: fetchCropProgram(),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        debugPrint(snapshot.data.toString());
                        return _buildgridview(context, cropdata);
                      } else {
                        return Center(
                          child: Text(
                            '${snapshot.error} occured',
                            style: const TextStyle(fontSize: 18),
                          ),
                        );
                      }
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),

                //     child: Wrap(
                //     spacing: 25,
                //     runSpacing: 25,
                //     children: List<Widget>.generate(
                //       12,
                //       (int index) => SizedBox(
                //         width: screenSize.width * 0.16,
                //         child: InkWell(
                //           onTap: () => Get.toNamed('/view_details'),
                //           child: Container(
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(10),
                //               boxShadow: [
                //                 BoxShadow(
                //                     color:
                //                         const Color(0xff000000).withOpacity(0.04),
                //                     offset: const Offset(0.0, 1.0),
                //                     blurRadius: 8.0,
                //                     spreadRadius: 5.0), //BoxShadow
                //                 const BoxShadow(
                //                   color: Colors.white,
                //                   offset: Offset(0.0, 0.0),
                //                   blurRadius: 0.0,
                //                   spreadRadius: 0.0,
                //                 ), //BoxShadow
                //               ],
                //             ),
                //             child: Padding(
                //               padding: const EdgeInsets.all(15.0),
                //               child: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   Row(
                //                     children: [
                //                       Image.asset('images/potato.png', width: 40),
                //                       const SizedBox(width: 10),
                //                       const Text(
                //                         'Potato',
                //                         style: TextStyle(
                //                           fontSize: 16,
                //                           color: Color(0xff000000),
                //                           fontWeight: FontWeight.w500,
                //                         ),
                //                       )
                //                     ],
                //                   ),
                //                   const SizedBox(height: 10),
                //                   const Text(
                //                     'Plant Population : 80000',
                //                     style: TextStyle(
                //                       fontSize: 14,
                //                       color: Color(0xff000000),
                //                     ),
                //                   ),
                //                   const SizedBox(height: 10),
                //                   const Text(
                //                     'Yield Per Hectares : 8000',
                //                     style: TextStyle(
                //                       fontSize: 14,
                //                       color: Color(0xff000000),
                //                     ),
                //                   ),
                //                   const SizedBox(height: 10),
                //                   const Text(
                //                     'Weeks : 20',
                //                     style: TextStyle(
                //                       fontSize: 14,
                //                       color: Color(0xff000000),
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildgridview(context, cropdata) {
  return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: (0.5 / 0.4),
          crossAxisCount: 5,
          mainAxisSpacing: 2,
          crossAxisSpacing: 3),
      itemCount: cropdata.data!.length,
      itemBuilder: (BuildContext ctx, index) {
        //  var element = CropProgram.cropPrograms.elementAt(index);
        return InkWell(
          onTap: () {
            debugPrint(index.toString());
            String weeks = cropdata.data!.elementAt(index).weeks!;
            debugPrint(weeks);
            int id = cropdata.data!.elementAt(index).id!;
            debugPrint(id.toString());
            print("pressed");
            // Get.toNamed("/view_details");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewDetails(
                  weeks: cropdata.data!.elementAt(index).weeks!,
                  id: cropdata.data!.elementAt(index).id!.toString(),
                ),
              ),
            );
          },
          child: Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset('images/potato.png', width: 40),
                      const SizedBox(width: 10),
                      Text(
                        cropdata.data!.elementAt(index).crop!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(
                        'Plant Population : ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff000000),
                        ),
                      ),
                      Text(
                        cropdata.data!.elementAt(index).population!,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(
                        'Yield Per Hectares : ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff000000),
                        ),
                      ),
                      Text(
                        cropdata.data!.elementAt(index).yield!,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(
                        'Weeks : ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff000000),
                        ),
                      ),
                      Text(
                        cropdata.data!.elementAt(index).weeks!,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
