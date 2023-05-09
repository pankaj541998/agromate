import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:flutter_agro_new/database_api/methods/stock_planner_api_methods.dart';
import 'package:flutter_agro_new/models/block.dart';
import 'package:flutter_agro_new/models/crop.dart';
import 'package:flutter_agro_new/models/farm.dart';
import 'package:flutter_agro_new/models/field.dart';
import 'package:flutter_agro_new/models/user1.dart';
import 'package:flutter_agro_new/models/fetch_Warehouse_Model.dart';
import 'package:flutter_agro_new/models/stock_order_model.dart';
import 'package:flutter_agro_new/providers/map_filter_provider.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../../component/custom_Elevated_Button.dart';
import '../../../../constants.dart';
import '../../../../database_api/methods/block_api_methods.dart';
import '../../../../database_api/methods/crop_program_api_method.dart';
import '../../../../database_api/methods/farm_api_methods.dart';
import '../../../../database_api/methods/field_api_methods.dart';
import '../../../../database_api/methods/users_api_methods.dart';
import '../../../../main.dart';
import '../../growth_stages/dropdown_btn.dart';

//late stockOrderModel stockorder;

class StockOrder extends StatefulWidget {
  const StockOrder({Key? key}) : super(key: key);

  @override
  State<StockOrder> createState() => _StockOrderState();
}

