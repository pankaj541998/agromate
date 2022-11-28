import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:get/get.dart';
import 'package:async/async.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../database_api/methods/block_api_methods.dart';
import '../../database_api/methods/farm_api_methods.dart';
import '../../database_api/methods/field_api_methods.dart';
import '../../database_api/methods/users_api_methods.dart';
import '../../database_api/models/block.dart';
import '../../database_api/models/farm.dart';
import '../../database_api/models/field.dart';
import '../../database_api/models/user.dart';
import '../../providers/map_filter_provider.dart';

class ViewFarm extends StatefulWidget {
  const ViewFarm({Key? key}) : super(key: key);

  @override
  State<ViewFarm> createState() => _ViewFarmState();
}

class _ViewFarmState extends State<ViewFarm> {
  late String _selectedValue;
  late String _selectedValue1;
  late String _selectedValue2;
  late String _selectedValue3;
  List<String> listOfValue = [
    'Kishan 1',
    'Kishan 2',
    'Kishan 3',
    'Kishan 4',
  ];
  List<String> listOfValue1 = [
    'VARKPLAAS 1',
    'VARKPLAAS 2',
    'VARKPLAAS 3',
    'VARKPLAAS 4',
  ];
  List<String> listOfValue2 = [
    'A',
    'B',
    'C',
    'D',
  ];
  List<String> listOfValue3 = [
    'A1A',
    'B2B',
    'C3C',
    'D4D',
  ];

  //start
  String name = 'User Name';
  String role = 'Role';
  late MapboxMapController mapController;
  double targetLat = -19.423650;
  double targetLng = 29.602095;
  double zoom = 6;

