import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:flutter_agro_new/database_api/models/block.dart';
import 'package:flutter_agro_new/database_api/models/farm.dart';
import 'package:flutter_agro_new/database_api/models/field.dart';
import 'package:flutter_agro_new/database_api/models/user.dart';
import 'package:flutter_agro_new/providers/map_filter_provider.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../component/custom_Elevated_Button.dart';
import '../../../constants.dart';
import '../../growth_stages/dropdown_btn.dart';

class StockOrder extends StatefulWidget {
  const StockOrder({Key? key}) : super(key: key);

  @override
  State<StockOrder> createState() => _StockOrderState();
}

class _StockOrderState extends State<StockOrder> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  late MapboxMapController mapController;
  String? crop;
  String? plantPopulation;
  String? yield;
  String? weeks;
  TextEditingController controller = TextEditingController();
  final StreamController<List> stockOrder = StreamController.broadcast();

  Future<String> addStockplannerAPI() async {
    print("reached");
    final _chuckerHttpClient = await http.Client();
    final http.Response response = await http.post(
        Uri.parse("https://agromate.website/laravel/api/add_stock_planner"),
        body: {
          "farm_id": "",
          "block_id": "",
          "field_id": "",
          "crop_id": "",
          "warehouse_id": "",
          "user_id": ""
        });
    print("api resp is ${response.body}");
    if (response.statusCode == 200) {
      Flushbar(
        message: "Stock Planner Added Successfully",
        duration: Duration(seconds: 2),
      );
      return 'null';
    } else {
      return throw (Exception("Search Error"));
    }
  }

  buildPinAlertDialog(screenSize) {
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          var watchProvider = context.watch<MapFilterProvider>();
          var readProvider = context.read<MapFilterProvider>();
          return StreamBuilder<List>(
              stream: stockOrder.stream,
              builder: (context, snapshot) {
                debugPrint("my snapshot $snapshot");
                if (snapshot.connectionState == ConnectionState.active &&
                    snapshot.hasData) {
                  var data = snapshot.data!;
                  var users = data.elementAt(0) as List<UserModel>;
                  var farms = data.elementAt(1) as List<FarmModel>;
                  var block = data.elementAt(2) as List<BlockModel>;
                  var field = data.elementAt(3) as List<FieldModel>;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AlertDialog(
                        insetPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        contentPadding:
                            const EdgeInsets.fromLTRB(24, 8, 24, 24),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          items: users
                                              .where((element) =>
                                                  element.roleIndex ==
                                                  Roles.Landholder.index)
                                              .map((e) {
                                            return "${e.firstName} ${e.lastName}";
                                          }).toList(),
                                          hint:
                                              watchProvider.currentLandholder ??
                                                  'Landholder',
                                          onItemSelected: (value) {
                                            readProvider.onLandholderSelected();
                                            mapController.clearLines();
                                            mapController.clearFills();
                                            readProvider.currentLandholder =
                                                value;
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
                                                      farmModel.farmLatLngs!)
                                                  as List;
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
                                                  fillOutlineColor:
                                                      outlineColor,
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
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  SizedBox(
                                    width: screenSize.width * 0.2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          isEnabled: watchProvider
                                              .isFarmDropdownEnabled,
                                          items: farms
                                              .where((element) =>
                                                  element.landholderId ==
                                                  watchProvider
                                                      .currentLandholderId)
                                              .map((e) {
                                            return e.farmName.toString();
                                          }).toList(),
                                          hint: watchProvider.currentFarm ??
                                              "Farm",
                                          onItemSelected: (value) async {
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
                                            readProvider.currentFarm = value;
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
                                            var latLngs = jsonDecode(
                                                farmModel.farmLatLngs!) as List;
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
                                                    LatLng(avgLat, avgLng),
                                                    13));
                                            //highlight farm
                                            String outlineColor = "#F9E79F";
                                            var linesGeo = latLngs;
                                            linesGeo.add(latLngs.first);

                                            var highlightLines = await mapController
                                                .addLines(linesGeo
                                                    .map((latLng) =>
                                                        LineOptions(
                                                            geometry: linesGeo
                                                                .map((e) =>
                                                                    LatLng(
                                                                        e.first,
                                                                        e.last))
                                                                .toList(),
                                                            lineColor:
                                                                outlineColor))
                                                    .toList());
                                            readProvider.highlightLines =
                                                highlightLines;

                                            var fill = await mapController
                                                .addFill(FillOptions(
                                              geometry: [
                                                latLngs.map((e) {
                                                  return LatLng(
                                                      e.first, e.last);
                                                }).toList()
                                              ],
                                              fillColor: outlineColor,
                                              fillOutlineColor: outlineColor,
                                              fillOpacity: 0.3,
                                            ));
                                            readProvider.highlightFill = fill;
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          isEnabled: watchProvider
                                              .isBlockDropdownEnabled,
                                          items: block
                                              .where((element) =>
                                                  element.landholderId ==
                                                      watchProvider
                                                          .currentLandholderId &&
                                                  element.farmId ==
                                                      watchProvider
                                                          .currentFarmId)
                                              .map((e) {
                                            return e.blockName.toString();
                                          }).toList(),
                                          hint: 'Block',
                                          onItemSelected: (value) async {
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
                                            readProvider.currentBlock = value;
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
                                                    blockModel.blockLatLngs!)
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
                                                    LatLng(avgLat, avgLng),
                                                    13));
                                            //highlight farm
                                            String outlineColor = "#ff4000";
                                            var linesGeo = latLngs;
                                            linesGeo.add(latLngs.first);

                                            var highlightLines = await mapController
                                                .addLines(linesGeo
                                                    .map((latLng) =>
                                                        LineOptions(
                                                            geometry: linesGeo
                                                                .map((e) =>
                                                                    LatLng(
                                                                        e.first,
                                                                        e.last))
                                                                .toList(),
                                                            lineColor:
                                                                outlineColor))
                                                    .toList());
                                            readProvider.highlightLinesBlock =
                                                highlightLines;

                                            var fill = await mapController
                                                .addFill(FillOptions(
                                              geometry: [
                                                latLngs.map((e) {
                                                  return LatLng(
                                                      e.first, e.last);
                                                }).toList()
                                              ],
                                              fillColor: outlineColor,
                                              fillOutlineColor: outlineColor,
                                              fillOpacity: 0.4,
                                            ));
                                            readProvider.highlightFillBlock =
                                                fill;
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          isEnabled: watchProvider
                                              .isFieldDropdownEnabled,
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
                                            return e.fieldName.toString();
                                          }).toList(),
                                          hint: watchProvider.currentField ??
                                              'Field',
                                          onItemSelected: (value) async {
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
                                            readProvider.currentField = value;
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
                                                    fieldModel.fieldLatLngs!)
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
                                                    LatLng(avgLat, avgLng),
                                                    13));
                                            //highlight farm
                                            String outlineColor = "#ffffff";
                                            var linesGeo = latLngs;
                                            linesGeo.add(latLngs.first);

                                            var highlightLines = await mapController
                                                .addLines(linesGeo
                                                    .map((latLng) =>
                                                        LineOptions(
                                                            geometry: linesGeo
                                                                .map((e) =>
                                                                    LatLng(
                                                                        e.first,
                                                                        e.last))
                                                                .toList(),
                                                            lineColor:
                                                                outlineColor))
                                                    .toList());
                                            readProvider.highlightLinesField =
                                                highlightLines;

                                            var fill = await mapController
                                                .addFill(FillOptions(
                                              geometry: [
                                                latLngs.map((e) {
                                                  return LatLng(
                                                      e.first, e.last);
                                                }).toList()
                                              ],
                                              fillColor: outlineColor,
                                              fillOutlineColor: outlineColor,
                                              fillOpacity: 0.3,
                                            ));
                                            readProvider.highlightFillField =
                                                fill;
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          isEnabled: watchProvider
                                              .isCropDropdownEnabled,
                                          items: const ['Crop 1', 'Crop 2'],
                                          hint: 'Crop',
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        TextFormField(
                                          // initialValue: 'enter heritage',
                                          style: const TextStyle(
                                            // color: Color(0xffffffff),
                                            fontFamily: 'Helvetica',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          // readOnly: true,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          decoration: InputDecoration(
                                            fillColor: Colors.transparent,
                                            errorMaxLines: 3,
                                            hintText: "Enter Person",
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 15,
                                                    bottom: 15),
                                            hintStyle: const TextStyle(
                                              fontSize: 16,
                                              // color: const Color(0xffffffff).withOpacity(0.8),
                                              fontFamily: 'Helvetica',
                                            ),
                                            // fillColor: Colors.white,
                                            filled: true,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color(0xff327C04),
                                              ),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color(0xff327C04),
                                              ),
                                            ),
                                            errorStyle: const TextStyle(
                                              fontSize: 16.0,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color(0xff327C04),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color(0xff327C04),
                                              ),
                                            ),
                                            isDense: true,
                                          ),
                                          // controller: _email,
                                          keyboardType: TextInputType.text,
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Please enter your email Id';
                                          //   }
                                          //   return null;
                                          // },
                                          // onSaved: (name) {},
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
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              });
        },
      ),
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
                                buildPinAlertDialog(screenSize);
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
                                    // setState(() {
                                    //   myData = filterData!
                                    //       .where(
                                    //         (element) => element.name!
                                    //             .toLowerCase()
                                    //             .contains(
                                    //               value.toLowerCase(),
                                    //             ),
                                    //       )
                                    //       .toList();
                                    // }
                                    // );
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
                    child: _buildgridview(context, screenSize),
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

