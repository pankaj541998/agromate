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

class PlotField extends StatefulWidget {
  const PlotField({Key? key}) : super(key: key);

  @override
  State<PlotField> createState() => _PlotFieldState();
}

class _PlotFieldState extends State<PlotField> {
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
  String fieldName = '';
  List<LatLng> latLngs = [];
  List<Line> lines = [];
  List<Circle> circles = [];

  final FutureGroup futureGroup = FutureGroup();

  @override
  void initState() {
    super.initState();
    futureGroup.add(FarmApiMethods.fetchFarms());
    futureGroup.add(BlockApiMethods.fetchBlocks());
    futureGroup.add(FieldApiMethods.fetchFields());
    futureGroup.close();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    var watchProvider = context.watch<MapFilterProvider>();

    int landholderId = context.read<MapFilterProvider>().currentLandholderId!;
    int farmId = context.read<MapFilterProvider>().currentFarmId!;
    int blockId = context.read<MapFilterProvider>().currentBlockId!;

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
                  var data = snapshot.data as List;
                  var farms = data.elementAt(0) as List<FarmModel>;
                  var blocks = data.elementAt(1) as List<BlockModel>;
                  var fields = data.elementAt(2) as List<FieldModel>;

                  var myFields = fields
                      .where((fieldModel) =>
                          (fieldModel.landholderId == landholderId &&
                              fieldModel.farmId == farmId &&
                              fieldModel.blockId == blockId))
                      .toList();

                  debugPrint("myFields $myFields");

                  var currentFarmModel =
                      farms.singleWhere((element) => element.id == farmId);
                  var currentBlockModel =
                      blocks.singleWhere((element) => element.id == blockId);

                  var currentFarmLatLngs =
                      jsonDecode(currentFarmModel.farmLatLngs!) as List;
                  var currentBlockLatLngs =
                      jsonDecode(currentBlockModel.blockLatLngs!) as List;

                  debugPrint("currentFarmLatLngs $currentFarmLatLngs");
                  debugPrint("currentBlockLatLngs $currentBlockLatLngs");

                  double avgLat = 0;
                  double avgLng = 0;
                  for (var e in currentBlockLatLngs) {
                    avgLat += e.first;
                    avgLng += e.last;
                  }
                  avgLat /= currentBlockLatLngs.length;
                  avgLng /= currentBlockLatLngs.length;
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
                          Text('Start Plotting Your Field',
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
                              Text('Name of the field',
                                  style: headline3TextStyle),
                              const SizedBox(height: 2),
                              SizedBox(
                                width: 260,
                                child: TextFormField(
                                  onChanged: (value) => fieldName = value,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter field name';
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
                          onStyleLoadedCallback: () {
                            String outlineColor = "#D5D8DC";
                            //farm outline
                            List<LatLng> farmOutlinePoints = currentFarmLatLngs
                                .map((e) => LatLng(e.first, e.last))
                                .toList();
                            farmOutlinePoints.add(farmOutlinePoints.first);
                            mapController.addLines(farmOutlinePoints
                                .map((e) => LineOptions(
                                    lineColor: outlineColor,
                                    geometry: farmOutlinePoints))
                                .toList());

                            //block outline
                            List<LatLng> blockOutlinePoints =
                                currentBlockLatLngs
                                    .map((e) => LatLng(e.first, e.last))
                                    .toList();
                            blockOutlinePoints.add(blockOutlinePoints.first);
                            mapController.addLines(blockOutlinePoints
                                .map((e) => LineOptions(
                                    lineColor: outlineColor,
                                    geometry: blockOutlinePoints))
                                .toList());

                            //fields outline
                            for (FieldModel field in myFields) {
                              List latLngs =
                                  jsonDecode(field.fieldLatLngs!) as List;

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
                                          style: OutlinedButton.styleFrom(
                                            foregroundColor: Colors.black,
                                          ),
                                          onPressed: () {
                                            bool isValid = _formKey
                                                .currentState!
                                                .validate();
                                            if (isValid) {
                                              setBtnState(() {
                                                showSubmitBtn = false;
                                                showSubmitBtnLoader = true;
                                              });
                                              List<List<double>> fieldPlotsDB =
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
                                              FieldApiMethods.postField(
                                                      landholderId:
                                                          landholderId,
                                                      farmId: farmId,
                                                      blockId: blockId,
                                                      fieldName: fieldName,
                                                      fieldLatLngs: fieldPlotsDB
                                                          .toString())
                                                  .then((posted) {
                                                if (posted) {
                                                  var agroLatLngs =
                                                      fieldPlotsDB;
                                                  agroLatLngs
                                                      .add(fieldPlotsDB.first);
                                                  AgroApiMethods.postPolygon(
                                                          name: fieldName,
                                                          coordinates:
                                                              agroLatLngs)
                                                      .then((sent) {
                                                    if (sent) {
                                                      // context
                                                      //     .read<HomeProvider>()
                                                      //     .changeActiveElement(
                                                      //         HomePageElements.farms);
                                                      Get.toNamed('plot_farm');
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
                                                                  'Unable to store farm data, please change farm size or decrease coordinates')));
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
                                                              'Field not added, please try again after some time')));
                                                  setBtnState(() {
                                                    showSubmitBtn = true;
                                                    showSubmitBtnLoader = false;
                                                  });
                                                }
                                              });
                                            }
                                          },
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
