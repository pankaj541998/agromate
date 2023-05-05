import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:flutter_agro_new/models/allocactionModel.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../component/custom_Elevated_Button.dart';
import '../../component/text_Input_field.dart';

late allocationModel allocation;

enum requestResponseState { Error, DataReceived, Loading, SessionExpired }

final StreamController<requestResponseState> _schedulerefresh =
    StreamController.broadcast();

final GlobalKey<FormState> _form = GlobalKey<FormState>();

class Allocation extends StatefulWidget {
  Allocation({Key? key, this.initial}) : super(key: key);

  @override
  State<Allocation> createState() => _AllocationState();

  int? initial;
}

class _AllocationState extends State<Allocation> {
  late Future myFuture;
  @override
  void initState() {
    // fetchAllocation();
    myFuture = fetchAllocation();

    super.initState();
  }

  Future<allocationModel> fetchAllocation() async {
    print("apicalled");
    var client = http.Client();
    final response = await client
        .get(Uri.parse('https://agromate.website/laravel/api/get_allocation'));
    final parsed = jsonDecode(response.body);
    print("api call data ${response.body}");
    allocation = allocationModel.fromJson(parsed);
    myData = allocation.data!;
    _schedulerefresh.add(requestResponseState.DataReceived);
    return allocation;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopBar(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
            child: Column(
              children: [
                SizedBox(height: screenSize.height * 0.02),
                Row(
                  children: [
                    // const SizedBox(
                    //   width: 120,
                    //   height: 50,
                    //   child: TabBar(
                    //     indicatorColor: Color(0xFF327C04),
                    //     labelColor: Colors.black,
                    //     unselectedLabelStyle:
                    //         TextStyle(color: Color(0xFF6B6B6B)),
                    //     labelStyle: TextStyle(
                    //       color: Color(0xFF000000),
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 16,
                    //     ),
                    //     tabs: [
                    //       Tab(
                    //         text: 'Allocation',
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () => Get.toNamed("/allocate"),
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
                                    myData = allocation.data!
                                        .where(
                                          (element) => element
                                              .getLandholder!.first.firstName!
                                              .toLowerCase()
                                              .contains(value.toLowerCase()),
                                        )
                                        .toList();
                                  });
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
                FutureBuilder(
                  future: myFuture,
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
    // fetchAllocation();
    return Container(
      decoration: const BoxDecoration(),
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
                  context: context,
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
                            "Profile",
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
                            "Full Name",
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
                            "Role",
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
                            "landholder",
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
                            "Action",
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
}

_buildusertable(screenSize, context) {}

// datatable(screenSize, context) {}

class RowSource extends DataTableSource {
  var myData;
  final count;
  BuildContext context;

  RowSource({required this.myData, required this.count, required this.context});

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRow(myData![index], context, index);
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

DataRow recentFileDataRow(allocationData data, context, int index) {
  int no = index + 1;

  return DataRow(
    cells: [
      DataCell(Align(alignment: Alignment.center, child: Text(no.toString()))),
      DataCell(Align(
        alignment: Alignment.center,
        child: Image.asset("assets/images/albert.png", height: 30),
      )),
      DataCell(Align(
          alignment: Alignment.center,
          child: Text(data.getLandholder!.first.firstName.toString()))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Text(data.getFarm!.first.farm.toString()))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Text(data.getFarm!.first.farm.toString()))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Text(data.getFarm!.first.farm.toString()))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Text(data.getFarm!.first.farm.toString()))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Text(data.getFarm!.first.farm.toString()))),
      DataCell(
          Align(alignment: Alignment.center, child: _buildactions(context))),
    ],
  );
}

_buildactions(context) {
  bool switchit = true;

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      FlutterSwitch(
        padding: 0,
        activeSwitchBorder: Border.all(color: Color(0xff327C04)),
        width: 38.0,
        height: 16.0,
        toggleSize: 15,
        toggleColor: Color(0xff327C04),
        activeColor: Color(0xFFF7F9EA),
        inactiveColor: Colors.grey,
        value: switchit,
        onToggle: (val) {
          switchit = !val;
        },
      ),
      SizedBox(
        width: 10,
      ),
      InkWell(
          onTap: () {
            print("pressed");
            buildPinAlert(context);
          },
          child: Image.asset("assets/images/edit.png", height: 30)),
      InkWell(
          onTap: () {
            print("pressed");
            customAlert(context);
          },
          child: Image.asset("assets/images/delete.png", height: 30)),
    ],
  );
}

