// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_agro_new/component/text_Input_field.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:flutter_agro_new/main.dart';
import 'package:flutter_agro_new/models/ModeModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../component/custom_Elevated_Button.dart';

late ModeModel modes;
final nameTextEditingController = TextEditingController();
final descriptionTextEditingController = TextEditingController();
final costTextEditingController = TextEditingController();
final quantityTextEditingController = TextEditingController();
final valueTextEditingController = TextEditingController();

class ModesOfApplication extends StatefulWidget {
  const ModesOfApplication({Key? key}) : super(key: key);

  @override
  State<ModesOfApplication> createState() => _ModesOfApplicationState();
}

class _ModesOfApplicationState extends State<ModesOfApplication> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  StreamController<requestResponseState> _moderefresh =
      StreamController.broadcast();

  String? unitcost;
  String? plantPopulation;
  String? yield;
  String? weeks;
  TextEditingController controller = TextEditingController();
  int no = 0;
  bool sort = true;
  List<ModeData>? filterData;

  Future<String> addMode() async {
    debugPrint("reached");
    Map<String, String> updata = {
      "mode": nameTextEditingController.text.toString(),
      "item_description": descriptionTextEditingController.text.toString(),
      "application_cost": costTextEditingController.text.toString(),
      "quantity": quantityTextEditingController.text.toString(),
      "value": valueTextEditingController.text.toString()
      // "email": email.text.toString(),
      // "role_type": '$roleIndex'
    };
    return await addNewMode(updata);
  }

  Future<String> addNewMode(Map<String, String> updata) async {
    final _chuckerHttpClient = await http.Client();
    print(updata);
    final prefs = await SharedPreferences.getInstance();
    http.Response response = await _chuckerHttpClient.post(
      Uri.parse('https://agromate.website/laravel/api/mode'),
      body: updata,
    );
    print(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      return 'null';
    } else {
      return 'throw (Exception("Search Error"))';
    }
  }

  Future<ModeModel> fetchModes() async {
    var client = http.Client();
    final response = await client
        .get(Uri.parse('https://agromate.website/laravel/api/get/mode'));
    final parsed = jsonDecode(response.body);
    // print(response.body);
    modes = ModeModel.fromJson(parsed);
    // print(registeredusers.data!.elementAt(1).firstName!);
    _moderefresh.add(requestResponseState.DataReceived);
    return modes;
  }

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
    // filterData = modes.data!;
    super.initState();
  }

  buildPinAlertDialog() {
    nameTextEditingController.clear();
    descriptionTextEditingController.clear();
    costTextEditingController.clear();
    quantityTextEditingController.clear();
    valueTextEditingController.clear();
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AlertDialog(
                  insetPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  contentPadding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Add Application",
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
                  content: Column(
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
                                  width: 300,
                                  child: TextInputField(
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(25),
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[a-zA-Z]')),
                                      ],
                                      validator: (value) {
                                        if (value != null && value.isEmpty) {
                                          return "Please Enter Name";
                                        }
                                        return null;
                                      },
                                      textEditingController:
                                          nameTextEditingController,
                                      hintText: "",
                                      validatorText: ""))
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
                                  width: 300,
                                  child: TextInputField(
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(25),
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[a-zA-Z]')),
                                      ],
                                      validator: (value) {
                                        if (value != null && value.isEmpty) {
                                          return "Please Enter Description";
                                        }
                                        return null;
                                      },
                                      textEditingController:
                                          descriptionTextEditingController,
                                      hintText: "",
                                      validatorText: ""))
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
                                  width: 300,
                                  child: TextInputField(
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(6),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      validator: (value) {
                                        if (value != null && value.isEmpty) {
                                          return "Please Enter Application Cost";
                                        }
                                        return null;
                                      },
                                      textEditingController:
                                          costTextEditingController,
                                      hintText: "",
                                      validatorText: ""))
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
                                  width: 300,
                                  child: TextInputField(
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(6),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      validator: (value) {
                                        if (value != null && value.isEmpty) {
                                          return "Please Enter Quantity";
                                        }
                                        return null;
                                      },
                                      textEditingController:
                                          quantityTextEditingController,
                                      hintText: "",
                                      validatorText: ""))
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
                                  width: 300,
                                  child: TextInputField(
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(6),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      validator: (value) {
                                        if (value != null && value.isEmpty) {
                                          return "Please Enter Value";
                                        }
                                        return null;
                                      },
                                      textEditingController:
                                          valueTextEditingController,
                                      hintText: "",
                                      validatorText: ""))
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
                            final isValid = _form.currentState?.validate();

                            if (isValid!) {
                              // _moderefresh.add(true);
                              addMode();
                              Navigator.pop(context);
                            } else {
                              Flushbar(
                                duration: const Duration(seconds: 2),
                                message: "Please Enter All Details",
                              ).show(context);
                            }
                          },
                          title: "Submit",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
                                  print("searched value is $value");

                                  setState(() {
                                    myData = modes.data!
                                        .where(
                                          (element) => element.mode!
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
                                placeholder: 'Search',
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
                StreamBuilder<requestResponseState>(
                    stream: _moderefresh.stream,
                    builder: (context, snapshot) {
                      if (snapshot.data == requestResponseState.DataReceived) {
                        if (snapshot.hasData) {
                          return datatable(screenSize);
                        }
                      }
                      return const Center(child: CircularProgressIndicator());
                    }),
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

DataRow recentFileDataRow(ModeData data, int index) {
  int no = index + 1;
  return DataRow(
    cells: [
      DataCell(Align(alignment: Alignment.center, child: Text(no.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.mode.toString()))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Text(data.itemDescription.toString()))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Text(data.applicationCost.toString()))),
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

List<ModeData> myData = modes.data!;
// List<Data> myData = [
//   Data(
//     id: "1",
//     name: 'Tractor',
//     description: 'To pull a plow through her corn field before planting.',
//     applicationcost: '678.6',
//     value: '500',
//     quantity: '500',
//   ),
//   Data(
//     id: "2",
//     name: 'Fertigation',
//     description: 'Injection of fertilizers, used for soil amendments, water',
//     applicationcost: '678.6',
//     value: '500',
//     quantity: '500',
//   ),
//   Data(
//     id: "3",
//     name: 'Drone',
//     description: 'Can be used to spray chemicals as they have reservoirs',
//     applicationcost: '678.6',
//     value: '500',
//     quantity: '500',
//   ),
//   Data(
//     id: "4",
//     name: 'Center Pivot',
//     description:
//         'Rotates around a pivot and crops are watered with sprinklers.',
//     applicationcost: '678.6',
//     value: '500',
//     quantity: '500',
//   ),
//   Data(
//     id: "5",
//     name: 'Tractor',
//     description: 'To pull a plow through her corn field before planting.',
//     applicationcost: '678.6',
//     value: '500',
//     quantity: '500',
//   ),
//   Data(
//     id: "6",
//     name: 'Fertigation',
//     description: 'Injection of fertilizers, used for soil amendments, water',
//     applicationcost: '678.6',
//     value: '500',
//     quantity: '500',
//   ),
//   Data(
//     id: "7",
//     name: 'Drone',
//     description: 'Can be used to spray chemicals as they have reservoirs',
//     applicationcost: '678.6',
//     value: '500',
//     quantity: '500',
//   ),
//   Data(
//     id: "8",
//     name: 'Center Pivot',
//     description:
//         'Rotates around a pivot and crops are watered with sprinklers.',
//     applicationcost: '678.6',
//     value: '500',
//     quantity: '500',
//   ),
//   Data(
//     id: "9",
//     name: 'Tractor',
//     description: 'To pull a plow through her corn field before planting.',
//     applicationcost: '678.6',
//     value: '500',
//     quantity: '500',
//   ),
//   Data(
//     id: "10",
//     name: 'Fertigation',
//     description: 'Injection of fertilizers, used for soil amendments, water',
//     applicationcost: '678.6',
//     value: '500',
//     quantity: '500',
//   ),
//   Data(
//     id: "11",
//     name: 'Drone',
//     description: 'Can be used to spray chemicals as they have reservoirs',
//     applicationcost: '678.6',
//     value: '500',
//     quantity: '500',
//   ),
// ];
