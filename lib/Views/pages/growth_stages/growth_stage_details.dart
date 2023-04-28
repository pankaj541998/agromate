import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:flutter_agro_new/Views/pages/growth_stages/crop_program_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../component/custom_Elevated_Button.dart';
import '../../../component/dropdown_btn.dart';
import '../../../component/text_Input_field.dart';
import 'growth_stage_model.dart';
import 'package:async/async.dart';

class GrowthStageDetails extends StatefulWidget {
  const GrowthStageDetails({Key? key}) : super(key: key);

  @override
  State<GrowthStageDetails> createState() => _GrowthStageDetailsState();
}

class _GrowthStageDetailsState extends State<GrowthStageDetails> {
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

  Future<List<GrowthStageModel>> fetchGrowthStages() async {
    final response = await http.Client()
        .get(Uri.parse('https://agromate.website/laravel/api/get_all_data'));
    final parsed = jsonDecode(response.body)['data'] as List;
    return parsed
        .map<GrowthStageModel>((json) => GrowthStageModel.fromJson(json))
        .toList();
  }

  Future<bool> postGrowthStage({
    required String cropProgramId,
    required String growthName,
    required String description,
    required String startWeek,
    required String endWeek,
  }) async {
    var response = await http.post(
      Uri.parse('https://agromate.website/laravel/api/add_growth_stage'),
      body: <String, String>{
        "crop_program_id": cropProgramId,
        "growth_name": growthName,
        "description": description,
        "start_week": startWeek,
        "end_week": endWeek,
      },
    );
    if (response.statusCode == 200) return true;
    return false;
  }

