import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_agro_new/component/custom_Elevated_Button.dart';
import 'package:flutter_agro_new/component/text_Input_field.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:get/get.dart';

import '../../component/dropdown_btn.dart';
import '../../models/cropPorgramModel.dart';
import 'crop_program_model.dart';

class GrowthStage extends StatefulWidget {
  const GrowthStage({
    Key? key,
  }) : super(key: key);

  @override
  State<GrowthStage> createState() => _GrowthStageState();
}

final crop = TextEditingController();

class _GrowthStageState extends State<GrowthStage> {
  Future<List<GrowthStageCropProgramModel>>
      fetchGrowthStageCropPrograms() async {
    final response = await http.Client()
        .get(Uri.parse('https://agromate.website/laravel/api/get/program'));
    final parsed = jsonDecode(response.body)['data'];
    List<GrowthStageCropProgramModel> mapped = parsed
        .map<GrowthStageCropProgramModel>(
            (json) => GrowthStageCropProgramModel.fromJson(json))
        .toList();
    return mapped;
  }

  late String _selectedValue1;
  String? _selectedValue2;
  late String _selectedValue3;
  List<String> listOfValue2 = [
    'Week 1',
    'Week 2',
    'Week 3',
    'Week 4',
  ];
  List<String> listOfValue3 = [
    'Week 1',
    'Week 2',
    'Week 3',
    'Week 4',
  ];
  List<String> listOfValue1 = [
    'Onion',
    'carrot',
    'potato',
  ];

  buildPin(context, List<GrowthStageCropProgramModel> data) {
    String selectedCropName = 'Select Crop';
    String selectedStartWeek = 'Select Week';
    String selectedEndWeek = 'Select Week';
    var growthNameController = TextEditingController();
    var descriptionController = TextEditingController();
    int? selectedCropId;
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDdState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AlertDialog(
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Add New Growth Stage",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.cancel_outlined))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Select Crop",
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
                                child: PopupMenuButton<String>(
                                  offset: const Offset(0, 48),
                                  itemBuilder: (BuildContext context) {
                                    return data
                                        .map((e) => PopupMenuItem<String>(
                                              value: e.cropName,
                                              child: Text(e.cropName),
                                              onTap: () => setDdState(
                                                () {
                                                  selectedCropName = e.cropName;
                                                  selectedCropId = e.id;
                                                },
                                              ),
                                            ))
                                        .toList();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Text(selectedCropName)),
                                          const Icon(
                                            Icons.keyboard_arrow_down,
                                            size: 19,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )

                                // DropdownBtn(
                                //   hint: selectedCropName,
                                //   isEnabled: true,
                                //   items: data
                                //       .map((cropProgramModel) =>
                                //           cropProgramModel.cropName)
                                //       .toList(),
                                //   onItemSelected: (value) {
                                //     setDdState(
                                //       () {
                                //         selectedCropName = value;
                                //       },
                                //     );
                                //   },
                                // ),

                                /*
                              DropdownButtonFormField(
                                hint: Text(_selectedValue2 ?? "Select Crop"),
                                focusColor: Colors.white,
                                isExpanded: true,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 10, top: 10, right: 10),
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xFF327C04)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xFF327C04)),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF327C04),
                                      width: 5.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                items: data
                                    .map((cropProgramModel) => DropdownMenuItem(
                                        enabled: true,
                                        value: cropProgramModel.cropName,
                                        child: Text(cropProgramModel.cropName)))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedValue2;
                                  });
                                },
                              ),
                            */
                                ),
                          ],
                        ),
                        SizedBox(
                          width: 35,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Growth Name",
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
                                    textEditingController: growthNameController,
                                    outlineColor: Colors.grey,
                                    hintText: "",
                                    validatorText: ""))
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Text(
                      "Description",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                        height: 100,
                        width: 629,
                        child: TextFormField(
                          controller: descriptionController,
                          maxLines: 5,
                          cursorColor: Color(0xFF327C04),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            hintStyle: const TextStyle(
                                color: Color(0x80000000), fontSize: 18),
                            hintText: "",
                          ),
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return "Password cannot be empty";
                            }
                            return null;
                          },
                        )),
                    SizedBox(
                      height: 14,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Start Week",
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
                                child: DropdownBtn(
                                    items: data
                                        .where((element) =>
                                            element.id == selectedCropId)
                                        .map((e) => e.weeks)
                                        .toList(),
                                    hint: selectedStartWeek)
                                /*
                              DropdownButtonFormField(
                                hint: Text("Select Week"),
                                focusColor: Colors.white,
                                isExpanded: true,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 10, top: 10, right: 10),
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xFF327C04)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xFF327C04)),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF327C04),
                                      width: 5.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                items: listOfValue2.map((String val) {
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
                                    _selectedValue2;
                                  });
                                },
                              ),
                            */
                                ),
                          ],
                        ),
                        SizedBox(
                          width: 35,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "End Week",
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
                                child: DropdownBtn(
                                    items: [], hint: selectedEndWeek)
/*
                              DropdownButtonFormField(
                                hint: Text("Select Week"),
                                focusColor: Colors.white,
                                isExpanded: true,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 10, top: 10, right: 10),
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xFF327C04)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xFF327C04)),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF327C04),
                                      width: 5.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                items: listOfValue3.map((String val) {
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
                                    _selectedValue2;
                                  });
                                },
                              ),
                            */
                                ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40,
                          width: 298,
                          child: CustomElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            title: "Submit",
                          ),
                        ),
                      ],
                    )
                  ],
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
    return Scaffold(
        body: Column(
      children: [
        TopBar(),
        Padding(
            padding:
                const EdgeInsets.only(left: 50, right: 50, top: 26, bottom: 21),
            child: FutureBuilder<List<GrowthStageCropProgramModel>>(
                future: fetchGrowthStageCropPrograms(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    List<GrowthStageCropProgramModel> data = snapshot.data!;
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Crop",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 30,
                              width: 92,
                              child: ElevatedButton(
                                  onPressed: () {
                                    buildPin(context, data);
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color(0xFF327C04))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 19,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'ADD',
                                        style: TextStyle(fontSize: 16),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 1,
                          color: Color(0xFFD6D6D6),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: (1.3 / 1),
                              crossAxisCount: 5,
                              crossAxisSpacing: 25,
                            ),
                            itemCount: data.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return InkWell(
                                onTap: () {
                                  // Get.toNamed('/growthstagedetails');
                                  Navigator.pushNamed(
                                    context,
                                    '/growthstagedetails',
                                    arguments: data.elementAt(index),
                                  );
                                },
                                child: CropCard(
                                  cropname: data.elementAt(index).cropName,
                                  cropimage: "assets/images/onion.png",
                                ),
                              );
                            })
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                })),
      ],
    ));
  }
}

class CropCard extends StatefulWidget {
  const CropCard({Key? key, this.cropname, this.cropimage}) : super(key: key);
  final String? cropname;
  final String? cropimage;
  @override
  State<CropCard> createState() => _CropCardState();
}

class _CropCardState extends State<CropCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            // "assets/images/onion.png",
            widget.cropimage ?? "",
            height: 100,
            width: 76,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.cropname ?? "",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
            readOnly: true,
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
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: Color(0xFF327C04)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: Color(0xFFA1B809)),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFA1B809)),
                  borderRadius: BorderRadius.circular(10)),
              suffixIcon: widget.showDropDown
                  ? PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.expand_circle_down_outlined,
                      ),
                      onSelected: (String value) {
                        setState(() {
                          controller.text = value;
                        });
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(
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
