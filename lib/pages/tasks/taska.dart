import 'dart:convert';
import 'package:flutter_agro_new/component/dropdown_btn.dart';
import 'package:flutter_agro_new/constants.dart';
import 'package:flutter_agro_new/database_api/models/block.dart';
import 'package:flutter_agro_new/database_api/models/farm.dart';
import 'package:flutter_agro_new/database_api/models/field.dart';
import 'package:flutter_agro_new/database_api/models/user.dart';
import 'package:flutter_agro_new/models/cropPorgramModel.dart';
import 'package:flutter_agro_new/pages/tasks/weeklytask.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:flutter_agro_new/database_api/methods/block_api_methods.dart';
import 'package:flutter_agro_new/database_api/methods/farm_api_methods.dart';
import 'package:flutter_agro_new/database_api/methods/field_api_methods.dart';
import 'package:flutter_agro_new/database_api/methods/users_api_methods.dart';
import 'package:http/http.dart' as http;

late CropProgramModel tasksdata;

Future<CropProgramModel> fetchCropProgram() async {
  var client = http.Client();
  final response = await client
      .get(Uri.parse('https://agromate.website/laravel/api/get/program'));
  final parsed = jsonDecode(response.body);
  // print(response.body);
  tasksdata = CropProgramModel.fromJson(parsed);

  return tasksdata;
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
                                DropdownBtn(
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
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          SizedBox(
                            width: screenSize.width * 0.18,
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
                                const SizedBox(height: 15),
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
                                      });
                                    },
                                  ),
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
                                  'Block',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 15),
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
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          SizedBox(
                            width: screenSize.width * 0.18,
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
                                const SizedBox(height: 15),
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
                                      });
                                      debugPrint(currentField.toString());
                                      debugPrint(currentFieldId.toString());
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
                        child: FutureBuilder<CropProgramModel>(
                          future: fetchCropProgram(),
                          builder: (ctx, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData) {
                                debugPrint(snapshot.data.toString());
                                return _buildgridview(context, tasksdata);
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

  Widget _buildgridview(context, CropProgramModel tasksdata) {
    BuildContext? contextnew;
    contextnew = scaffoldkey.currentContext;
    return GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: (0.2 / 0.1),
            crossAxisCount: 4,
            mainAxisSpacing: 2,
            crossAxisSpacing: 3),
        itemCount: tasksdata.data!.length,
        itemBuilder: (BuildContext ctx, index) {
          //  var element = CropProgram.cropPrograms.elementAt(index);
          return InkWell(
            onTap: () {
              debugPrint("index is  $index");
              String weeks = tasksdata.data!.elementAt(index).weeks!;
              debugPrint("weeks is $weeks");
              int id = tasksdata.data!.elementAt(index).id!;
              debugPrint(id.toString());

              // Get.toNamed("/view_details");
              // context = scaffoldkey.currentContext;
              Navigator.push(
                context!,
                MaterialPageRoute(
                  builder: (context) => WeeklyTasks(
                    weeks: weeks,
                    id: id.toString(),
                  ),
                ),
              );
              // Get.toNamed('/weeklytasks');
            },
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/cabbage.png",
                            height: 40,
                            width: 40,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Crop : ",
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                tasksdata.data!.elementAt(index).crop!,
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Plant Population  : ",
                                  style: TextStyle(fontSize: 14)),
                              Text(tasksdata.data!.elementAt(index).population!,
                                  style: TextStyle(fontSize: 14)),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Weeks : ", style: TextStyle(fontSize: 14)),
                              Text(tasksdata.data!.elementAt(index).weeks!,
                                  style: TextStyle(fontSize: 14)),
                            ],
                          )
                        ],
                      )
                    ],
                  )),
            ),
          );
        });
  }
}
