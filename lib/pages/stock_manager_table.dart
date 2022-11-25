// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/top_bar.dart';

const List<Widget> options = <Widget>[Text('Grid'), Text('Table')];

class StockManagerTable extends StatefulWidget {
  const StockManagerTable({Key? key}) : super(key: key);

  @override
  State<StockManagerTable> createState() => _StockManagerTableState();
}

class _StockManagerTableState extends State<StockManagerTable> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  String? unitcost;
  String? plantPopulation;
  String? yield;
  String? weeks;
  TextEditingController controller = TextEditingController();

  bool sort = true;
  List<Data>? filterData;

  onsortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        filterData!.sort((a, b) => a.id!.compareTo(b.id!));
      } else {
        filterData!.sort((a, b) => b.id!.compareTo(a.id!));
      }
    }
  }

  @override
  void initState() {
    filterData = myData;
    super.initState();
  }

  final List<bool> _selectedFruits = <bool>[true, false];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopBar(),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.arrow_back_ios_rounded,
                        ),
                      ),
                      SizedBox(width: screenSize.width * 0.02),
                      const Text(
                        'Stock Manager',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff000000),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: screenSize.width * 0.02),
                      ToggleButtons(
                        onPressed: (int index) {
                          setState(() {
                            // The button that is tapped is set to true, and the others to false.
                            for (int i = 0; i < _selectedFruits.length; i++) {
                              _selectedFruits[i] = i == index;
                            }
                          });
                        },
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        selectedBorderColor: const Color(0xFF327c04),
                        selectedColor: Colors.white,
                        fillColor: const Color(0xFF327c04),
                        color: Colors.black,
                        constraints: const BoxConstraints(
                          minHeight: 30.0,
                          minWidth: 60.0,
                        ),
                        isSelected: _selectedFruits,
                        children: options,
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                // buildPinAlertDialog();
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
                                  // controller: controller,
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
                                  placeholder: 'Search Celeb....',
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
                  datatable(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

datatable() {
  return SingleChildScrollView(
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
              // sortAscending: sort,
              source: RowSource(
                myData: myData,
                count: myData.length,
              ),
              rowsPerPage: 9,
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
                          "ID",
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
                          "Image",
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
                          "Item Description",
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
                          "Class",
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
                          "Type",
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
                          "Quantity",
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
  );
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
          Align(alignment: Alignment.center, child: Text(data.id ?? "id"))),
      const DataCell(Align(alignment: Alignment.center, child: FlutterLogo())),
      DataCell(Align(
          alignment: Alignment.center,
          child: Text(data.description.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.classi.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.typei.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.quantity.toString()))),
    ],
  );
}

class Data {
  String? id;
  String? image;
  String? description;
  String? classi;
  String? typei;
  String? quantity;

  Data({
    required this.id,
    required this.image,
    required this.description,
    required this.classi,
    required this.typei,
    required this.quantity,
  });
}

List<Data> myData = [
  Data(
    id: "1",
    image: 'A',
    description: 'A1A',
    classi: '464',
    typei: '23',
    quantity: '24524',
  ),
  Data(
    id: "2",
    image: '6464646',
    description: '30',
    classi: '512',
    typei: '172',
    quantity: '`52435`',
  ),
  Data(
    id: "3",
    image: '8888',
    description: '32',
    classi: '512',
    typei: '172',
    quantity: '245245',
  ),
  Data(
    id: "4",
    image: '3333333',
    description: '33',
    classi: '512',
    typei: '172',
    quantity: '245245',
  ),
  Data(
    id: "5",
    image: '987654556',
    description: '23',
    classi: '512',
    typei: '172',
    quantity: '245245',
  ),
  Data(
    id: "6",
    image: '46464664',
    description: '24',
    classi: '512',
    typei: '172',
    quantity: '24524',
  ),
  Data(
    id: "7",
    image: '5353535',
    description: '36',
    classi: '512',
    typei: '172',
    quantity: '13435',
  ),
  Data(
    id: "8",
    image: '244242',
    description: '38',
    classi: '512',
    typei: '172',
    quantity: '65979',
  ),
  Data(
    id: "9",
    image: '323232323',
    description: '29',
    classi: '512',
    typei: '172',
    quantity: '69659',
  ),
  Data(
    id: "10",
    image: '323232323',
    description: '29',
    classi: '512',
    typei: '172',
    quantity: '694689',
  ),
  Data(
    id: "11",
    image: '323232323',
    description: '29',
    classi: '512',
    typei: '172',
    quantity: '67947',
  ),
  Data(
    id: "12",
    image: '323232323',
    description: '29',
    classi: '512',
    typei: '172',
    quantity: '6479467',
  ),
  Data(
    id: "13",
    image: '323232323',
    description: '29',
    classi: '512',
    typei: '172',
    quantity: '658365',
  ),
  Data(
    id: "14",
    image: '323232323',
    description: '29',
    classi: '512',
    typei: '172',
    quantity: '5686',
  ),
  Data(
    id: "15",
    image: '323232323',
    description: '29',
    classi: '512',
    typei: '172',
    quantity: '3477',
  ),
  Data(
    id: "16",
    image: '323232323',
    description: '29',
    classi: '512',
    typei: '172',
    quantity: '457',
  ),
  Data(
    id: "17",
    image: '323232323',
    description: '29',
    classi: '512',
    typei: '172',
    quantity: '45725',
  ),
  Data(
    id: "18",
    image: '323232323',
    description: '29',
    classi: '512',
    typei: '172',
    quantity: '257457',
  ),
  Data(
    id: "19",
    image: '323232323',
    description: '29',
    classi: '512',
    typei: '172',
    quantity: '245747',
  ),
];
