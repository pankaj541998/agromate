import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:flutter_agro_new/pages/popup.dart';
import 'package:flutter_agro_new/pages/stock_planner.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../component/custom_Elevated_Button.dart';
import '../component/text_Input_field.dart';

class Allocation extends StatefulWidget {
  Allocation({Key? key, this.initial}) : super(key: key);

  @override
  State<Allocation> createState() => _AllocationState();

  int? initial;
}

class _AllocationState extends State<Allocation> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      initialIndex: widget.initial ?? 0,
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopBar(),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
              child: Column(
                children: [
                  SizedBox(height: screenSize.height * 0.02),
                  Row(
                    children: [
                      const SizedBox(
                        width: 120,
                        height: 50,
                        child: TabBar(
                          indicatorColor: Color(0xFF327C04),
                          labelColor: Colors.black,
                          unselectedLabelStyle:
                              TextStyle(color: Color(0xFF6B6B6B)),
                          labelStyle: TextStyle(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          tabs: [
                            Tab(
                              text: 'Allocation',
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
                            InkWell(
                              // onTap: () => buildPin(context),
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
                                    //   myDataRequest = filterData!
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
                  SizedBox(
                    height: screenSize.height * 0.8,
                    child: TabBarView(
                      children: [
                        _buildusertable(screenSize, context, setState),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_buildusertable(screenSize, context, setState) {
  return Container(
    child: SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.only(top: 15),
          child: datatable(screenSize, context, setState)),
    ),
  );
}

datatable(screenSize, context, setState) {
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
                setState: setState,
                myData: myData,
                count: myData.length,
                context: context,
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
                          "Username",
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
                          "Phone Number",
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
                          "Email Address",
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

class RowSource extends DataTableSource {
  var myData;
  final count;
  final setState;
  BuildContext context;
  RowSource(
      {required this.myData,
      required this.count,
      required this.context,
      required this.setState});

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRow(myData![index], context, setState);
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

DataRow recentFileDataRow(var data, context, setState) {
  return DataRow(
    cells: [
      DataCell(Align(
        alignment: Alignment.center,
        child: Image.asset(height: 30, "assets/images/albert.png"),
      )),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.username.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.fullname.toString()))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Text(data.phonenumber.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.email.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.role.toString()))),
      DataCell(Align(
          alignment: Alignment.center,
          child: _buildactions(context, setState))),
    ],
  );
}

_buildactions(context, setState) {
  bool status = true;
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        height: 30,
        width: 50,
        child: FlutterSwitch(
          activeColor: Color(0xff327c04),
          value: status,
          onToggle: (val) {
            setState(() {
              status = val;
            });
          },
        ),
      ),
      InkWell(
          onTap: () {
            print("pressed");
            buildPinAlert(context);
          },
          child: Image.asset(height: 30, "assets/images/edit.png")),
      InkWell(
          onTap: () {
            print("pressed");
            customAlert(context);
          },
          child: Image.asset(height: 30, "assets/images/delete.png")),
    ],
  );
}

//edit user
buildPinAlert(context) {
  return showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return Column(
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
                        "Edit New User",
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
                          height: 50,
                          width: 300,
                          child:
                              TextInputField(hintText: "", validatorText: ""))
                    ],
                  ),
                  SizedBox(
                    height: 20,
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
                          height: 50,
                          width: 300,
                          child:
                              TextInputField(hintText: "", validatorText: ""))
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
                        child: customElevatedButton(
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
                          onPressed: () {},
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

class Data {
  String? profile;
  String? username;
  String? fullname;
  String? phonenumber;
  String? email;
  String? role;
  String? action;

  Data({
    required this.profile,
    required this.username,
    required this.fullname,
    required this.phonenumber,
    required this.email,
    required this.role,
    required this.action,
  });
}

List<Data> myData = [
  Data(
    profile: "1",
    username: 'Raj',
    fullname: 'A1A',
    phonenumber: '464',
    email: '23',
    role: '134',
    action: '24524',
  ),
  Data(
    profile: "2",
    username: 'Raju',
    fullname: '30',
    phonenumber: '512',
    email: '172',
    role: '124',
    action: '`52435`',
  ),
  Data(
    profile: "3",
    username: 'Kishan',
    fullname: '32',
    phonenumber: '512',
    email: '172',
    role: '42',
    action: '245245',
  ),
  Data(
    profile: "4",
    username: 'Dhurmil',
    fullname: '33',
    phonenumber: '512',
    email: '172',
    role: '245',
    action: '245245',
  ),
  Data(
    profile: "5",
    username: 'Pooja',
    fullname: '23',
    phonenumber: '512',
    email: '172',
    role: '2452',
    action: '245245',
  ),
  Data(
    profile: "6",
    username: 'Jothi',
    fullname: '24',
    phonenumber: '512',
    email: '172',
    role: '452',
    action: '24524',
  ),
  Data(
    profile: "7",
    username: 'Salman',
    fullname: '36',
    phonenumber: '512',
    email: '172',
    role: '245',
    action: '13435',
  ),
  Data(
    profile: "8",
    username: '244242',
    fullname: '38',
    phonenumber: '512',
    email: '172',
    role: '67',
    action: '65979',
  ),
  Data(
    profile: "9",
    username: '323232323',
    fullname: '29',
    phonenumber: '512',
    email: '172',
    role: '6579',
    action: '69659',
  ),
  Data(
    profile: "10",
    username: '323232323',
    fullname: '29',
    phonenumber: '512',
    email: '172',
    role: '65968',
    action: '694689',
  ),
  Data(
    profile: "11",
    username: '323232323',
    fullname: '29',
    phonenumber: '512',
    email: '172',
    role: '64794',
    action: '67947',
  ),
  Data(
    profile: "12",
    username: '323232323',
    fullname: '29',
    phonenumber: '512',
    email: '172',
    role: '46794',
    action: '6479467',
  ),
  Data(
    profile: "13",
    username: '323232323',
    fullname: '29',
    phonenumber: '512',
    email: '172',
    role: '58',
    action: '658365',
  ),
  Data(
    profile: "14",
    username: '323232323',
    fullname: '29',
    phonenumber: '512',
    email: '172',
    role: '6576',
    action: '5686',
  ),
  Data(
    profile: "15",
    username: '323232323',
    fullname: '29',
    phonenumber: '512',
    email: '172',
    role: '568',
    action: '3477',
  ),
  Data(
    profile: "16",
    username: '323232323',
    fullname: '29',
    phonenumber: '512',
    email: '172',
    role: '42572',
    action: '457',
  ),
  Data(
    profile: "17",
    username: '323232323',
    fullname: '29',
    phonenumber: '512',
    email: '172',
    role: '547',
    action: '45725',
  ),
  Data(
    profile: "18",
    username: '323232323',
    fullname: '29',
    phonenumber: '512',
    email: '172',
    role: '2457',
    action: '257457',
  ),
  Data(
    profile: "19",
    username: '323232323',
    fullname: '29',
    phonenumber: '512',
    email: '172',
    role: '257',
    action: '245747',
  ),
];