class _StockOrderState extends State<StockOrder> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  MapboxMapController? mapController;
  String? crop;
  String? plantPopulation;
  String? yield;
  String? weeks;
  final StreamController<requestResponseState> _stockOrderGet =
      StreamController.broadcast();
  TextEditingController controller = TextEditingController();
  late final Future stockorder;
  late stockOrderModel stockOrderData;
  Future<String> addStockorderAPI() async {
    print("reached");
    final _chuckerHttpClient = await http.Client();
    final http.Response response = await http.post(
        Uri.parse("https://agromate.website/laravel/api/add_stock_order"),
        body: {
          "farm_id": currentFarmId.toString(),
          "block_id": currentBlockId.toString(),
          "field_id": currentFieldId.toString(),
          "crop_id": currentCropId.toString(),
          "warehouse_id": currentWarehouseId.toString(),
          "user_id": currentLandholderId.toString()
        });
    print("api resp is ${response.body}");
    if (response.statusCode == 200) {
      Flushbar(
        message: "Stock Order Added Successfully",
        duration: Duration(seconds: 2),
      ).show(context);
      fetchStockOrder();
      return 'null';
    } else {
      return throw (Exception("Search Error"));
    }
  }

  Future fetchStockOrder() async {
    var client = http.Client();
    final response = await client
        .get(Uri.parse('https://agromate.website/laravel/api/get_stock_order'));
    final parsed = jsonDecode(response.body);
    //print(response.body);

    if (response.statusCode == 200) {
      stockOrderData = stockOrderModel.fromJson(parsed);
      myData = stockOrderData.data;
      _stockOrderGet.add(requestResponseState.DataReceived);
      return stockOrderData;
    } else {
      Center(
        child: Text("Please Try Again After Some Time..."),
      );
    }
    return stockOrderData;
  }

  final FutureGroup futureGroup = FutureGroup();
  @override
  void initState() {
    super.initState();
    fetchStockOrder();
    futureGroup.add(UserApiMethods.fetchUsers());
    futureGroup.add(FarmApiMethods.fetchFarms());
    futureGroup.add(BlockApiMethods.fetchBlocks());
    futureGroup.add(FieldApiMethods.fetchFields());
    futureGroup.add(CropApiMethods.fetchCrops());
    futureGroup.add(stockPlannerAPI.getWarehouse());
    futureGroup.close();
  }

  List<StockOrderData>? myData;

  String? currentFarm;
  int? currentFarmId;

  String? currentLandholder;
  int? currentLandholderId;

  String? currentBlock;
  int? currentBlockId;

  String? currentField;
  int? currentFieldId;

  String? currentCrop;
  int? currentCropId;

  String? currentWarehouse;
  int? currentWarehouseId;

  buildPinAlert(screenSize) {
    return showDialog(
        context: context,
        builder: (context) => _buildbody(context, screenSize));
  }

  Widget _buildbody(context, screenSize) {
    return StatefulBuilder(
      builder: (context, setState) {
        return FutureBuilder(
          future: futureGroup.future,
          builder: (context, snapshot) {
            var watchProvider = context.watch<MapFilterProvider>();
            var readProvider = context.read<MapFilterProvider>();
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              var data = snapshot.data!;
              var fetchedusers = data.elementAt(0) as List<UserModel>;
              var fetchedfarms = data.elementAt(1) as List<FarmModel>;
              var fetchedblock = data.elementAt(2) as List<BlockModel>;
              var fetchedfield = data.elementAt(3) as List<FieldModel>;
              var fetchedcrop = data.elementAt(4) as List<CropPModel>;
              var fetchedwarehouse = data.elementAt(5) as List<fetchWarehouse>;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AlertDialog(
                    insetPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    contentPadding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Add Stock Order",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
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
                              SizedBox(
                                width: screenSize.width * 0.2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'landholder',
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

                                          debugPrint(
                                              currentLandholderId.toString());
                                          debugPrint(fetchedfarms.toString());
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              SizedBox(
                                width: screenSize.width * 0.2,
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
                                                  element.farmName ==
                                                  currentFarm)
                                              .id;

                                          debugPrint(currentFarmId.toString());
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: screenSize.width * 0.2,
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
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              SizedBox(
                                width: screenSize.width * 0.2,
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
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: screenSize.width * 0.2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Crop',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    DropdownBtn(
                                      items: fetchedcrop.map((e) {
                                        return e.crop.toString();
                                      }).toList(),
                                      hint: 'Select Crop',
                                      onItemSelected: (value) async {
                                        debugPrint(value);
                                        currentCrop = value;
                                        currentCropId = fetchedcrop
                                            .singleWhere((element) =>
                                                element.crop == value)
                                            .id;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              SizedBox(
                                width: screenSize.width * 0.2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Warehouse',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    DropdownBtn(
                                      items: fetchedwarehouse.map((e) {
                                        return e.warehouseName.toString();
                                      }).toList(),
                                      hint: 'Select Warehouse',
                                      onItemSelected: (value) async {
                                        debugPrint(value);
                                        currentWarehouse = value;
                                        currentWarehouseId = fetchedwarehouse
                                            .singleWhere((element) =>
                                                element.warehouseName == value)
                                            .id;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: 40,
                            width: 298,
                            child: CustomElevatedButton(
                              onPressed: () {
                                addStockorderAPI();
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
      },
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
                          child: const Icon(Icons.arrow_back_ios_rounded)),
                      SizedBox(width: screenSize.width * 0.02),
                      const Text(
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
                                buildPinAlert(screenSize);
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
                                    setState(() {
                                      stockOrderData.data = myData!
                                          .where(
                                            (element) => element
                                                .farm!.first.farm!
                                                .toLowerCase()
                                                .contains(
                                                  value.toLowerCase(),
                                                ),
                                          )
                                          .toList();
                                    });
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
                                  placeholder: 'Search',
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
                  const Divider(
                    height: 5,
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  SizedBox(height: screenSize.height * 0.03),
                  SizedBox(
                    height: screenSize.height * 0.7,
                    child: StreamBuilder<requestResponseState>(
                        stream: _stockOrderGet.stream,
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(child: CircularProgressIndicator());

                            default:
                              if (snapshot.hasError) {
                                return Text("Error Occured");
                              } else {
                                return _buildgridview(
                                    context, screenSize, stockOrderData);
                              }
                          }
                        }),
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

Widget _buildgridview(context, screenSize, stockOrderModel stockOrderData) {
  return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 2,
        crossAxisCount: 3,
      ),
      itemCount: stockOrderData.data!.length,
      itemBuilder: (BuildContext ctx, index) {
        return Padding(
          padding: EdgeInsets.all(15),
          child: Card(
            color: Color(0xfff7f9ea),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Padding(
              padding: const EdgeInsets.all(10),
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
                              Image.asset("assets/images/Group308.png",
                                  height: 40),
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
                                    stockOrderData.data!
                                        .elementAt(index)
                                        .farm!
                                        .first
                                        .farm!
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Image.asset("assets/images/Group309.png",
                                  height: 40),
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
                                    stockOrderData.data!
                                        .elementAt(index)
                                        .block!
                                        .first
                                        .block!
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Image.asset("assets/images/Group310.png",
                                  height: 40),
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
                                    stockOrderData.data!
                                        .elementAt(index)
                                        .field!
                                        .first
                                        .field!
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
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
                              Image.asset("assets/images/Group311.png",
                                  height: 40),
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
                                    "${stockOrderData.data!.elementAt(index).user!.first.firstName!.toString()} ${stockOrderData.data!.elementAt(index).user!.first.lastName!.toString()}",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Image.asset("assets/images/Group312.png",
                                  height: 40),
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
                                    stockOrderData.data!
                                        .elementAt(index)
                                        .crop!
                                        .first
                                        .crop!
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Image.asset("assets/images/Group313.png",
                                  height: 40),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Stage",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Stage 1",
                                    // cropPlan
                                    //     .elementAt(index)
                                    //     .stageId
                                    //     .toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
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
        );
      });
}