late String _selectedValue;
List<String> listOfValue = [
  'Farmer',
  'Agronomist',
  'Landholder',
  'Manager',
];
late String _selectedValue1;
List<String> listOfValue1 = [
  'kishan',
  'reethik',
  'pankaj',
  'Dhurmil',
];
late String _selectedValue2;
List<String> listOfValue2 = [
  'Farm 1',
  'Farm 2',
  'Farm 3',
  'Farm 4',
];
late String _selectedValue3;
List<String> listOfValue3 = [
  'Block 1',
  'Block 2',
  'Block 3',
  'Block 4',
];
late String _selectedValue4;
List<String> listOfValue4 = [
  'Field 1',
  'Field 2',
  'Field 3',
  'Field 4',
];
//edit user
buildPinAlert(context) {
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
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.cancel_outlined))
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Edit User",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 35,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Enter Email Address",
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
                                    hintText: "Enter Email",
                                    validatorText: "Enter Email"))
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Role",
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
                              child: DropdownButtonFormField(
                                focusColor: Colors.white,
                                isExpanded: true,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 10, top: 10, right: 10),
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xFF327C04)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xFF327C04)),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF327C04),
                                      width: 5.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                items: listOfValue.map((String val) {
                                  return DropdownMenuItem(
                                    enabled: true,
                                    value: val,
                                    child: Text(
                                      val,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedValue;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Landholder",
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
                              child: DropdownButtonFormField(
                                focusColor: Colors.white,
                                isExpanded: true,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 10, top: 10, right: 10),
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xFF327C04)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xFF327C04)),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF327C04),
                                      width: 5.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                items: listOfValue1.map((String val) {
                                  return DropdownMenuItem(
                                    enabled: true,
                                    value: val,
                                    child: Text(
                                      val,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedValue1;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Farm",
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
                              child: DropdownButtonFormField(
                                focusColor: Colors.white,
                                isExpanded: true,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 10, top: 10, right: 10),
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xFF327C04)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xFF327C04)),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF327C04),
                                      width: 5.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                items: listOfValue2.map((String val) {
                                  return DropdownMenuItem(
                                    enabled: true,
                                    value: val,
                                    child: Text(
                                      val,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedValue2;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Block",
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
                              child: DropdownButtonFormField(
                                focusColor: Colors.white,
                                isExpanded: true,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 10, top: 10, right: 10),
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xFF327C04)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xFF327C04)),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF327C04),
                                      width: 5.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                items: listOfValue3.map((String val) {
                                  return DropdownMenuItem(
                                    enabled: true,
                                    value: val,
                                    child: Text(
                                      val,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedValue3;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Field",
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
                              child: DropdownButtonFormField(
                                focusColor: Colors.white,
                                isExpanded: true,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 10, top: 10, right: 10),
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xFF327C04)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xFF327C04)),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF327C04),
                                      width: 5.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                items: listOfValue4.map((String val) {
                                  return DropdownMenuItem(
                                    enabled: true,
                                    value: val,
                                    child: Text(
                                      val,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedValue4;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 28,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40,
                          width: 296,
                          child: CustomElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            title: "Update",
                          ),
                        ),
                      ],
                    )
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

customAlert(context) {
  return showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AlertDialog(
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.cancel_outlined,
                    size: 60,
                    color: Color(0xFFFF0000),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Are You Sure?",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 40,
                        width: 160,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: const BorderSide(
                                  color: Color(0xFF327C04),
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 17,
                              color: Color(0XFF000000),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      SizedBox(
                        height: 40,
                        width: 160,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFF327C04),
                              ),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ))),
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Delete'),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      },
    ),
  );
}

// class Data {
//   String? profile;
//   String? username;
//   String? fullname;
//   String? phonenumber;
//   String? email;
//   String? role;
//   String? action;

//   Data({
//     required this.profile,
//     required this.username,
//     required this.fullname,
//     required this.phonenumber,
//     required this.email,
//     required this.role,
//     required this.action,
//   });
// }

List<allocationData> myData = allocation.data!;
