import 'dart:convert';
import 'package:flutter_agro_new/component/dropdown_btn.dart';
import 'package:flutter_agro_new/constants.dart';
import 'package:flutter_agro_new/database_api/models/block.dart';
import 'package:flutter_agro_new/database_api/models/farm.dart';
import 'package:flutter_agro_new/database_api/models/field.dart';
import 'package:flutter_agro_new/database_api/models/user.dart';
import 'package:flutter_agro_new/models/cropPorgramModel.dart';

import 'package:flutter_agro_new/models/crop_schedule_Model.dart';

import 'package:flutter_agro_new/pages/tasks/weeklytask.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:flutter_agro_new/database_api/methods/block_api_methods.dart';
import 'package:flutter_agro_new/database_api/methods/farm_api_methods.dart';
import 'package:flutter_agro_new/database_api/methods/field_api_methods.dart';
import 'package:flutter_agro_new/database_api/methods/users_api_methods.dart';
import 'package:http/http.dart' as http;

List filtereddata = [];
late CropProgramModel tasksdata;

late CropScheduleModel cropschedule;

Future<CropProgramModel> fetchCropProgram() async {
  var client = http.Client();
  final response = await client
      .get(Uri.parse('https://agromate.website/laravel/api/get/program'));
  final parsed = jsonDecode(response.body);
  // print(response.body);
  tasksdata = CropProgramModel.fromJson(parsed);

  return tasksdata;
}

