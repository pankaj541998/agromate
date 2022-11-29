import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:get/get.dart';
import 'package:async/async.dart';
import 'package:provider/provider.dart';

import '../../component/dropdown_btn.dart';
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

  TextStyle headline4TextStyle = const TextStyle(
    color: Colors.black,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    fontSize: 20,
  );

  TextStyle headline3TextStyle = const TextStyle(
    color: Colors.black,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    var watchProvider = context.watch<MapFilterProvider>();
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
                body: Column(
              children: [
                TopBar(),
                const SizedBox(height: 30),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.05),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('Farms', style: headline4TextStyle),
                            const Spacer(),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff327C04)),
                              onPressed: watchProvider.isFarmDropdownEnabled
                                  ? () {
                                      Get.toNamed('/plot_farm');
                                      // context.read<HomeProvider>().changeActiveElement(
                                      //     HomePageElements.plotFarm);
                                    }
                                  : null,
                              icon: const Icon(Icons.add),
                              label: const Text('Plot Farm'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Builder(builder: (context) {
                          var readProvider = context.read<MapFilterProvider>();
                          return SizedBox(
                            width: double.maxFinite,
                            height: 80,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Select Landholder",
                                      style: headline3TextStyle,
                                    ),
                                    const SizedBox(height: 4),
                                    DropdownBtn(
                                      items: users
                                          .where((element) =>
                                              element.roleIndex ==
                                              Roles.Landholder.index)
                                          .map((e) {
                                        return "${e.firstName} ${e.lastName}";
                                      }).toList(),
                                      hint: watchProvider.currentLandholder ??
                                          'Landholder',
                                      onItemSelected: (value) {
                                        readProvider.onLandholderSelected();
                                        mapController.clearLines();
                                        mapController.clearFills();
                                        readProvider.currentLandholder = value;
                                        readProvider.currentLandholderId = users
                                            .singleWhere((element) =>
                                                "${element.firstName} ${element.lastName}" ==
                                                watchProvider.currentLandholder)
                                            .id;

                                        var landholderFarms = farms
                                            .where((farmModel) =>
                                                farmModel.landholderId ==
                                                watchProvider
                                                    .currentLandholderId)
                                            .toList();
                                        for (FarmModel farmModel
                                            in landholderFarms) {
                                          var latLngs =
                                              jsonDecode(farmModel.farmLatLngs!)
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
                                  ],
                                ),
                                const SizedBox(width: 18),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Select Farm",
                                      style: headline3TextStyle,
                                    ),
                                    const SizedBox(height: 4),
                                    DropdownBtn(
                                      isEnabled:
                                          watchProvider.isFarmDropdownEnabled,
                                      items: farms
                                          .where((element) =>
                                              element.landholderId ==
                                              watchProvider.currentLandholderId)
                                          .map((e) {
                                        return e.farmName.toString();
                                      }).toList(),
                                      hint: watchProvider.currentFarm ?? "Farm",
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
                                                    watchProvider.currentFarm);
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
                                  ],
                                ),
                                const SizedBox(width: 18),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Select Block",
                                      style: headline3TextStyle,
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
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
                                        Visibility(
                                          visible:
                                              watchProvider.currentFarm == null
                                                  ? false
                                                  : true,
                                          child: IconButton(
                                            onPressed: () {
                                              // context
                                              //     .read<HomeProvider>()
                                              //     .changeActiveElement(
                                              //         HomePageElements.plotBlock);
                                              Get.toNamed('/plot_block');
                                            },
                                            icon: const Icon(
                                              Icons.add_circle_outline_rounded,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(width: 18),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Select Field",
                                      style: headline3TextStyle,
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
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
                                        Visibility(
                                          visible:
                                              watchProvider.currentBlock == null
                                                  ? false
                                                  : true,
                                          child: IconButton(
                                            onPressed: () {
                                              // context
                                              //     .read<HomeProvider>()
                                              //     .changeActiveElement(
                                              //         HomePageElements.plotField);
                                              Get.toNamed('/plot_field');
                                            },
                                            icon: const Icon(Icons
                                                .add_circle_outline_rounded),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(width: 18),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Select Crop",
                                      style: headline3TextStyle,
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        DropdownBtn(
                                          isEnabled: watchProvider
                                              .isCropDropdownEnabled,
                                          items: const ['Crop 1', 'Crop 2'],
                                          hint: 'Crop',
                                        ),
                                        Visibility(
                                          visible:
                                              watchProvider.currentField == null
                                                  ? false
                                                  : true,
                                          child: IconButton(
                                            onPressed: () {
                                              Get.toNamed('/crop_plan');
                                            },
                                            icon: const Icon(Icons
                                                .add_circle_outline_rounded),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                        Expanded(
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
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 6),
              ],
            ));
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
        });
  }
}