  buildPin(context, GrowthStageCropProgramModel? growthStageCropProgramModel) {
    String selectedCropName = 'Select Crop';
    int? selectedCropWeeks;
    String selectedStartWeek = 'Select Week';
    String selectedEndWeek = 'Select Week';
    var growthNameController = TextEditingController();
    var descriptionController = TextEditingController();
    int? selectedCropId;

    bool showSubmitBtn = true;
    bool showSubmitBtnLoader = false;

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
                      child: TextInputField(
                        textEditingController: growthNameController,
                        outlineColor: Colors.grey,
                        hintText: "",
                        validatorText: "",
                      ),
                    ),
                    SizedBox(height: 18),
                    Text(
                      "Description",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 15),
                    SizedBox(
                        height: 100,
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
                                child: Builder(builder: (context) {
                                  var items = <String>[];
                                  if (growthStageCropProgramModel != null) {
                                    items = List.generate(
                                        int.parse(
                                            growthStageCropProgramModel.weeks),
                                        (index) => 'Week ${index + 1}');
                                  }
                                  return DropdownBtn(
                                    items: items,
                                    hint: selectedStartWeek,
                                    onItemSelected: (value) {
                                      setDdState(
                                        () {
                                          selectedStartWeek = value;
                                        },
                                      );
                                      debugPrint(
                                          'selectedStartWeek $selectedStartWeek');
                                    },
                                  );
                                })),
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
                                child: Builder(builder: (context) {
                                  var items = <String>[];
                                  if (growthStageCropProgramModel != null) {
                                    items = List.generate(
                                        int.parse(
                                            growthStageCropProgramModel.weeks),
                                        (index) => 'Week ${index + 1}');
                                  }
                                  return DropdownBtn(
                                    items: items,
                                    hint: selectedEndWeek,
                                    onItemSelected: (value) {
                                      setDdState(() {
                                        selectedEndWeek = value;
                                      });
                                      debugPrint(
                                          'selectedEndWeek $selectedEndWeek');
                                    },
                                  );
                                })),
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
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Visibility(
                                  visible: showSubmitBtnLoader,
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                Visibility(
                                  visible: showSubmitBtn,
                                  child: Expanded(
                                    child: CustomElevatedButton(
                                      onPressed: () {
                                        setDdState(() {
                                          showSubmitBtn = false;
                                          showSubmitBtnLoader = true;
                                        });
                                        debugPrint(
                                            'selectedCropName $selectedCropName');
                                        debugPrint(
                                            'selectedCropId $selectedCropId');
                                        debugPrint(
                                            'growthNameController ${growthNameController.text}');
                                        debugPrint(
                                            'growthDescController ${descriptionController.text}');
                                        debugPrint(
                                            'selectedStartWeek $selectedStartWeek');
                                        debugPrint(
                                            'selectedEndWeek $selectedEndWeek');

                                        postGrowthStage(
                                          cropProgramId:
                                              growthStageCropProgramModel!.id
                                                  .toString(),
                                          growthName: growthNameController.text,
                                          description:
                                              descriptionController.text,
                                          startWeek: selectedStartWeek,
                                          endWeek: selectedEndWeek,
                                        ).then((posted) {
                                          if (posted) {
                                            setDdState(() {
                                              showSubmitBtn = true;
                                              showSubmitBtnLoader = false;
                                            });
                                            Navigator.pop(context);
                                            setState(() {});
                                            Flushbar(
                                              duration: Duration(seconds: 2),
                                              message:
                                                  "Successfully added growth stage",
                                            );
                                            // ScaffoldMessenger.of(context)
                                            //     .clearSnackBars();
                                            // ScaffoldMessenger.of(context)
                                            //     .showSnackBar(
                                            //   SnackBar(
                                            //     content: Text(
                                            //         "Successfully added growth stage"),
                                            //   ),
                                            //  );
                                          } else {
                                            setDdState(() {
                                              showSubmitBtn = true;
                                              showSubmitBtnLoader = false;
                                            });
                                            Flushbar(
                                              duration: Duration(seconds: 2),
                                              message:
                                                  "Successfully added growth stage",
                                            );
                                            // ScaffoldMessenger.of(context)
                                            //     .clearSnackBars();
                                            // ScaffoldMessenger.of(context)
                                            //     .showSnackBar(SnackBar(
                                            //         content: Text(
                                            //             "Successfully added growth stage")));
                                          }
                                        });
                                      },
                                      title: "Submit",
                                    ),
                                  ),
                                ),
                              ],
                            )),
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
    GrowthStageCropProgramModel? growthStageCropProgramModel =
        ModalRoute.of(context)!.settings.arguments
            as GrowthStageCropProgramModel?;
    debugPrint("GrowthStageDetails page ${growthStageCropProgramModel?.id}");

    return Scaffold(
        body: ListView(
      children: [
        TopBar(),
        const SizedBox(
          height: 45,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.toNamed('/growthstage');
                      },
                      icon: Icon(Icons.arrow_back)),
                  SizedBox(
                    width: 13,
                  ),
                  Text(
                    "Growth Stages",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  SizedBox(
                    height: 30,
                    width: 92,
                    child: ElevatedButton(
                        onPressed: () {
                          buildPin(context, growthStageCropProgramModel);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Color(0xFF327C04),
                          ),
                        ),
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
              const SizedBox(height: 26),
              Container(
                height: 60,
                width: double.infinity,
                color: const Color(0xFFF7F9EA),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 40,
                    top: 18,
                  ),
                  child: Text(
                    "Crop: ${growthStageCropProgramModel?.cropName}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(
                height: 44,
              ),
              FutureBuilder(
                future: fetchGrowthStages(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    var data = snapshot.data!;
                    var growthStages = data
                        .where((element) =>
                            element.cropProgramId ==
                            growthStageCropProgramModel?.id)
                        .toList();
                    return GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: (2 / 1),
                          crossAxisCount: 5,
                        ),
                        itemCount: growthStages.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: const Color(0xFFF7F9EA),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset(
                                      "assets/images/seedlings_full_width.png"),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        growthStages
                                            .elementAt(index)
                                            .growthName,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "${growthStages.elementAt(index).startWeek} to ${growthStages.elementAt(index).endWeek}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              )
            ],
          ),
        )
      ],
    ));
  }
}
