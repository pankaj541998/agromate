// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_agro_new/component/text_Input_field.dart';
import 'package:flutter_agro_new/component/top_bar.dart';

import '../../../component/custom_Elevated_Button.dart';

class ModesOfApplication extends StatefulWidget {
  const ModesOfApplication({Key? key}) : super(key: key);

  @override
  State<ModesOfApplication> createState() => _ModesOfApplicationState();
}

class _ModesOfApplicationState extends State<ModesOfApplication> {
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

  buildPinAlertDialog() {
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AlertDialog(
                insetPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                contentPadding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Add Application",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Name",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                  height: 40,
                                  width: 300,
                                  child: TextInputField(
                                      hintText: "", validatorText: ""))
                            ],
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Item Description",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                  height: 40,
                                  width: 300,
                                  child: TextInputField(
                                      hintText: "", validatorText: ""))
                            ],
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Application Cost",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                  height: 40,
                                  width: 300,
                                  child: TextInputField(
                                      hintText: "", validatorText: ""))
                            ],
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Quantity",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                  height: 40,
                                  width: 300,
                                  child: TextInputField(
                                      hintText: "", validatorText: ""))
                            ],
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Value",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                  height: 40,
                                  width: 300,
                                  child: TextInputField(
                                      hintText: "", validatorText: ""))
                            ],
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
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back_ios_rounded)),
                    SizedBox(width: screenSize.width * 0.02),
                    Text(
                      'Modes Of Application',
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
                              buildPinAlertDialog();
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
                const SizedBox(height: 20),
                Divider(
                  height: 5,
                  color: Colors.grey,
                  thickness: 1,
                ),
                SizedBox(height: screenSize.height * 0.03),
                datatable(screenSize),
              ],
            ),
          )
        ],
      ),
    );
  }
}

datatable(screenSize) {
  return SizedBox(
    height: screenSize.height * 0.7,
    child: SingleChildScrollView(
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
                          "Name",
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
                          "Application Cost",
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
                DataColumn(
                  label: Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xff327C04).withOpacity(0.11),
                      ),
                      child: const Center(
                        child: Text(
                          "Value",
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
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.name.toString()))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Text(data.description.toString()))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Text(data.applicationcost.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.quantity.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.value.toString()))),
    ],
  );
}

class Data {
  String? id;
  String? name;
  String? description;
  String? applicationcost;
  String? value;
  String? quantity;

  Data({
    required this.id,
    required this.name,
    required this.description,
    required this.applicationcost,
    required this.value,
    required this.quantity,
  });
}

List<Data> myData = [
  Data(
    id: "1",
    name: 'Tractor',
    description: 'To pull a plow through her corn field before planting.',
    applicationcost: '678.6',
    value: '500',
    quantity: '500',
  ),
  Data(
    id: "2",
    name: 'Fertigation',
    description: 'Injection of fertilizers, used for soil amendments, water',
    applicationcost: '678.6',
    value: '500',
    quantity: '500',
  ),
  Data(
    id: "3",
    name: 'Drone',
    description: 'Can be used to spray chemicals as they have reservoirs',
    applicationcost: '678.6',
    value: '500',
    quantity: '500',
  ),
  Data(
    id: "4",
    name: 'Center Pivot',
    description:
        'Rotates around a pivot and crops are watered with sprinklers.',
    applicationcost: '678.6',
    value: '500',
    quantity: '500',
  ),
  Data(
    id: "5",
    name: 'Tractor',
    description: 'To pull a plow through her corn field before planting.',
    applicationcost: '678.6',
    value: '500',
    quantity: '500',
  ),
  Data(
    id: "6",
    name: 'Fertigation',
    description: 'Injection of fertilizers, used for soil amendments, water',
    applicationcost: '678.6',
    value: '500',
    quantity: '500',
  ),
  Data(
    id: "7",
    name: 'Drone',
    description: 'Can be used to spray chemicals as they have reservoirs',
    applicationcost: '678.6',
    value: '500',
    quantity: '500',
  ),
  Data(
    id: "8",
    name: 'Center Pivot',
    description:
        'Rotates around a pivot and crops are watered with sprinklers.',
    applicationcost: '678.6',
    value: '500',
    quantity: '500',
  ),
  Data(
    id: "9",
    name: 'Tractor',
    description: 'To pull a plow through her corn field before planting.',
    applicationcost: '678.6',
    value: '500',
    quantity: '500',
  ),
  Data(
    id: "10",
    name: 'Fertigation',
    description: 'Injection of fertilizers, used for soil amendments, water',
    applicationcost: '678.6',
    value: '500',
    quantity: '500',
  ),
  Data(
    id: "11",
    name: 'Drone',
    description: 'Can be used to spray chemicals as they have reservoirs',
    applicationcost: '678.6',
    value: '500',
    quantity: '500',
  ),
];
