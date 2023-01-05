// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';
import 'package:flutter_agro_new/main.dart';
import 'package:flutter_agro_new/models/crop_schedule_Model.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../component/top_bar.dart';

late CropScheduleModel cropschedule;
final StreamController<requestResponseState> _schedulerefresh =
    StreamController.broadcast();

class CropPlan extends StatefulWidget {
  const CropPlan({Key? key}) : super(key: key);

  @override
  State<CropPlan> createState() => _CropPlanState();
}

class _CropPlanState extends State<CropPlan> {
  bool sort = true;
  List<CropScheduleData>? filterData;

  // onsortColum(int columnIndex, bool ascending) {
  //   if (columnIndex == 0) {
  //     if (ascending) {
  //       filterData!.sort((a, b) => a.name!.compareTo(b.name!));
  //     } else {
  //       filterData!.sort((a, b) => b.name!.compareTo(a.name!));
  //     }
  //   }
  // }

  @override
  void initState() {
    super.initState();
    fetchCropSchedule();
  }

// List<CropScheduleData> myDataRequest = cropschedule;

  Future<CropScheduleModel> fetchCropSchedule() async {
    var client = http.Client();
    final response = await client
        .get(Uri.parse('https://agromate.website/laravel/api/get/plan'));
    final parsed = jsonDecode(response.body);
    print("api call data ${response.body}");
    cropschedule = CropScheduleModel.fromJson(parsed);
    myData = cropschedule.data!;
    _schedulerefresh.add(requestResponseState.DataReceived);
    return cropschedule;
  }

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(height: 30),
          TopBar(),
          const SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: const Text(
                        'Crop Schedule',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () => Get.toNamed('/add_crop_plan'),
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
                                    myData = cropschedule.data!
                                        .where(
                                          (element) => element
                                              .cropProgram!.first.crop!
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
                                  color:
                                      const Color(0xff327C04).withOpacity(0.11),
                                ),
                                itemSize: 25,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff000000),
                                ),
                                prefixInsets:
                                    const EdgeInsetsDirectional.fromSTEB(
                                        10, 8, 0, 8),
                                placeholder: 'Search By Crop',
                                suffixInsets:
                                    const EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 15, 2),
                                placeholderStyle: TextStyle(
                                  fontSize: 16,
                                  color:
                                      const Color(0xff000000).withOpacity(0.38),
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
                const SizedBox(height: 30),
                // StreamBuilder<requestResponseState>(
                //     stream: _schedulerefresh.stream,
                //     builder: (context, snapshot) {
                //       if (snapshot.data == requestResponseState.DataReceived) {
                //         if (snapshot.hasData) {
                //           fetchCropSchedule();
                //           return datatable(screenSize, context);
                //         }
                //       }
                //       return const Center(child: CircularProgressIndicator());
                //     }),
                FutureBuilder(
                  future: fetchCropSchedule(),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return datatable(screenSize, context);
                      } else {
                        return Center(
                          child: Text(
                            '${snapshot.error} occured',
                            style: const TextStyle(fontSize: 18),
                          ),
                        );
                      }
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  datatable(screenSize, context) {
    fetchCropSchedule();
    return Container(
      padding: const EdgeInsets.all(0.0),
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: PaginatedDataTable(
              sortColumnIndex: 0,
              sortAscending: sort,
              source: RowSource(
                myData: myData,
                count: myData.length,
              ),
              rowsPerPage: 7,
              columnSpacing: 0,
              headingRowHeight: 50,
              horizontalMargin: 0,
              columns: [
                DataColumn(
                  label: Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xff327C04).withOpacity(0.11),
                      ),
                      child: const Center(
                        child: Text(
                          "Sr.No",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xff327C04).withOpacity(0.11),
                      ),
                      child: const Center(
                        child: Text(
                          "Farm",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xff327C04).withOpacity(0.11),
                      ),
                      child: const Center(
                        child: Text(
                          "Block",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xff327C04).withOpacity(0.11),
                      ),
                      child: const Center(
                        child: Text(
                          "Field",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xff327C04).withOpacity(0.11),
                      ),
                      child: const Center(
                        child: Text(
                          "Crop",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xff327C04).withOpacity(0.11),
                      ),
                      child: const Center(
                        child: Text(
                          "Crop Reference",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xff327C04).withOpacity(0.11),
                      ),
                      child: const Center(
                        child: Text(
                          "Cultivar",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xff327C04).withOpacity(0.11),
                      ),
                      child: const Center(
                        child: Text(
                          "Start date",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xff327C04).withOpacity(0.11),
                      ),
                      child: const Center(
                        child: Text(
                          "Expected End date",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xff327C04).withOpacity(0.11),
                      ),
                      child: const Center(
                        child: Text(
                          "Area",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xff327C04).withOpacity(0.11),
                      ),
                      child: const Center(
                        child: Text(
                          "Expected Yield",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xff327C04).withOpacity(0.11),
                      ),
                      child: const Center(
                        child: Text(
                          "AC",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RowSource extends DataTableSource {
  var myData;
  final count;
  RowSource({
    required this.myData,
    required this.count,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRow(myData![index], index);
    } else {
      return null;
    }
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;
}

DataRow recentFileDataRow(CropScheduleData data, int index) {
  int no = index + 1;

  return DataRow(
    cells: [
      DataCell(Align(alignment: Alignment.center, child: Text(no.toString()))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Text(data.farm!.first.farm.toString()))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Text(data.block!.first.block.toString()))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Text(data.field?.first.field ?? ""))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Text(data.cropProgram!.first.crop.toString()))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Text(data.cropReference.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.caltivar.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.startDate.toString()))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Text(data.expectedEndDate.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.area.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.unitValue.toString()))),
      DataCell(Align(alignment: Alignment.center, child: Text(""))),
    ],
  );
}

List<CropScheduleData> myData = cropschedule.data!;