Widget _buildgridview(context, screenSize) {
  return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 2,
        crossAxisCount: 3,
      ),
      itemCount: 5,
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
                                children: const [
                                  Text(
                                    "Farm",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Varkaplass",
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
                                children: const [
                                  Text(
                                    "Block",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "A",
                                    // cropPlan
                                    //     .elementAt(index)
                                    //     .hectarage
                                    //     .toString(),
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
                                children: const [
                                  Text(
                                    "Field",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "A1A",
                                    // cropPlan
                                    //     .elementAt(index)
                                    //     .farmerId
                                    //     .toString(),
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
                                children: const [
                                  Text(
                                    "Person",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Raj",
                                    // cropPlan
                                    //     .elementAt(index)
                                    //     .fieldId
                                    //     .toString(),
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
                                children: const [
                                  Text(
                                    "Crop",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Potato",
                                    // cropPlan
                                    //     .elementAt(index)
                                    //     .planneddate
                                    //     .toString(),
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
                                    "Pre Planting",
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



// buildPin(context) {
//   return showDialog(
//     context: context,
//     builder: (context) => StatefulBuilder(
//       builder: (context, setState) {
//         return Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             AlertDialog(
//               content: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         "Add New Growth Stage",
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.w500),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Select Crop",
//                             style: TextStyle(
//                               fontSize: 18,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 15,
//                           ),
//                           SizedBox(
//                               height: 50,
//                               width: 300,
//                               child: TextDropdown(
//                                   items: const ['Onion', 'Potato', 'Carrot'],
//                                   controller: crop,
//                                   showDropDown: true))
//                         ],
//                       ),
//                       SizedBox(
//                         width: 35,
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Growth Name",
//                             style: TextStyle(
//                               fontSize: 18,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 15,
//                           ),
//                           SizedBox(
//                               height: 50,
//                               width: 300,
//                               child: TextInputField(
//                                   hintText: "", validatorText: ""))
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 18,
//                   ),
//                   Text(
//                     "Description",
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   SizedBox(
//                       height: 100,
//                       width: 629,
//                       child: TextFormField(
//                         maxLines: 5,
//                         cursorColor: Color(0xFF327C04),
//                         autovalidateMode: AutovalidateMode.onUserInteraction,
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: Colors.white,
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide:
//                                 const BorderSide(color: Color(0xFFA1B809)),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide:
//                                 const BorderSide(color: Color(0xFFA1B809)),
//                           ),
//                           errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: const BorderSide(color: Colors.red),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: const BorderSide(color: Colors.red),
//                           ),
//                           hintStyle: const TextStyle(
//                               color: Color(0x80000000), fontSize: 18),
//                           hintText: "",
//                         ),
//                         validator: (value) {
//                           if (value != null && value.isEmpty) {
//                             return "Password cannot be empty";
//                           }
//                           return null;
//                         },
//                       )),
//                   SizedBox(
//                     height: 14,
//                   ),
//                   Row(
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Start Week",
//                             style: TextStyle(
//                               fontSize: 18,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 15,
//                           ),
//                           SizedBox(
//                               height: 50,
//                               width: 300,
//                               child: TextDropdown(
//                                   items: const ['Onion', 'Potato', 'Carrot'],
//                                   controller: crop,
//                                   showDropDown: true))
//                         ],
//                       ),
//                       SizedBox(
//                         width: 35,
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "End Week",
//                             style: TextStyle(
//                               fontSize: 18,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 15,
//                           ),
//                           SizedBox(
//                               height: 50,
//                               width: 300,
//                               child: TextDropdown(
//                                   items: const ['Onion', 'Potato', 'Carrot'],
//                                   controller: crop,
//                                   showDropDown: true))
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 25,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         height: 40,
//                         width: 298,
//                         child: customElevatedButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           title: "Submit",
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     ),
//   );
// }