Future<CropScheduleModel> fetchCropSchedule() async {
  var client = http.Client();
  final response = await client
      .get(Uri.parse('https://agromate.website/laravel/api/get/plan'));
  final parsed = jsonDecode(response.body);
  // print("api call data ${response.body}");
  cropschedule = CropScheduleModel.fromJson(parsed);

  return cropschedule;
}

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  String questionsSelected = 'Potato';
  var questions = ['Potato', 'Carrot', 'Onion', 'Cabbage'];

  String landeholderSelected = 'Kishan';
  var landeholder = ['Kishan', 'Raj', 'Reethik'];
  String farmSelected = 'farm 1';
  var farm = ['farm 1', 'farm 2', 'farm 3'];
  String blockselected = 'Carrots';
  var block = ['Green Mielies', 'Carrots', 'Sweet Corn'];
  String Fieldselected = 'Car';
  var field = ['Green ', 'Car', 'Sweet'];
  List<bool> expanded = [false, false];
  int selected = 0; //attention
  int subselected = 0; //attention
  final FutureGroup futureGroup = FutureGroup();

  String? currentLandholder;
  int? currentLandholderId;

  String? currentFarm;
  int? currentFarmId;

  String? currentBlock;
  int? currentBlockId;

  String? currentField;
  int? currentFieldId;

  String? currentCrop;
  int? currentCropId;

  @override
  void initState() {
    super.initState();
    futureGroup.add(UserApiMethods.fetchUsers());
    futureGroup.add(FarmApiMethods.fetchFarms());
    futureGroup.add(BlockApiMethods.fetchBlocks());
    futureGroup.add(FieldApiMethods.fetchFields());
    futureGroup.close();
  }

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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Tasks",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    )
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
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
            child: FutureBuilder(
              future: futureGroup.future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  var data = snapshot.data!;
                  var fetchedusers = data.elementAt(0) as List<UserModel>;
                  var fetchedfarms = data.elementAt(1) as List<FarmModel>;
                  var fetchedblock = data.elementAt(2) as List<BlockModel>;
                  var fetchedfield = data.elementAt(3) as List<FieldModel>;
                  return Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: screenSize.width * 0.22,
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
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: 700,
                                  child: DropdownBtn(
                                    items: fetchedusers
                                        .where((element) =>
                                            element.roleIndex ==
                                            Roles.Landholder.index)
                                        .map((e) {
                                      return "${e.firstName} ${e.lastName}";
                                    }).toList(),
                                    hint: 'Landholder',
                                    onItemSelected: (value) {
                                      setState(() {
                                        currentLandholder = value;
                                        currentLandholderId = fetchedusers
                                            .singleWhere((element) =>
                                                "${element.firstName} ${element.lastName}" ==
                                                currentLandholder)
                                            .id;
                                        filtereddata = cropschedule.data!
                                            .where((element) =>
                                                element
                                                    .farm!.first.landholderId ==
                                                currentLandholderId)
                                            .toList();
                                        debugPrint(
                                            currentLandholderId.toString());
                                        debugPrint(filtereddata.toString());
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: screenSize.width * 0.22,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Farm',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: 500,
                                  child: DropdownBtn(
                                    items: fetchedfarms
                                        .where((element) =>
                                            element.landholderId ==
                                            currentLandholderId)
                                        .map((e) => e.farmName!)
                                        .toList(),
                                    hint: 'Select Farm',
                                    onItemSelected: (value) async {
                                      setState(() {
                                        currentFarm = value;
                                        currentFarmId = fetchedfarms
                                            .singleWhere((element) =>
                                                element.farmName == currentFarm)
                                            .id;
                                        filtereddata = cropschedule.data!
                                            .where((element) =>
                                                element.farm!.first.id ==
                                                currentFarmId)
                                            .toList();
                                        debugPrint(currentFarmId.toString());
                                        debugPrint(filtereddata.toString());
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: screenSize.width * 0.218,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Block',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: 500,
                                  child: DropdownBtn(
                                    items: fetchedblock
                                        .where((element) =>
                                            element.farmId == currentFarmId)
                                        .map((e) => e.blockName!)
                                        .toList(),
                                    hint: 'Select Block',
                                    onItemSelected: (value) async {
                                      setState(() {
                                        currentBlock = value;
                                        currentBlockId = fetchedblock
                                            .singleWhere((element) =>
                                                element.blockName ==
                                                currentBlock)
                                            .id;
                                        filtereddata = cropschedule.data!
                                            .where((element) =>
                                                element.block!.first.id ==
                                                currentBlockId)
                                            .toList();
                                        debugPrint(currentBlockId.toString());
                                        debugPrint(filtereddata.toString());
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: screenSize.width * 0.218,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Field',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: 500,
                                  child: DropdownBtn(
                                    items: fetchedfield
                                        .where((element) =>
                                            element.blockId == currentBlockId)
                                        .map((e) => e.fieldName!)
                                        .toList(),
                                    hint: 'Select Field',
                                    onItemSelected: (value) async {
                                      setState(() {
                                        currentField = value;
                                        currentFieldId = fetchedfield
                                            .singleWhere((element) =>
                                                element.fieldName ==
                                                currentField)
                                            .id;
                                        filtereddata = cropschedule.data!
                                            .where((element) =>
                                                element.field!.first.id ==
                                                currentField)
                                            .toList();
                                        debugPrint(currentFieldId.toString());
                                        debugPrint(filtereddata.toString());
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        child: FutureBuilder<CropScheduleModel>(
                          future: fetchCropSchedule(),
                          builder: (ctx, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData) {
                                debugPrint(snapshot.data.toString());

                                return _buildgridview(context);
                              } else {
                                return Center(
                                  child: Text(
                                    '${snapshot.error} occured',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                );
                              }
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        ),
                      )
                    ],
                  );
                }

                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildgridview(
    context,
  ) {
    BuildContext? contextnew;
    contextnew = scaffoldkey.currentContext;
    return GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: (0.2 / 0.1),
            crossAxisCount: 4,
            mainAxisSpacing: 2,
            crossAxisSpacing: 3),
        itemCount: filtereddata.length,
        itemBuilder: (BuildContext ctx, index) {
          //  var element = CropProgram.cropPrograms.elementAt(index);
          return InkWell(
            onTap: () {
              debugPrint("index is  $index");
              String weeks =
                  cropschedule.data!.elementAt(index).cropProgram!.first.weeks!;
              debugPrint("weeks is $weeks");
              int id =
                  cropschedule.data!.elementAt(index).cropProgram!.first.id!;
              debugPrint(id.toString());
              int cropplanid = cropschedule.data!.elementAt(index).id!;
              debugPrint(id.toString());
              String farmsend =
                  cropschedule.data!.elementAt(index).farm!.first.farm!;
              String blocksend =
                  cropschedule.data!.elementAt(index).block!.first.block!;
              String fieldsend =
                  cropschedule.data!.elementAt(index).field!.first.field!;
              String cropsend =
                  cropschedule.data!.elementAt(index).cropProgram!.first.crop!;
              Navigator.push(
                context!,
                MaterialPageRoute(
                  builder: (context) => WeeklyTasks(
                    weeks: weeks,
                    id: id.toString(),
                    cropplanid: cropplanid.toString(),
                    farmsend: farmsend,
                    blocksend: blocksend,
                    fieldsend: fieldsend,
                    cropsend: cropsend,
                  ),
                ),
              );
            },
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      // Image.asset(
                      //   "assets/images/cabbage.png",
                      //   height: 40,
                      //   width: 40,
                      // )
                      // ],
                      // ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/cabbage.png",
                                height: 40,
                                width: 40,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                cropschedule
                                    .data!.first.cropProgram!.first.crop!,
                                // cropschedule.data!
                                //     .elementAt(index)
                                //     .cropProgram!
                                //     .first
                                //     .crop!,
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Crop Ref: ",
                                  style: TextStyle(fontSize: 14)),
                              Text(
                                  cropschedule.data!
                                      .elementAt(index)
                                      .cropReference!,
                                  style: TextStyle(fontSize: 14)),
                            ],
                          ),
                          // Row(
                          //   children: [
                          //     Text("Weeks : ", style: TextStyle(fontSize: 14)),
                          //     Text(tasksdata.data!.elementAt(index).weeks!,
                          //         style: TextStyle(fontSize: 14)),
                          //   ],
                          // )
                        ],
                      )
                    ],
                  )),
            ),
          );
        });
  }
}
