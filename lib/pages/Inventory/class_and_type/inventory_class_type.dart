// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:typed_data';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_agro_new/component/text_Input_field.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:flutter_agro_new/pages/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../component/custom_Elevated_Button.dart';
import '../../../models/type_model.dart';
import '../../../models/class_model.dart';
import '../../../models/not_registered_user_model.dart';

late ClassModel classdata;
late TypeModel typedata;
final classTextEditingController = TextEditingController();
final classdescriptionTextEditingController = TextEditingController();
final typeTextEditingController = TextEditingController();
final typedescriptionTextEditingController = TextEditingController();
final controller = TextEditingController();
bool _isVisible = false;

class InventoryClassType extends StatefulWidget {
  InventoryClassType({Key? key, this.initial}) : super(key: key);

  @override
  State<InventoryClassType> createState() => _InventoryClassTypeState();
  int? initial;
}

final GlobalKey<FormState> _form = GlobalKey<FormState>();

Future<ClassModel> fetchClass() async {
  var client = http.Client();
  final response = await client
      .get(Uri.parse('https://agromate.website/laravel/api/get/class'));
  final parsed = jsonDecode(response.body);
  // print(response.body);
  classdata = ClassModel.fromJson(parsed);
  // print(classdata.data!.elementAt(1).firstName!);
  return classdata;
}

Future<TypeModel> fetchType() async {
  var client = http.Client();
  final response = await client
      .get(Uri.parse('https://agromate.website/laravel/api/get/type'));
  final parsed = jsonDecode(response.body);
  // print(response.body);
  typedata = TypeModel.fromJson(parsed);
  // print(modedata.data!.elementAt(1).firstName!);
  return typedata;
}

Future<int> deleteClassApi(int id) async {
  final http.Response response = await http.get(
    Uri.parse('https://agromate.website/laravel/api/delete_class/$id'),
  );
  return response.statusCode;
}

Future<int> deleteTypeApi(int id) async {
  final http.Response response = await http.get(
    Uri.parse('https://agromate.website/laravel/api/delete_type/$id'),
  );
  return response.statusCode;
}

Future<String> updateClass(id) async {
  debugPrint("reached");
  Map<String, dynamic> updata = {
    "iclass": classTextEditingController.text.toString(),
    "class_description": classdescriptionTextEditingController.text.toString(),
    "class_id": id,
    // $id
  };
  return await updateClassAPI(updata);
}

