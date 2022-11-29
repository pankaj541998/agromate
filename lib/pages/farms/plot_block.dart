import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:get/get.dart';
import 'package:async/async.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../component/dropdown_btn.dart';
import '../../component/services/agro_api_methods.dart';
import '../../constants.dart';
import '../../database_api/methods/block_api_methods.dart';
import '../../database_api/methods/farm_api_methods.dart';
import '../../database_api/methods/field_api_methods.dart';
import '../../database_api/methods/users_api_methods.dart';
import '../../database_api/models/block.dart';
import '../../database_api/models/farm.dart';
import '../../database_api/models/field.dart';
import '../../database_api/models/user.dart';
import '../../providers/map_box_provider.dart';
import '../../providers/map_filter_provider.dart';

class PlotBlock extends StatefulWidget {
  const PlotBlock({Key? key}) : super(key: key);

  @override
  State<PlotBlock> createState() => _PlotBlockState();
}

class _PlotBlockState extends State<PlotBlock> {
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

  var bodyText1Style = const TextStyle(
    color: Colors.black,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w300,
    fontSize: 13,
  );

  late MapboxMapController mapController;
  final _formKey = GlobalKey<FormState>();
  String blockName = '';
  List<LatLng> latLngs = [];
  List<Line> lines = [];
  List<Circle> circles = [];

  FutureGroup futureGroup = FutureGroup();

