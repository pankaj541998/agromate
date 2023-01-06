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

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

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
                          children:  [
                            Text(
                              "Crop",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
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
                        SizedBox(
                          height: screenSize.height * 0.7,
                          child: SingleChildScrollView(
                            child: GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: (1.3 / 1),
                                  crossAxisCount: 5,
                                  crossAxisSpacing: 25,
                                ),
                                itemCount: data.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  return InkWell(
                                    onTap: () {
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
                                },),
                          ),
                        )
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },),
                ),
      ],
    ),
    );
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
      shape: const RoundedRectangleBorder(
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
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.cropname ?? "",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                  borderSide: const BorderSide(color: Color(0xFFA1B809)),
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
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
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
