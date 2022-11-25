// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:get/get.dart';

class ViewDetails extends StatefulWidget {
  const ViewDetails({Key? key}) : super(key: key);

  @override
  State<ViewDetails> createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  TextEditingController controller = TextEditingController();
  bool sort = true;
  List<Data>? filterData;

  onsortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        filterData!.sort((a, b) => a.name!.compareTo(b.name!));
      } else {
        filterData!.sort((a, b) => b.name!.compareTo(a.name!));
      }
    }
  }

  @override
  void initState() {
    filterData = myData;
    super.initState();
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
                  children: [
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          InkWell(
                            hoverColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Color(0xff327C04),
                            ),
                          ),
                          // const SizedBox(width: 10),
                          const Text(
                            'Potato Crop Program',
                            style: TextStyle(
                                fontSize: 20,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: SizedBox(
                              width: 250,
                              child: CupertinoSearchTextField(
                                onChanged: (value) {
                                  setState(() {
                                    myData = filterData!
                                        .where(
                                          (element) => element.name!
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
                                placeholder: 'Search Celeb....',
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
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Divider(
                  height: 5,
                  color: Colors.grey,
                  thickness: 1,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
                  child: Column(children: [
                    Row(
                      children: [
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              text: 'Farmer :',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' VARKPLAAS',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              text: 'Farm :',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' VARKPLAAS',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              text: 'Crop Reference :',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' VARKPLAAS',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              text: 'Crop :',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' VARKPLAAS',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              text: 'Active week :',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' 7/30/2021',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              text: 'Hectares :',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' 3',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    datatable(),
                  ]),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  datatable() {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height * 0.6,
      child: SingleChildScrollView(
        child: Container(
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
                  rowsPerPage: 8,
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
                              "Inventory Type",
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
                              "Stock Code",
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
                              "Inventory Class",
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
                              "Description",
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
                              "Unit",
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
                              "Stock Level",
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
                              "Required",
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
                              "Pre PI",
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
                              "PI",
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
                              "W1",
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
                              "W2",
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
                              "W3",
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
                              "W4",
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
                              "W5",
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
        ),
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
      return recentFileDataRow(myData![index]);
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

DataRow recentFileDataRow(var data) {
  return DataRow(
    cells: [
      DataCell(
          Align(alignment: Alignment.center, child: Text(data.name ?? "Name"))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.stockCode.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.inventory.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.desc.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.unit.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.stockL.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.required.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.prepi.toString()))),
      DataCell(
          Align(alignment: Alignment.center, child: Text(data.pi.toString()))),
      DataCell(
          Align(alignment: Alignment.center, child: Text(data.w1.toString()))),
      DataCell(
          Align(alignment: Alignment.center, child: Text(data.w2.toString()))),
      DataCell(
          Align(alignment: Alignment.center, child: Text(data.w3.toString()))),
      DataCell(
          Align(alignment: Alignment.center, child: Text(data.w4.toString()))),
      DataCell(
          Align(alignment: Alignment.center, child: Text(data.w5.toString()))),
    ],
  );
}

class Data {
  String? name;
  String? stockCode;
  String? inventory;
  String? desc;
  String? unit;
  String? stockL;
  String? required;
  String? prepi;
  String? pi;
  String? w1;
  String? w2;
  String? w3;
  String? w4;
  String? w5;

  Data({
    required this.name,
    required this.stockCode,
    required this.inventory,
    required this.desc,
    required this.unit,
    required this.stockL,
    required this.required,
    required this.prepi,
    required this.pi,
    required this.w1,
    required this.w2,
    required this.w3,
    required this.w4,
    required this.w5,
  });
}

List<Data> myData = [
  Data(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  Data(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  Data(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  Data(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  Data(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  Data(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  Data(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  Data(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  Data(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  Data(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  Data(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  Data(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
];