Future<String> updateClassAPI(Map<String, dynamic> updata) async {
  final _chuckerHttpClient = await http.Client();
  print(updata);
  final prefs = await SharedPreferences.getInstance();
  http.Response response = await _chuckerHttpClient.post(
    Uri.parse("https://agromate.website/laravel/api/update_class"),
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

Future<String> updateType(id, iclass) async {
  debugPrint("reached");
  Map<String, String> updata = {
    "type": typeTextEditingController.text.toString(),
    "type_description": typedescriptionTextEditingController.text.toString(),
    "classid": iclass,
    "type_id": id
    // $id
  };
  return await updateTypeAPI(updata);
}

Future<String> updateTypeAPI(Map<String, String> updata) async {
  final _chuckerHttpClient = await http.Client();
  print(updata);
  final prefs = await SharedPreferences.getInstance();
  http.Response response = await _chuckerHttpClient.post(
    Uri.parse("https://agromate.website/laravel/api/update_type"),
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

Future<String> addClass() async {
  debugPrint("reached");
  Map<String, dynamic> updata = {
    "iclass": classTextEditingController.text.toString(),
    "class_description": classdescriptionTextEditingController.text.toString(),
  };
  return await addClassAPI(updata);
}

Future<String> addClassAPI(Map<String, dynamic> updata) async {
  final _chuckerHttpClient = await http.Client();
  print(updata);
  final prefs = await SharedPreferences.getInstance();
  http.Response response = await _chuckerHttpClient.post(
    Uri.parse("https://agromate.website/laravel/api/class"),
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

class _InventoryClassTypeState extends State<InventoryClassType> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();

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
                      "Add Inventory",
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
                                "Stock Code",
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
                                "Unit cost",
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
                                "Inventory Cost",
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
                          const SizedBox(
                            width: 25,
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
    return DefaultTabController(
      initialIndex: widget.initial ?? 0,
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            TopBar(),
            const SizedBox(
              height: 10,
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
                          child: Icon(Icons.arrow_back_ios_rounded)),
                      SizedBox(width: screenSize.width * 0.02),
                      Text(
                        'Inventory Category & Types',
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
                            Visibility(
                                visible: _isVisible, child: FlutterLogo()),
                            InkWell(
                              onTap: () {
                                buildPinAddClass(context);
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
                                    setState(() {
                                      myData = classdata.data!
                                          .where(
                                            (element) => element.iclass!
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
                                  placeholder: 'Search',
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
                  const SizedBox(height: 7),
                  Divider(
                    height: 5,
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  Row(
                    children: [
                      const SizedBox(
                        width: 300,
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
                              text: 'Category',
                            ),
                            Tab(
                              text: 'Type',
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenSize.height * 0.6,
                    child: TabBarView(
                      children: [
                        // FlutterLogo(),
                        FutureBuilder<ClassModel>(
                          future: fetchClass(),
                          builder: (ctx, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData) {
                                debugPrint(snapshot.data.toString());
                                return _buildusertable(screenSize, context);
                              } else {
                                return Center(
                                  child: Text(
                                    '${snapshot.error} occured',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                );
                              }
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        ),
                        // FlutterLogo(),

                        // _buildusertable(screenSize, context),
                        FutureBuilder<TypeModel>(
                          future: fetchType(),
                          builder: (ctx, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData) {
                                debugPrint("type table called");
                                return _buildrequesttable(screenSize, context);
                              } else {
                                return Center(
                                  child: Text(
                                    '${snapshot.error} occured',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                );
                              }
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        ),
                        // _buildrequesttable(screenSize, context),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

_buildusertable(screenSize, context) {
  return Container(
    height: screenSize.height * 0.5,
    child: SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.only(top: 15),
          child: datatable(screenSize, context)),
    ),
  );
}

class RowSource extends DataTableSource {
  var myData;
  final count;
  String? role;
  BuildContext context;
  RowSource({
    required this.myData,
    required this.count,
    required this.context,
  });

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

datatable(screenSize, context) {
  return SizedBox(
    height: screenSize.height * 0.7,
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
                // sortAscending: sort,
                source: RowSource(
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
                            "Category",
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
                            "Actions",
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

DataRow recentFileDataRow(ClassData data, context, int index) {
  int no = index + 1;
  return DataRow(
    cells: [
      DataCell(Align(alignment: Alignment.center, child: Text(no.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.iclass.toString()))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Text(data.classDescription.toString()))),
      DataCell(Align(
          alignment: Alignment.center,
          child: //FlutterLogo(),
              _buildactions(context, data, index))),
    ],
  );
}

_buildactions(context, data, index) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      InkWell(
          onTap: () {
            int id = classdata.data!.elementAt(index).id!;
            debugPrint(id.toString());
            String iclass = classdata.data!.elementAt(index).iclass!.toString();
            String description =
                classdata.data!.elementAt(index).classDescription!.toString();
            buildPinClass(context, id,
                iclass: iclass, description: description);
          },
          child: Image.asset("assets/images/edit.png", height: 30)),
      InkWell(
          onTap: () {
            int id = classdata.data!.elementAt(index).id!;
            debugPrint(id.toString());
            customAlert(context, id);
          },
          child: Image.asset("assets/images/delete.png", height: 30)),
    ],
  );
}

_buildactionstype(context, data, index) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      InkWell(
          onTap: () {
            int id = typedata.data!.elementAt(index).id!;
            debugPrint(id.toString());
            String iclass = typedata.data!.elementAt(index).classid!.toString();
            String type = typedata.data!.elementAt(index).type!.toString();
            String description =
                typedata.data!.elementAt(index).typeDescription!.toString();
            debugPrint(type);

            buildPinType(context, id,
                iclass: iclass, description: description, type: type);
          },
          child: Image.asset("assets/images/edit.png", height: 30)),
      InkWell(
          onTap: () {
            int id = typedata.data!.elementAt(index).id!;
            debugPrint(id.toString());

            customAlertType(context, id);
          },
          child: Image.asset("assets/images/delete.png", height: 30)),
    ],
  );
}

_buildrequesttable(screenSize, context) {
  return Padding(
    padding: EdgeInsets.only(top: 15),
    child: datatablerequest(screenSize, context),
  );
}

class RowSourceRequest extends DataTableSource {
  var myDataRequest;
  final count;
  BuildContext context;
  RowSourceRequest({
    required this.myDataRequest,
    required this.count,
    required this.context,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRowrequest(myDataRequest![index], context, index);
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

datatablerequest(screenSize, BuildContext context) {
  debugPrint("type table reached");

  return Container(
    height: screenSize.height * 0.7,
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
              source: RowSourceRequest(
                  myDataRequest: typedata.data!,
                  count: typedata.data!.length,
                  context: context),
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
                          "Category",
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

DataRow recentFileDataRowrequest(TypeData data, context, int index) {
  int no = index + 1;
  debugPrint("type row called");
  debugPrint(classdata.data.toString());
  classdata.data!.forEach((element) {
    debugPrint("${data.classid}, ${element.id}, ${element.iclass}");
  });
  // String? name = classdata.data
  //     .singleWhere((element) => element.id.toString() == data.classid)
  //     .iclass;
  return DataRow(
    cells: [
      DataCell(Align(alignment: Alignment.center, child: Text(no.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.type.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.classid.toString()))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Text(data.typeDescription.toString()))),
      DataCell(Align(
          alignment: Alignment.center,
          child: //FlutterLogo(),
              _buildactionstype(context, data, index))),
    ],
  );
}

customAlert(context, id) {
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
                          onPressed: () {
                            setState(() {
                              deleteClassApi(id).then((value) =>
                                  Navigator.pushNamed(
                                      context, '/classandtype'));
                            });
                          },
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

customAlertType(context, id) {
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
                          onPressed: () {
                            setState(() {
                              deleteTypeApi(id).then((value) =>
                                  Navigator.pushNamed(
                                      context, '/classandtype'));
                            });
                          },
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

buildPinClass(context, id,
    {required String iclass, required String description}) {
  classTextEditingController.text = iclass;
  classdescriptionTextEditingController.text = description;
  debugPrint(id.toString());
  debugPrint(iclass);
  debugPrint(description);

  return showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return Form(
          key: _form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                contentPadding: EdgeInsets.only(top: 10.0),
                content: Padding(
                  padding:
                      EdgeInsets.only(top: 0, left: 25, right: 25, bottom: 25),
                  child: Column(
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
                            "Update Class",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Class",
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
                                          textEditingController:
                                              classTextEditingController,
                                          hintText: "",
                                          validator: (value) {
                                            if (value != null &&
                                                value.isEmpty) {
                                              return "Please Enter Class Name";
                                            }
                                            return null;
                                          },
                                          validatorText: ""))
                                ],
                              ),
                              SizedBox(
                                height: 20,
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
                                      height: 100,
                                      width: 600,
                                      child: TextInputField(
                                          textEditingController:
                                              classdescriptionTextEditingController,
                                          hintText: "",
                                          validator: (value) {
                                            if (value != null &&
                                                value.isEmpty) {
                                              return "Please Enter Item Description";
                                            }
                                            return null;
                                          },
                                          validatorText: ""))
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
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
                                final isValid = _form.currentState?.validate();
                                if (isValid!) {
                                  setState(() {
                                    updateClass(id.toString()).then((value) =>
                                        Navigator.pushNamed(
                                            context, '/classandtype'));
                                  });
                                  // addCropProgram();
                                } else {
                                  Flushbar(
                                    duration: const Duration(seconds: 2),
                                    message: "Please Enter All Details",
                                  ).show(context);
                                }
                                // addCropProgram();
                                // Navigator.pop(context);
                              },
                              title: "Update",
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

buildPinAddClass(context) {
  return showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return Form(
          key: _form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                contentPadding: EdgeInsets.only(top: 10.0),
                content: Padding(
                  padding:
                      EdgeInsets.only(top: 0, left: 25, right: 25, bottom: 25),
                  child: Column(
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
                            "Add Class",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Class",
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
                                          textEditingController:
                                              classTextEditingController,
                                          hintText: "",
                                          validator: (value) {
                                            if (value != null &&
                                                value.isEmpty) {
                                              return "Please Enter Class Name";
                                            }
                                            return null;
                                          },
                                          validatorText: ""))
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Class Description",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                      height: 100,
                                      width: 600,
                                      child: TextInputField(
                                          textEditingController:
                                              classdescriptionTextEditingController,
                                          hintText: "",
                                          validator: (value) {
                                            if (value != null &&
                                                value.isEmpty) {
                                              return "Please Enter Class Description";
                                            }
                                            return null;
                                          },
                                          validatorText: ""))
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
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
                                final isValid = _form.currentState?.validate();
                                if (isValid!) {
                                  setState(() {
                                    addClass().then((value) =>
                                        Navigator.pushNamed(
                                            context, '/classandtype'));
                                  });
                                  // addCropProgram();
                                } else {
                                  Flushbar(
                                    duration: const Duration(seconds: 2),
                                    message: "Please Enter All Details",
                                  ).show(context);
                                }
                                // addCropProgram();
                                // Navigator.pop(context);
                              },
                              title: "Update",
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

buildPinAddType(context) {
  return showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return Form(
          key: _form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                contentPadding: EdgeInsets.only(top: 10.0),
                content: Padding(
                  padding:
                      EdgeInsets.only(top: 0, left: 25, right: 25, bottom: 25),
                  child: Column(
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
                            "Add Type",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Class",
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
                                              textEditingController:
                                                  classTextEditingController,
                                              hintText: "",
                                              validator: (value) {
                                                if (value != null &&
                                                    value.isEmpty) {
                                                  return "Please Enter Class Name";
                                                }
                                                return null;
                                              },
                                              validatorText: ""))
                                    ],
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Type",
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
                                              textEditingController:
                                                  typeTextEditingController,
                                              hintText: "",
                                              validator: (value) {
                                                if (value != null &&
                                                    value.isEmpty) {
                                                  return "Please Enter Type Name";
                                                }
                                                return null;
                                              },
                                              validatorText: ""))
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
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
                                      width: 620,
                                      child: TextInputField(
                                          showContentPadding: true,
                                          textEditingController:
                                              typedescriptionTextEditingController,
                                          hintText: "",
                                          validator: (value) {
                                            if (value != null &&
                                                value.isEmpty) {
                                              return "Please Enter Item Description";
                                            }
                                            return null;
                                          },
                                          validatorText: ""))
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
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
                                final isValid = _form.currentState?.validate();
                                if (isValid!) {
                                  setState(() {
                                    addClass().then((value) =>
                                        Navigator.pushNamed(
                                            context, '/classandtype'));
                                  });
                                  // addCropProgram();
                                } else {
                                  Flushbar(
                                    duration: const Duration(seconds: 2),
                                    message: "Please Enter All Details",
                                  ).show(context);
                                }
                                // addCropProgram();
                                // Navigator.pop(context);
                              },
                              title: "Update",
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

buildPinType(context, id,
    {required String iclass,
    required String description,
    required String type}) {
  classTextEditingController.text = iclass;
  typeTextEditingController.text = type;
  typedescriptionTextEditingController.text = description;
  debugPrint(id.toString());
  debugPrint(iclass);
  debugPrint(type);
  debugPrint(description);

  return showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return Form(
          key: _form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                contentPadding: EdgeInsets.only(top: 10.0),
                content: Padding(
                  padding:
                      EdgeInsets.only(top: 0, left: 25, right: 25, bottom: 25),
                  child: Column(
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
                            "Update Type",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Class",
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
                                                LengthLimitingTextInputFormatter(
                                                    25),
                                              ],
                                              textEditingController:
                                                  classTextEditingController,
                                              hintText: "",
                                              validator: (value) {
                                                if (value != null &&
                                                    value.isEmpty) {
                                                  return "Please Enter Class Name";
                                                }
                                                return null;
                                              },
                                              validatorText: ""))
                                    ],
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Type",
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
                                                LengthLimitingTextInputFormatter(
                                                    25),
                                                FilteringTextInputFormatter
                                                    .allow(RegExp('[a-zA-Z]')),
                                              ],
                                              textEditingController:
                                                  typeTextEditingController,
                                              hintText: "",
                                              validator: (value) {
                                                if (value != null &&
                                                    value.isEmpty) {
                                                  return "Please Enter Type Name";
                                                }
                                                return null;
                                              },
                                              validatorText: ""))
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
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
                                      height: 100,
                                      width: 600,
                                      child: TextInputField(
                                          textEditingController:
                                              typedescriptionTextEditingController,
                                          hintText: "",
                                          validator: (value) {
                                            if (value != null &&
                                                value.isEmpty) {
                                              return "Please Enter Item Description";
                                            }
                                            return null;
                                          },
                                          validatorText: ""))
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
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
                                final isValid = _form.currentState?.validate();
                                if (isValid!) {
                                  setState(() {
                                    updateType(id.toString(), iclass).then(
                                        (value) => Navigator.pushNamed(
                                            context, '/classandtype'));
                                  });
                                  // addCropProgram();
                                } else {
                                  Flushbar(
                                    duration: const Duration(seconds: 2),
                                    message: "Please Enter All Details",
                                  ).show(context);
                                }

                                // addCropProgram();
                                // Navigator.pop(context);
                              },
                              title: "Update",
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

List<ClassData> myData = classdata.data!;