  final FutureGroup futureGroup = FutureGroup();

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
    return FutureBuilder<List>(
        future: futureGroup.future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            var data = snapshot.data!;
            var users = data.elementAt(0) as List<UserModel>;
            var farms = data.elementAt(1) as List<FarmModel>;
            var block = data.elementAt(2) as List<BlockModel>;
            var field = data.elementAt(3) as List<FieldModel>;
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    TopBar(), //menu
                    const SizedBox(height: 45),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.05),
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Farm",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                  width: 144,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Get.toNamed('/select_plot');
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color(0xFF327C04))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 19,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Plot Farm',
                                            style: TextStyle(fontSize: 16),
                                          )
                                        ],
                                      )),
                                )
                              ]),
                          const Divider(
                            thickness: 1,
                            color: Color(0xFFD6D6D6),
                          ),
                          const SizedBox(
                            height: 23,
                          ),
                          //dropdown button
                          Builder(builder: (context) {
                            var readProvider =
                                context.read<MapFilterProvider>();
                            var watchProvider =
                                context.watch<MapFilterProvider>();
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Select Landholder",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                      height: 40,
                                      width: 260,
                                      child: DropdownButtonFormField(
                                        focusColor: Colors.white,
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.only(
                                            left: 10,
                                            top: 10,
                                            right: 10,
                                          ),
                                          fillColor: Colors.white,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Color(0xFFA1B809)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Color(0xFFA1B809)),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF327C04),
                                              width: 5.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        items: users
                                            .where((element) =>
                                                element.roleIndex ==
                                                Roles.Landholder.index)
                                            .map((e) {
                                          return DropdownMenuItem(
                                            child: Text(
                                                "${e.firstName} ${e.lastName}"),
                                            enabled: true,
                                            value:
                                                "${e.firstName} ${e.lastName}",
                                          );
                                        }).toList(),
                                        hint: Text(
                                          watchProvider.currentLandholder ??
                                              'Landholder',
                                        ),

                                        // listOfValue.map((String val) {
                                        //   return DropdownMenuItem(
                                        //     enabled: true,
                                        //     value: val,
                                        //     child: Text(
                                        //       val,
                                        //     ),
                                        //   );
                                        // }).toList(),
                                        onChanged: (value) {
                                          // setState(() {
                                          //   _selectedValue;
                                          // });
                                          // debugPrint(value);
                                          readProvider.onLandholderSelected();
                                          mapController.clearLines();
                                          mapController.clearFills();
                                          readProvider.currentLandholder =
                                              value.toString();
                                          readProvider.currentLandholderId = users
                                              .singleWhere((element) =>
                                                  "${element.firstName} ${element.lastName}" ==
                                                  watchProvider
                                                      .currentLandholder)
                                              .id;

                                          var landholderFarms = farms
                                              .where((farmModel) =>
                                                  farmModel.landholderId ==
                                                  watchProvider
                                                      .currentLandholderId)
                                              .toList();
                                          for (FarmModel farmModel
                                              in landholderFarms) {
                                            var latLngs = jsonDecode(
                                                farmModel.farmLatLngs!) as List;
                                            String outlineColor = "#D5D8DC";
                                            var linesGeo = latLngs;
                                            linesGeo.add(latLngs.first);
                                            mapController.addLines(linesGeo
                                                .map((latLng) => LineOptions(
                                                    geometry: linesGeo
                                                        .map((e) => LatLng(
                                                            e.first, e.last))
                                                        .toList(),
                                                    lineColor: outlineColor))
                                                .toList());

                                            mapController.addFill(
                                              FillOptions(
                                                geometry: [
                                                  latLngs.map((e) {
                                                    return LatLng(
                                                        e.first, e.last);
                                                  }).toList()
                                                ],
                                                fillColor: "#566573",
                                                fillOutlineColor: outlineColor,
                                                fillOpacity: 0.6,
                                              ),
                                            );
                                          }
                                          var cam = jsonDecode(landholderFarms
                                              .first.farmLatLngs!) as List;

                                          mapController.animateCamera(
                                              CameraUpdate.newLatLngZoom(
                                                  LatLng(cam.first.first,
                                                      cam.first.last),
                                                  12));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Select Farm",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                      height: 40,
                                      width: 260,
                                      child: DropdownButtonFormField(
                                        focusColor: Colors.white,
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              left: 10, top: 10, right: 10),
                                          fillColor: Colors.white,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Color(0xFFA1B809)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Color(0xFFA1B809)),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF327C04),
                                              width: 5.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        items: farms
                                            .where((element) =>
                                                element.landholderId ==
                                                watchProvider
                                                    .currentLandholderId)
                                            .map((e) {
                                          return DropdownMenuItem(
                                              enabled: true,
                                              value: e.farmName.toString(),
                                              child: Text(
                                                e.farmName.toString(),
                                              ));
                                        }).toList(),
                                        hint: Text(watchProvider.currentFarm ??
                                            "Farm"),
                                        // listOfValue1.map((String val) {
                                        //   return DropdownMenuItem(
                                        //     enabled: true,
                                        //     value: val,
                                        //     child: Text(
                                        //       val,
                                        //     ),
                                        //   );
                                        // }).toList(),
                                        onChanged: (value) async {
                                          // setState(() {
                                          //   _selectedValue1;
                                          // });
                                          readProvider.enableBlockDropdown();
                                          if (watchProvider.highlightFill !=
                                                  null &&
                                              watchProvider.highlightLines !=
                                                  null) {
                                            mapController.removeLines(
                                                readProvider.highlightLines!);
                                            mapController.removeFill(
                                                readProvider.highlightFill!);
                                          }
                                          readProvider.currentFarm =
                                              value.toString();
                                          var farmModel = farms.singleWhere(
                                              (element) =>
                                                  element.landholderId ==
                                                      watchProvider
                                                          .currentLandholderId &&
                                                  element.farmName ==
                                                      watchProvider
                                                          .currentFarm);
                                          readProvider.currentFarmId =
                                              farmModel.id;
                                          var latLngs =
                                              jsonDecode(farmModel.farmLatLngs!)
                                                  as List;
                                          double avgLat = 0;
                                          double avgLng = 0;
                                          for (List latLng in latLngs) {
                                            avgLat += latLng.first;
                                            avgLng += latLng.last;
                                          }
                                          avgLat /= latLngs.length;
                                          avgLng /= latLngs.length;
                                          mapController.animateCamera(
                                              CameraUpdate.newLatLngZoom(
                                                  LatLng(avgLat, avgLng), 13));
                                          //highlight farm
                                          String outlineColor = "#F9E79F";
                                          var linesGeo = latLngs;
                                          linesGeo.add(latLngs.first);

                                          var highlightLines = await mapController
                                              .addLines(linesGeo
                                                  .map((latLng) => LineOptions(
                                                      geometry: linesGeo
                                                          .map((e) => LatLng(
                                                              e.first, e.last))
                                                          .toList(),
                                                      lineColor: outlineColor))
                                                  .toList());
                                          readProvider.highlightLines =
                                              highlightLines;

                                          var fill = await mapController
                                              .addFill(FillOptions(
                                            geometry: [
                                              latLngs.map((e) {
                                                return LatLng(e.first, e.last);
                                              }).toList()
                                            ],
                                            fillColor: outlineColor,
                                            fillOutlineColor: outlineColor,
                                            fillOpacity: 0.3,
                                          ));
                                          readProvider.highlightFill = fill;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Select Block",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                      height: 40,
                                      width: 260,
                                      child: DropdownButtonFormField(
                                        focusColor: Colors.white,
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              left: 10, top: 10, right: 10),
                                          fillColor: Colors.white,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Color(0xFFA1B809)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Color(0xFFA1B809)),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF327C04),
                                              width: 5.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        items: block
                                            .where((element) =>
                                                element.landholderId ==
                                                    watchProvider
                                                        .currentLandholderId &&
                                                element.farmId ==
                                                    watchProvider.currentFarmId)
                                            .map((e) {
                                          return DropdownMenuItem(
                                              enabled: true,
                                              value: e.blockName.toString(),
                                              child:
                                                  Text(e.blockName.toString()));
                                        }).toList(),
                                        // listOfValue2.map((String val) {
                                        //   return DropdownMenuItem(
                                        //     enabled: true,
                                        //     value: val,
                                        //     child: Text(
                                        //       val,
                                        //     ),
                                        //   );
                                        // }).toList(),
                                        hint: const Text('Block'),
                                        onChanged: (value) async {
                                          readProvider.enableFieldDropdown();
                                          if (watchProvider
                                                      .highlightFillBlock !=
                                                  null &&
                                              watchProvider
                                                      .highlightLinesBlock !=
                                                  null) {
                                            mapController.removeLines(
                                                readProvider
                                                    .highlightLinesBlock!);
                                            mapController.removeFill(
                                                readProvider
                                                    .highlightFillBlock!);
                                          }
                                          readProvider.currentBlock =
                                              value.toString();
                                          var blockModel = block.singleWhere(
                                              (element) =>
                                                  element.blockName ==
                                                      watchProvider
                                                          .currentBlock &&
                                                  element.farmId ==
                                                      watchProvider
                                                          .currentFarmId &&
                                                  element.landholderId ==
                                                      watchProvider
                                                          .currentLandholderId);
                                          readProvider.currentBlockId =
                                              blockModel.id;

                                          var latLngs = jsonDecode(
                                              blockModel.blockLatLngs!) as List;
                                          double avgLat = 0;
                                          double avgLng = 0;
                                          for (List latLng in latLngs) {
                                            avgLat += latLng.first;
                                            avgLng += latLng.last;
                                          }
                                          avgLat /= latLngs.length;
                                          avgLng /= latLngs.length;
                                          mapController.animateCamera(
                                              CameraUpdate.newLatLngZoom(
                                                  LatLng(avgLat, avgLng), 13));
                                          //highlight farm
                                          String outlineColor = "#ff4000";
                                          var linesGeo = latLngs;
                                          linesGeo.add(latLngs.first);

                                          var highlightLines = await mapController
                                              .addLines(linesGeo
                                                  .map((latLng) => LineOptions(
                                                      geometry: linesGeo
                                                          .map((e) => LatLng(
                                                              e.first, e.last))
                                                          .toList(),
                                                      lineColor: outlineColor))
                                                  .toList());
                                          readProvider.highlightLinesBlock =
                                              highlightLines;

                                          var fill = await mapController
                                              .addFill(FillOptions(
                                            geometry: [
                                              latLngs.map((e) {
                                                return LatLng(e.first, e.last);
                                              }).toList()
                                            ],
                                            fillColor: outlineColor,
                                            fillOutlineColor: outlineColor,
                                            fillOpacity: 0.4,
                                          ));
                                          readProvider.highlightFillBlock =
                                              fill;
                                          // setState(() {
                                          //   _selectedValue2;
                                          // });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Select Field",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                      height: 40,
                                      width: 260,
                                      child: DropdownButtonFormField(
                                        focusColor: Colors.white,
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              left: 10, top: 10, right: 10),
                                          fillColor: Colors.white,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Color(0xFFA1B809)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Color(0xFFA1B809)),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF327C04),
                                              width: 5.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        items: field
                                            .where((element) =>
                                                element.landholderId ==
                                                    watchProvider
                                                        .currentLandholderId &&
                                                element.farmId ==
                                                    watchProvider
                                                        .currentFarmId &&
                                                element.blockId ==
                                                    watchProvider
                                                        .currentBlockId)
                                            .map((e) {
                                          return DropdownMenuItem(
                                            child: Text(e.fieldName.toString()),
                                            value: e.fieldName.toString(),
                                            enabled: true,
                                          );
                                        }).toList(),
                                        hint: Text(watchProvider.currentField ??
                                            'Field'),

                                        // listOfValue3.map((String val) {
                                        //   return DropdownMenuItem(
                                        //     enabled: true,
                                        //     value: val,
                                        //     child: Text(
                                        //       val,
                                        //     ),
                                        //   );
                                        // }).toList(),
                                        onChanged: (value) async {
                                          readProvider.enableCropDropdown();
                                          if (watchProvider
                                                      .highlightFillField !=
                                                  null &&
                                              watchProvider
                                                      .highlightLinesField !=
                                                  null) {
                                            mapController.removeLines(
                                                readProvider
                                                    .highlightLinesField!);
                                            mapController.removeFill(
                                                readProvider
                                                    .highlightFillField!);
                                          }
                                          readProvider.currentField =
                                              value.toString();
                                          //==
                                          var fieldModel = field.singleWhere(
                                              (element) =>
                                                  element.fieldName ==
                                                      watchProvider
                                                          .currentField &&
                                                  element.farmId ==
                                                      watchProvider
                                                          .currentFarmId &&
                                                  element.landholderId ==
                                                      watchProvider
                                                          .currentLandholderId &&
                                                  element.blockId ==
                                                      watchProvider
                                                          .currentBlockId);
                                          readProvider.currentFieldId =
                                              fieldModel.id;

                                          var latLngs = jsonDecode(
                                              fieldModel.fieldLatLngs!) as List;
                                          double avgLat = 0;
                                          double avgLng = 0;
                                          for (List latLng in latLngs) {
                                            avgLat += latLng.first;
                                            avgLng += latLng.last;
                                          }
                                          avgLat /= latLngs.length;
                                          avgLng /= latLngs.length;
                                          mapController.animateCamera(
                                              CameraUpdate.newLatLngZoom(
                                                  LatLng(avgLat, avgLng), 13));
                                          //highlight farm
                                          String outlineColor = "#ffffff";
                                          var linesGeo = latLngs;
                                          linesGeo.add(latLngs.first);

                                          var highlightLines = await mapController
                                              .addLines(linesGeo
                                                  .map((latLng) => LineOptions(
                                                      geometry: linesGeo
                                                          .map((e) => LatLng(
                                                              e.first, e.last))
                                                          .toList(),
                                                      lineColor: outlineColor))
                                                  .toList());
                                          readProvider.highlightLinesField =
                                              highlightLines;

                                          var fill = await mapController
                                              .addFill(FillOptions(
                                            geometry: [
                                              latLngs.map((e) {
                                                return LatLng(e.first, e.last);
                                              }).toList()
                                            ],
                                            fillColor: outlineColor,
                                            fillOutlineColor: outlineColor,
                                            fillOpacity: 0.3,
                                          ));
                                          readProvider.highlightFillField =
                                              fill;
                                          // setState(() {
                                          //   _selectedValue3;
                                          // });
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            );
                          }),

                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            height: 480,
                            child: MapboxMap(
                              compassEnabled: false,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                  targetLat,
                                  targetLng,
                                ),
                                zoom: zoom,
                              ),
                              accessToken:
                                  "pk.eyJ1IjoiYXRpc2gtYWdyb21hdGUiLCJhIjoiY2w5NWE1M20zMXRkcjNucW03M2ZjYXY2NyJ9.PXTKE0nl-2xg-pOhCikRIw",
                              styleString: MapboxStyles.SATELLITE_STREETS,
                              onMapCreated: (controller) {
                                mapController = controller;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Landholder :",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "kishan",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Crop Name :",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "potato",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 100,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Farmers : Kishan, Raj",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      // Text(
                                      //   "Kishan, Raj",
                                      //   style: TextStyle(
                                      //     fontSize: 18,
                                      //   ),
                                      // )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Growth Stage :",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Vegatation",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 100,
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Landholder :",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "kishan",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Yield :",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "2000",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 38,
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
                Expanded(
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
