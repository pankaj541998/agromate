import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:flutter_agro_new/pages/growth_stages/crop_program_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'growth_stage_model.dart';

class GrowthStageDetails extends StatefulWidget {
  const GrowthStageDetails({Key? key}) : super(key: key);

  @override
  State<GrowthStageDetails> createState() => _GrowthStageDetailsState();
}

class _GrowthStageDetailsState extends State<GrowthStageDetails> {
  Future<List<GrowthStageModel>> fetchGrowthStages() async {
    final response = await http.Client()
        .get(Uri.parse('https://agromate.website/laravel/api/get_all_data'));
    final parsed = jsonDecode(response.body)['data'] as List;
    return parsed
        .map<GrowthStageModel>((json) => GrowthStageModel.fromJson(json))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    GrowthStageCropProgramModel? growthStageModel = ModalRoute.of(context)!
        .settings
        .arguments as GrowthStageCropProgramModel?;
    debugPrint("GrowthStageDetails page ${growthStageModel?.id}");

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 26,
              ),
              Container(
                height: 60,
                width: double.infinity,
                color: Color(0xFFF7F9EA),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 40,
                    top: 18,
                  ),
                  child: Text(
                    "Crop: ${growthStageModel?.cropName}",
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
                            element.cropProgramId == growthStageModel?.id)
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
                              color: Color(0xFFF7F9EA),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset(
                                      "assets/images/seedlings_full_width.png"),
                                  SizedBox(
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
                                      // SizedBox(
                                      //   height: 10,
                                      // ),
                                      Text(
                                        "${growthStages.elementAt(index).startWeek} to ${growthStages.elementAt(index).endWeek}",
                                        style: TextStyle(
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
