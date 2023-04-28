import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:get/get.dart';
import 'package:async/async.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../component/dropdown_btn.dart';
import '../../../component/services/agro_api_methods.dart';
import '../../../constants.dart';
import '../../../database_api/methods/block_api_methods.dart';
import '../../../database_api/methods/farm_api_methods.dart';
import '../../../database_api/methods/field_api_methods.dart';
import '../../../database_api/methods/users_api_methods.dart';
import '../../../models/block.dart';
import '../../../models/farm.dart';
import '../../../models/field.dart';
import '../../../models/user1.dart';
import '../../../providers/map_box_provider.dart';
import '../../../providers/map_filter_provider.dart';

class PlotFarm extends StatefulWidget {
  const PlotFarm({Key? key}) : super(key: key);

  @override
  State<PlotFarm> createState() => _PlotFarmState();
}

class _PlotFarmState extends State<PlotFarm> {
  late MapboxMapController mapController;
  List<LatLng> latLngs = [];
  List<Line> lines = [];
  List<Circle> circles = [];
  final _formKey = GlobalKey<FormState>();
  String farmName = '';

  Future<bool> postFarm(String name, String coordinates) async {
    http.Response resopnse = await http.post(
      Uri.parse('https://agromate.website/laravel/api/farm'),
      body: {"farm": name, "farm_latlong": coordinates},
    );
    if (resopnse.statusCode == 200) {
      return true;
    }
    return false;
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

  var bodyText1Style = const TextStyle(
    color: Colors.black,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w300,
    fontSize: 13,
  );

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    var watchProvider = context.watch<MapFilterProvider>();
    var textTheme = Theme.of(context).textTheme;
    final landholderId = context.read<MapFilterProvider>().currentLandholderId;

    return Scaffold(
        body: Form(
      key: _formKey,
      child: Column(
        children: [
          TopBar(),
          const SizedBox(height: 30),
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
              child: Column(
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
                      Text('Start Plotting Your Farm',
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
                          Text('Name of the farm', style: headline3TextStyle),
                          const SizedBox(height: 2),
                          SizedBox(
                            width: 260,
                            child: TextFormField(
                              onChanged: (value) => farmName = value,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter farm name';
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
                                hintText: 'Enter Farm Name',
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
                      myLocationEnabled: true,
                      myLocationRenderMode: MyLocationRenderMode.GPS,
                      myLocationTrackingMode:
                          MyLocationTrackingMode.TrackingGPS,
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(
                          -19.178570,
                          29.863667,
                        ),
                        zoom: 6,
                      ),
                      accessToken:
                          "pk.eyJ1IjoiYXRpc2gtYWdyb21hdGUiLCJhIjoiY2w5NWE1M20zMXRkcjNucW03M2ZjYXY2NyJ9.PXTKE0nl-2xg-pOhCikRIw",
                      styleString: MapboxStyles.SATELLITE_STREETS,
                      onMapCreated: (controller) {
                        mapController = controller;
                      },
                      onMapClick: (point, coordinates) async {
                        context.read<MapBoxProvider>().enableUndoBtn();
                        context.read<MapBoxProvider>().enableClearPlotBtn();
                        if (lines.isNotEmpty) {
                          mapController.removeLine(lines.last);
                        }
                        LatLng latLan =
                            LatLng(coordinates.latitude, coordinates.longitude);
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
                        mapController.addLines(
                          latLngs
                              .map((latLng) => LineOptions(
                                  geometry: latLngs, lineColor: '#F7DC6F'))
                              .toList(),
                        );
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
                                  mapController.removeLine(lines.removeLast());
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
                                  latLngs.clear();
                                  lines.clear();
                                  circles.clear();
                                  mapController.clearCircles();
                                  mapController.clearLines();
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
                                        ScaffoldMessenger.of(context)
                                            .clearSnackBars();
                                        if (_formKey.currentState!.validate()) {
                                          setBtnState(() {
                                            showSubmitBtn = false;
                                            showSubmitBtnLoader = true;
                                          });
                                          List<List<double>> farmPlotsDB =
                                              circles
                                                  .map((circle) => [
                                                        circle.options.geometry!
                                                            .latitude,
                                                        circle.options.geometry!
                                                            .longitude
                                                      ])
                                                  .toList();
                                          debugPrint('Validated');
                                          debugPrint(farmName);
                                          debugPrint(
                                              "farmPlotsDB $farmPlotsDB");
                                          FarmApiMethods.postFarm(
                                                  landholderId:
                                                      landholderId ?? 0,
                                                  farmName: farmName,
                                                  farmLatLngs:
                                                      farmPlotsDB.toString())
                                              .then(
                                            (posted) {
                                              if (posted) {
                                                var agroLatLngs = farmPlotsDB;
                                                agroLatLngs
                                                    .add(farmPlotsDB.first);
                                                AgroApiMethods.postPolygon(
                                                        name: farmName,
                                                        coordinates:
                                                            agroLatLngs)
                                                    .then((sent) {
                                                  if (sent) {
                                                    FarmApiMethods.fetchFarms()
                                                        .then((value) {
                                                      context
                                                              .read<
                                                                  MapFilterProvider>()
                                                              .currentFarmId =
                                                          value.last.id;
                                                      // context
                                                      //     .read<HomeProvider>()
                                                      //     .changeActiveElement(
                                                      //         HomePageElements
                                                      //             .plotBlock);
                                                      Get.toNamed(
                                                          '/plot_block');
                                                      setBtnState(() {
                                                        showSubmitBtn = true;
                                                        showSubmitBtnLoader =
                                                            false;
                                                      });
                                                    });
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        duration: Duration(
                                                            seconds: 6),
                                                        content: Text(
                                                            'Unable to store farm data, please change farm size or decrease coordinates'),
                                                      ),
                                                    );
                                                    setBtnState(() {
                                                      showSubmitBtn = true;
                                                      showSubmitBtnLoader =
                                                          false;
                                                    });
                                                  }
                                                });
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    duration:
                                                        Duration(seconds: 6),
                                                    content: Text(
                                                        'Unable to store farm data, please try again later'),
                                                  ),
                                                );
                                                setBtnState(() {
                                                  showSubmitBtn = true;
                                                  showSubmitBtnLoader = false;
                                                });
                                              }
                                            },
                                          );
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
              ),
            ),
          ),
          const SizedBox(height: 6),
        ],
      ),
    ));
  }
}
