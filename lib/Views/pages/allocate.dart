import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/custom_Elevated_Button.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:flutter_agro_new/constants.dart';
import 'package:flutter_agro_new/database_api/methods/block_api_methods.dart';
import 'package:flutter_agro_new/database_api/methods/farm_api_methods.dart';
import 'package:flutter_agro_new/database_api/methods/field_api_methods.dart';
import 'package:flutter_agro_new/database_api/methods/users_api_methods.dart';
import 'package:flutter_agro_new/models/block.dart';
import 'package:flutter_agro_new/models/farm.dart';
import 'package:flutter_agro_new/models/field.dart';
import 'package:async/async.dart';
import 'package:flutter_agro_new/models/user1.dart';
import 'package:flutter_agro_new/Views/pages/growth_stages/dropdown_btn.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Allocate extends StatefulWidget {
  const Allocate({Key? key}) : super(key: key);

  @override
  State<Allocate> createState() => _AllocateState();
}

bool check = false;
bool check1 = false;
bool check2 = false;
bool check3 = false;
bool check4 = false;
bool check5 = false;
bool check6 = false;
bool check7 = false;

class _AllocateState extends State<Allocate> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  late String _selectedValue7;

  List<String> listOfValue7 = [
    'Labourer 1',
    'Labourer 2',
    'Labourer 3',
    'Labourer 4',
  ];

  Future<String> allocateAPI() async {
    print("reached");
    final _chuckerHttpClient = await http.Client();
    final http.Response response = await http.post(
        Uri.parse("https://agromate.website/laravel/api/add_allocation"),
        body: {
          "landholder_id": currentLandholderId.toString(),
          "farm_id": currentFarmId.toString(),
          "agronomist_id": currentAgronomistId.toString(), //"9".toString(),
          "manager_id": currentManagerId.toString(), // "16".toString(),
          "block_id": currentBlockId.toString(),
          "field_id": currentFieldId.toString(),
          "farmer_id": currentFarmerId.toString(), //"19".toString(),
          "labourer_id": "".toString(),
        });
    print("api resp is ${response.body}");
    if (response.statusCode == 200) {
      Flushbar(
        message: "Stock Order Added Successfully",
        duration: Duration(seconds: 2),
      );
      return 'null';
    } else {
      return throw (Exception("Search Error"));
    }
  }

  final FutureGroup futureGroup = FutureGroup();
  @override
  void initState() {
    super.initState();
    // futureGroup.add(UserApiMethods.fetchUsers());
    futureGroup.add(UserApiMethods.fetchUsers());
    futureGroup.add(FarmApiMethods.fetchFarms());
    futureGroup.add(BlockApiMethods.fetchBlocks());
    futureGroup.add(FieldApiMethods.fetchFields());
    futureGroup.add(UserApiMethods.fetchUsers());
    futureGroup.add(UserApiMethods.fetchUsers());
    futureGroup.close();
  }

  String? currentFarm;
  int? currentFarmId;

  String? currentLandholder;
  int? currentLandholderId;

  String? currentFarmer;
  int? currentFarmerId;

  String? currentAgronomist;
  int? currentAgronomistId;

  String? currentManager;
  int? currentManagerId;

  String? currentBlock;
  int? currentBlockId;

  String? currentField;
  int? currentFieldId;

  String? currentCrop;
  int? currentCropId;

  String? currentWarehouse;
  int? currentWarehouseId;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return FutureBuilder(
      future: futureGroup.future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          var data = snapshot.data!;
          var fetchedusers = data.elementAt(0) as List<UserModel>;
          var fetchedfarms = data.elementAt(1) as List<FarmModel>;
          var fetchedblock = data.elementAt(2) as List<BlockModel>;
          var fetchedfield = data.elementAt(3) as List<FieldModel>;
          var fetchedfarmer = data.elementAt(0) as List<UserModel>;
          var fetchedagronomist = data.elementAt(0) as List<UserModel>;

          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  TopBar(),
                  const SizedBox(
                    height: 45,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.05),
                    child: Form(
                      key: _form,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.arrow_back),
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                "Allocating Agronomist & Manager",
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
                            height: 10,
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
                                "Allocating User",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Landholder",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 257,
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
                                              .firstWhere((element) =>
                                                  "${element.firstName} ${element.lastName}" ==
                                                  currentLandholder)
                                              .id;

                                          debugPrint(
                                              currentLandholderId.toString());
                                          debugPrint(fetchedfarms.toString());
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Farm",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  DropdownBtn(
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

                                        debugPrint(currentFarmId.toString());
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Agronomist",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  DropdownBtn(
                                    items: fetchedusers
                                        .where((element) =>
                                            element.roleIndex ==
                                            Roles.Agronomist.index)
                                        .map((e) {
                                      return "${e.firstName} ${e.lastName}";
                                    }).toList(),
                                    hint: 'Select Agronomist',
                                    onItemSelected: (value) async {
                                      setState(() {
                                        currentAgronomist = value;
                                        currentAgronomistId = fetchedusers
                                            .firstWhere((element) =>
                                                "${element.firstName} ${element.lastName}" ==
                                                currentAgronomist)
                                            .id;

                                        debugPrint(
                                            currentAgronomistId.toString());
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Manager",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  DropdownBtn(
                                    items: fetchedusers
                                        .where((element) =>
                                            element.roleIndex ==
                                            Roles.Manager.index)
                                        .map((e) {
                                      return "${e.firstName} ${e.lastName}";
                                    }).toList(),
                                    hint: 'Select Manager',
                                    onItemSelected: (value) async {
                                      setState(() {
                                        currentManager = value;
                                        currentManagerId = fetchedusers
                                            .firstWhere((element) =>
                                                "${element.firstName} ${element.lastName}" ==
                                                currentManager)
                                            .id;

                                        debugPrint(currentManagerId.toString());
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
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
                                "Allocating Farmer & Labourer",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Block",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                /*
                                  DropdownBtn(
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

                                        debugPrint(currentBlockId.toString());
                                      });
                                    },
                                  ),
                                */
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Field",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  DropdownBtn(
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

                                        debugPrint(currentFieldId.toString());
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Farmer",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  DropdownBtn(
                                    items: fetchedusers
                                        .where((element) =>
                                            element.roleIndex ==
                                            Roles.Farmer.index)
                                        .map((e) {
                                      return "${e.firstName} ${e.lastName}";
                                    }).toList(),
                                    hint: 'Select Farmer',
                                    onItemSelected: (value) async {
                                      setState(() {
                                        currentFarmer = value;
                                        currentFarmerId = fetchedusers
                                            .firstWhere((element) =>
                                                "${element.firstName} ${element.lastName}" ==
                                                currentFarmer)
                                            .id;

                                        debugPrint(currentFarmerId.toString());
                                      });
                                    },
                                  ),
                                ],
                              ),
                              // Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Text(
                              //       "Labourer",
                              //       style: TextStyle(
                              //           fontSize: 20,
                              //           fontWeight: FontWeight.w500),
                              //     ),
                              //     SizedBox(
                              //       height: 15,
                              //     ),
                              //     DropdownBtn(
                              //       items: fetchedusers
                              //           .where((element) =>
                              //               element.roleIndex ==
                              //               Roles.Farmer.index)
                              //           .map((e) {
                              //         return "${e.firstName} ${e.lastName}";
                              //       }).toList(),
                              //       hint: 'Select Labourer',
                              //       onItemSelected: (value) async {
                              //         setState(() {
                              //           currentFarmer = value;
                              //           currentFarmerId = fetchedusers
                              //               .firstWhere((element) =>
                              //                   "${element.firstName} ${element.lastName}" ==
                              //                   currentFarmer)
                              //               .id;

                              //           debugPrint(currentFarmerId.toString());
                              //         });
                              //       },
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 296,
                                height: 40,
                                child: CustomElevatedButton(
                                  onPressed: () {
                                    allocateAPI();
                                    Get.toNamed("/allocation");
                                  },
                                  title: "Submit",
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return Scaffold(
          body: Column(
            children: [
              TopBar(),
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
