import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:flutter_agro_new/pages/growth_stages/crop_program_model.dart';
import 'package:get/get.dart';

class GrowthStageDetails extends StatefulWidget {
  const GrowthStageDetails({Key? key}) : super(key: key);

  @override
  State<GrowthStageDetails> createState() => _GrowthStageDetailsState();
}

class _GrowthStageDetailsState extends State<GrowthStageDetails> {
  @override
  Widget build(BuildContext context) {
    GrowthStageCropProgramModel? growthStageModel = ModalRoute.of(context)!
        .settings
        .arguments as GrowthStageCropProgramModel?;
    debugPrint("GrowthStageDetails page $growthStageModel");

    return Scaffold(
        body: Column(
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
                  SizedBox(
                      height: 30,
                      width: 180,
                      child: TextFormField(
                        maxLines: 1,
                        cursorColor: Color(0xFF327C04),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 5, top: 5),
                          filled: true,
                          fillColor: Color(0xFFF7F9EA),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                const BorderSide(color: Color(0xFF327C04)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                const BorderSide(color: Color(0xFF327C04)),
                          ),
                          hintStyle: const TextStyle(
                              color: Color(0x80000000), fontSize: 14),
                          hintText: "Search",
                        ),
                      ))
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
                    "Crop: Onion",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                height: 44,
              ),
              GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: (2 / 1),
                    crossAxisCount: 5,
                    // crossAxisSpacing: 25,
                  ),
                  itemCount: 10,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Transplant",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                Text(
                                  "Week: W3",
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
                  }),
            ],
          ),
        )
      ],
    ));
  }
}