  @override
  void initState() {
    super.initState();
    futureGroup.add(FarmApiMethods.fetchFarms());
    futureGroup.add(BlockApiMethods.fetchBlocks());
    futureGroup.close();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    var watchProvider = context.watch<MapFilterProvider>();

    int? landholderId = context.read<MapFilterProvider>().currentLandholderId;
    int? farmId = context.read<MapFilterProvider>().currentFarmId;
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
        body: Form(
      key: _formKey,
      child: Column(
        children: [
          TopBar(),
          const SizedBox(height: 30),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
            child: FutureBuilder<List<dynamic>>(
              future: futureGroup.future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  String farmLatLngString = snapshot.data!
                      .elementAt(0)
                      .singleWhere((element) => element.id == farmId)
                      .farmLatLngs!;

                  var blocks = snapshot.data!.elementAt(1) as List;
                  var myBlocks = blocks.where((element) {
                    var blockModel = element as BlockModel;
                    return blockModel.farmId == farmId;
                  }).toList();
                  debugPrint("blocks $blocks");
                  debugPrint("myBlocks $myBlocks");
                  List<dynamic> farmLatLngs = jsonDecode(farmLatLngString);
                  double avgLat = 0;
                  double avgLng = 0;
                  for (var element in farmLatLngs) {
                    var e = element as List;
                    avgLat += e.first;
                    avgLng += e.last;
                  }
                  avgLat /= farmLatLngs.length;
                  avgLng /= farmLatLngs.length;
                  return Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(Icons.arrow_back_rounded),
                          ),
                          const SizedBox(width: 8),
                          Text('Start Plotting Your Block',
                              style: headline4TextStyle),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Instructions",
                                style: headline4TextStyle,
                              ),
                              Text(
                                "\u2022 Start by choosing a point on map",
                                style: bodyText1Style,
                              ),
                              Text(
                                "\u2022 Then plot points according to the farm size you want and complete the polygon",
                                style: bodyText1Style,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Name of the block',
                                  style: headline3TextStyle),
                              const SizedBox(height: 2),
                              SizedBox(
                                width: 260,
                                child: TextFormField(
                                  onChanged: (value) => blockName = value,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter block name';
                                    } else if (circles.length < 3) {
                                      return 'Minimum 3 plots are required on the map';
                                    }
                                    return null;
                                  },
                                  style: textTheme.bodyText1,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    hintText: 'Enter Block Name',
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 6),
                      Expanded(
                        child: MapboxMap(
                          compassEnabled: false,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(avgLat, avgLng),
                            zoom: 15,
                          ),
                          accessToken:
                              "pk.eyJ1IjoiYXRpc2gtYWdyb21hdGUiLCJhIjoiY2w5NWE1M20zMXRkcjNucW03M2ZjYXY2NyJ9.PXTKE0nl-2xg-pOhCikRIw",
                          styleString: MapboxStyles.SATELLITE_STREETS,
                          onMapCreated: (controller) {
                            mapController = controller;
                          },
                          //
                          onStyleLoadedCallback: () {
                            String outlineColor = "#D5D8DC";
                            //farm outline
                            List<LatLng> outlinePoints = farmLatLngs
                                .map((e) => LatLng(e.first, e.last))
                                .toList();
                            outlinePoints.add(outlinePoints.first);
                            mapController.addLines(outlinePoints
                                .map((e) => LineOptions(
                                    lineColor: outlineColor,
                                    geometry: outlinePoints))
                                .toList());

                            //blocks outline
                            for (BlockModel blockModel in myBlocks) {
                              List latLngs =
                                  jsonDecode(blockModel.blockLatLngs!) as List;

                              List<LatLng> outlinePoints2 = latLngs
                                  .map((e) => LatLng(e.first, e.last))
                                  .toList();
                              outlinePoints2.add(outlinePoints2.first);
                              mapController.addLines(outlinePoints2
                                  .map((e) => LineOptions(
                                      lineColor: outlineColor,
                                      geometry: outlinePoints2))
                                  .toList());
                            }
                          },
                          //
                          onMapClick: (point, coordinates) async {
                            context.read<MapBoxProvider>().enableUndoBtn();
                            context.read<MapBoxProvider>().enableClearPlotBtn();
                            if (lines.isNotEmpty) {
                              mapController.removeLine(lines.last);
                            }
                            LatLng latLan = LatLng(
                                coordinates.latitude, coordinates.longitude);
                            Circle circle = await mapController.addCircle(
                              CircleOptions(
                                geometry: latLan,
                                circleColor: '#000000',
                                circleRadius: 6,
                                circleStrokeColor: '#F7DC6F',
                                circleStrokeWidth: 2,
                              ),
                            );
                            circles.add(circle);
                            latLngs.add(latLan);
                            var createdLines = await mapController.addLines(
                              latLngs
                                  .map((latLng) => LineOptions(
                                      geometry: latLngs, lineColor: '#F7DC6F'))
                                  .toList(),
                            );
                            lines.addAll(createdLines);
                            Line line = await mapController.addLine(LineOptions(
                                lineColor: '#F7DC6F',
                                geometry: [latLngs.last, latLngs.first]));
                            lines.add(line);
                            //--
                          },
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.black,
                              ),
                              onPressed: context
                                      .watch<MapBoxProvider>()
                                      .isUndoBtnEnabled
                                  ? () async {
                                      if (circles.length == 1) {
                                        context
                                            .read<MapBoxProvider>()
                                            .diasbleUndoBtn();
                                        context
                                            .read<MapBoxProvider>()
                                            .diasbleClearPlotBtn();
                                      }
                                      latLngs.removeLast();
                                      mapController
                                          .removeCircle(circles.removeLast());
                                      mapController
                                          .removeLine(lines.removeLast());
                                      Line line = await mapController.addLine(
                                          LineOptions(
                                              lineColor: '#F7DC6F',
                                              geometry: [
                                            latLngs.last,
                                            latLngs.first
                                          ]));
                                      lines.add(line);
                                    }
                                  : null,
                              child: const Text(
                                'Undo Point',
                              )),
                          const SizedBox(width: 8),
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.black,
                              ),
                              onPressed: context
                                      .watch<MapBoxProvider>()
                                      .isClearPlotBtnEnabled
                                  ? () {
                                      context
                                          .read<MapBoxProvider>()
                                          .diasbleClearPlotBtn();
                                      context
                                          .read<MapBoxProvider>()
                                          .diasbleUndoBtn();
                                      mapController.clearCircles();
                                      mapController.removeLines(lines);
                                      latLngs.clear();
                                      lines.clear();
                                      circles.clear();
                                    }
                                  : null,
                              child: const Text('Clear Plot')),
                          const Spacer(),
                          Builder(builder: (context) {
                            bool showSubmitBtn = true;
                            bool showSubmitBtnLoader = false;
                            return StatefulBuilder(
                              builder: (context, setBtnState) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Visibility(
                                      visible: showSubmitBtn,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            setBtnState(() {
                                              showSubmitBtn = false;
                                              showSubmitBtnLoader = true;
                                            });
                                            bool isValid = _formKey
                                                .currentState!
                                                .validate();
                                            if (isValid) {
                                              List<List<double>> blockPlotsDB =
                                                  circles
                                                      .map((circle) => [
                                                            circle
                                                                .options
                                                                .geometry!
                                                                .latitude,
                                                            circle
                                                                .options
                                                                .geometry!
                                                                .longitude
                                                          ])
                                                      .toList();

                                              debugPrint(
                                                  landholderId.toString());
                                              debugPrint(farmId.toString());
                                              debugPrint(blockName);
                                              debugPrint(
                                                  blockPlotsDB.toString());

                                              BlockApiMethods.postBlock(
                                                      landholderId:
                                                          landholderId ?? 0,
                                                      farmId: farmId ?? 0,
                                                      blockName: blockName,
                                                      blockLatLngs: blockPlotsDB
                                                          .toString())
                                                  .then((posted) {
                                                if (posted) {
                                                  var agroLatLngs =
                                                      blockPlotsDB;
                                                  agroLatLngs
                                                      .add(blockPlotsDB.first);
                                                  AgroApiMethods.postPolygon(
                                                          name: blockName,
                                                          coordinates:
                                                              agroLatLngs)
                                                      .then((sent) {
                                                    if (sent) {
                                                      BlockApiMethods
                                                              .fetchBlocks()
                                                          .then((value) {
                                                        context
                                                                .read<
                                                                    MapFilterProvider>()
                                                                .currentBlockId =
                                                            value.last.id;
                                                        // context
                                                        //     .read<HomeProvider>()
                                                        //     .changeActiveElement(
                                                        //         HomePageElements
                                                        //             .plotField);
                                                        Get.toNamed(
                                                            '/plot_field');
                                                      });
                                                      setBtnState(() {
                                                        showSubmitBtn = true;
                                                        showSubmitBtnLoader =
                                                            false;
                                                      });
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(const SnackBar(
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          6),
                                                              content: Text(
                                                                  'Unable to store block data, please change block size or decrease coordinates')));
                                                      setBtnState(() {
                                                        showSubmitBtn = true;
                                                        showSubmitBtnLoader =
                                                            false;
                                                      });
                                                    }
                                                  });
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          duration: Duration(
                                                              seconds: 6),
                                                          content: Text(
                                                              'Block not added, please try again later')));
                                                  setBtnState(() {
                                                    showSubmitBtn = true;
                                                    showSubmitBtnLoader = false;
                                                  });
                                                }
                                              });
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xff327C04),
                                          ),
                                          child: const Text('Submit Plot')),
                                    ),
                                    Visibility(
                                      visible: showSubmitBtnLoader,
                                      child: const Padding(
                                        padding: EdgeInsets.only(right: 32.0),
                                        child: SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 3.2),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              },
                            );
                          })
                        ],
                      )
                    ],
                  );
                  // return FlutterLogo();
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          )),
          const SizedBox(height: 6),
        ],
      ),
    ));
  }
}
