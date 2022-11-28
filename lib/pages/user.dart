import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_agro_new/component/services/constants.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:flutter_agro_new/models/cropPorgramModel.dart';
import 'package:flutter_agro_new/models/not_registered_user_model.dart';
import 'package:flutter_agro_new/models/registered_users_model.dart';
import 'package:flutter_agro_new/pages/popup.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../component/custom_Elevated_Button.dart';
import '../component/text_Input_field.dart';

late RegisteredUserModel registeredusers;
late NotRegisteredUserModel notregisteredusers;
final email = TextEditingController();
final useremailTextEditingController = TextEditingController();
final roleTextEditingController = TextEditingController();
// final email = TextEditingController();
String role = 'Admin';
int roleIndex = 0;
int no = 0;

enum Roles {
  Admin,
  Landholder,
  Agronomist,
  Manager,
  Farmer,
}

class User extends StatefulWidget {
  User({Key? key, this.initial}) : super(key: key);

  @override
  State<User> createState() => _UserState();

  int? initial;
}

Future<RegisteredUserModel> fetchRegisteredUsers() async {
  var client = http.Client();
  final response = await client
      .get(Uri.parse('https://agromate.website/laravel/api/registered_user'));
  final parsed = jsonDecode(response.body);
  // print(response.body);
  registeredusers = RegisteredUserModel.fromJson(parsed);
  // print(registeredusers.data!.elementAt(1).firstName!);
  return registeredusers;
}

Future<NotRegisteredUserModel> fetchNotRegisteredUsers() async {
  var client = http.Client();
  final response = await client.get(
      Uri.parse('https://agromate.website/laravel/api/not_registered_user'));
  final parsed = jsonDecode(response.body);
  notregisteredusers = NotRegisteredUserModel.fromJson(parsed);
  // print(registeredusers.data!.elementAt(1).firstName!);

  return notregisteredusers;
}

Future<String> addUser() async {
  debugPrint("reached");
  Map<String, String> updata = {
    "email": email.text.toString(),
    "role_type": '$roleIndex'
  };
  return await addNewUser(updata);
}

Future<String> addNewUser(Map<String, String> updata) async {
  final _chuckerHttpClient = await http.Client();
  print(updata);
  final prefs = await SharedPreferences.getInstance();
  http.Response response = await _chuckerHttpClient.post(
    Uri.parse(
      ApiConstant.addUserAPI,
    ),
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

Future<int> deleteClassApi(int id) async {
  final http.Response response = await http.delete(
    Uri.parse('https://agromate.website/laravel/api/delete/$id/class'),
  );
  return response.statusCode;
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext) {
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
                              text: 'Users',
                            ),
                            Tab(
                              text: 'Request',
                            )
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
                              onTap: () {
                                buildPin(context);
                                // fetchNotRegisteredUsers();
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
                        FutureBuilder<RegisteredUserModel>(
                          future: fetchRegisteredUsers(),
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
                        //_buildusertable(screenSize, context),
                        FutureBuilder<NotRegisteredUserModel>(
                          future: fetchNotRegisteredUsers(),
                          builder: (ctx, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData) {
                                debugPrint(snapshot.data.toString());
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

_buildrequesttable(screenSize, context) {
  return Padding(
    padding: EdgeInsets.only(top: 15),
    child: datatablerequest(screenSize, context),
  );
}

buildPin(context) {
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
                        "Add New user",
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
                          height: 40,
                          width: 300,
                          child: TextInputField(
                              textEditingController: email,
                              hintText: "",
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
                        child: StatefulBuilder(
                          builder: (context, setState) {
                            return PopupMenuButton<int>(
                              offset: const Offset(1, 0),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3),
                                width: 250,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.green[800]!),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    children: [
                                      Expanded(child: Text(role)),
                                      const Icon(Icons.arrow_drop_down)
                                    ],
                                  ),
                                ),
                              ),
                              itemBuilder: (BuildContext context) =>
                                  Roles.values
                                      .map(
                                        (e) => PopupMenuItem<int>(
                                          value: e.index,
                                          child: Text(e.name),
                                          onTap: () =>
                                              setState(() => role = e.name),
                                        ),
                                      )
                                      .toList(),
                              onSelected: (value) {
                                roleIndex = value;
                                debugPrint('role index: $roleIndex');
                              },
                            );
                          },
                        ),

                        // TextInputField(hintText: "", validatorText: "")
                      )
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
                            print(email);
                            print(roleIndex);
                            addUser();
                          },
                          title: "Add User",
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
                  myData: registeredusers.data,
                  count: registeredusers.data!.length,
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
    ),
  );
}

class RowSource extends DataTableSource {
  var myData;
  final count;
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

DataRow recentFileDataRow(RegData data, context, index) {
  return DataRow(
    cells: [
      DataCell(Align(
        alignment: Alignment.center,
        child: Image.asset("assets/images/albert.png", height: 30),
      )),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.userName.toString()))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Text("${data.firstName} ${data.lastName}"))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Text(data.contactNumber.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.email.toString()))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Text(
            Roles.values.elementAt(data.roleType!).name,
          ))),
      DataCell(Align(
          alignment: Alignment.center,
          child: _buildactions(context, data, index))),
    ],
  );
}

_buildactions(context, data, index) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      InkWell(
          onTap: () {
            // debugPrint(registeredUserModel.data?.elementAt(index).userName);
            debugPrint("pressed $index");
            String email = registeredusers.data!.elementAt(index).email!;
            int roleIndex = registeredusers.data!.elementAt(index).roleType!;
            String role = Roles.values.elementAt(roleIndex).name;
            buildPinAlert(context, email: email, role: role);
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

buildPinAlert(context, {required String email, required String role}) {
  roleTextEditingController.text = role;
  useremailTextEditingController.text = email;
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
                              textEditingController:
                                  useremailTextEditingController,
                              hintText: "",
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
                          child: TextInputField(
                              textEditingController: roleTextEditingController,
                              hintText: "",
                              validatorText: ""))
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
        );
      },
    ),
  );
}

buildPinShowData(context) {
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Name :",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(width: 2),
                      Text("Raj Shinde")
                    ],
                  ),
                  SizedBox(height: 15),
                  Divider(
                    height: 5,
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Subject :",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(width: 2),
                      Text("Lorem ipsum dolar (Optional)")
                    ],
                  ),
                  SizedBox(height: 15),
                  Divider(
                    height: 5,
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  SizedBox(height: 25),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
                        Text(
                            "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,"),
                        Text(
                            "when an unknown printer took a galley of type and scrambled it to make a type"),
                        Text("specimen book.")
                      ]),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
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
                          child: const Text('Send'),
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
    fullname: 'Raj Shinde',
    phonenumber: '9987171941',
    email: 'rajshinde06@gmail.com',
    role: 'Agronomist',
    action: '24524',
  ),
  Data(
    profile: "2",
    username: 'pankaj',
    fullname: 'pankaj Gupta',
    phonenumber: '9821667219',
    email: 'pankajgipta@gmail.com',
    role: 'Landholder',
    action: '`52435`',
  ),
  Data(
    profile: "3",
    username: 'Kishan',
    fullname: 'Kishan Bhuta',
    phonenumber: '9835654981',
    email: 'kishbhutaa@gmial.com',
    role: 'Farmer',
    action: '245245',
  ),
  Data(
    profile: "4",
    username: 'Dhurmil',
    fullname: 'Dhurmil Shah',
    phonenumber: '9767485497',
    email: 'dhurshah@gmail.com',
    role: 'Farmer',
    action: '245245',
  ),
  Data(
    profile: "5",
    username: 'Pooja',
    fullname: 'pooja tambe',
    phonenumber: '8828291148',
    email: 'tambepoo@gmail.com',
    role: 'Manager',
    action: '245245',
  ),
  Data(
    profile: "6",
    username: 'Jothi',
    fullname: 'Jyoti Shetty',
    phonenumber: '9147624864',
    email: 'jyotty@gmail.com',
    role: 'Manager',
    action: '24524',
  ),
  Data(
    profile: "7",
    username: 'Salman',
    fullname: 'Salman Khan',
    phonenumber: '9870368665',
    email: 'Salmannkhann786@gmail.com',
    role: 'Farmer',
    action: '13435',
  ),
  Data(
    profile: "8",
    username: 'Chetan',
    fullname: 'Chetan Jadhav',
    phonenumber: '9826458246',
    email: 'chetan245@gmail.com',
    role: 'Agronomist',
    action: '65979',
  ),
  Data(
    profile: "9",
    username: 'Sandeep',
    fullname: 'Sandeep Vishwakarma',
    phonenumber: '8865455892',
    email: 'sandeep23@gmail.com',
    role: 'landholder',
    action: '69659',
  ),
  Data(
    profile: "11",
    username: 'Uzer',
    fullname: 'Uzer Malik',
    phonenumber: '8820682321',
    email: 'uzer654@gmail.com',
    role: 'Farmer',
    action: '67947',
  ),
  Data(
    profile: "11",
    username: 'Uzer',
    fullname: 'Uzer Malik',
    phonenumber: '8820682321',
    email: 'uzer654@gmail.com',
    role: 'Farmer',
    action: '67947',
  ),
  Data(
    profile: "12",
    username: 'Maussafar',
    fullname: 'Maussafar Sidddique',
    phonenumber: '9965363186',
    email: 'mussafar@gmail.com',
    role: 'Landlord',
    action: '6479467',
  ),
  Data(
    profile: "13",
    username: 'Mamta',
    fullname: 'Mamta Vaishnav',
    phonenumber: '9847524724',
    email: 'amvy29@gmail.com',
    role: 'manageer',
    action: '658365',
  ),
  Data(
    profile: "14",
    username: 'Pooja',
    fullname: 'pooja tambe',
    phonenumber: '8828291148',
    email: 'tambepoo@gmail.com',
    role: 'Landlord',
    action: '5686',
  ),
  Data(
    profile: "15",
    username: 'Jyoti',
    fullname: 'Jyoti Shetty',
    phonenumber: '9147624864',
    email: 'jyotty@gmail.com',
    role: 'Manager',
    action: '3477',
  ),
  Data(
    profile: "16",
    username: 'Salman',
    fullname: 'Salman Khan',
    phonenumber: '9870368665',
    email: 'Salmannkhann786@gmail.com',
    role: 'Farmer',
    action: '457',
  ),
  Data(
    profile: "17",
    username: 'Chetan',
    fullname: 'Chetan Jadhav',
    phonenumber: '9826458246',
    email: 'chetan245@gmail.com',
    role: 'Agronomist',
    action: '45725',
  ),
  Data(
    profile: "9",
    username: 'Sandeep',
    fullname: 'Sandeep Vishwakarma',
    phonenumber: '8865455892',
    email: 'sandeep23@gmail.com',
    role: 'landholder',
    action: '69659',
  ),
  Data(
    profile: "10",
    username: 'Reethik',
    fullname: 'Reethik Bhuta',
    phonenumber: '9870456298',
    email: 'reethikb@gmail.com',
    role: 'Farmer',
    action: '694689',
  ),
];

datatablerequest(screenSize, BuildContext context) {
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
                  myDataRequest: notregisteredusers.data,
                  count: notregisteredusers.data!.length,
                  context: context),
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
                          "Status",
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

DataRow recentFileDataRowrequest(NotRegData data, context, index) {
  return DataRow(
    cells: [
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.email.toString()))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Text(
            Roles.values.elementAt(data.roleType!).name,
          ))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.isVeify.toString()))),
      DataCell(Align(
          alignment: Alignment.center,
          child: _buildactionsrequest(context, index))),
    ],
  );
}

_buildactionsrequest(context, index) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      InkWell(
          onTap: () => buildPinShowData(context),
          child: Image.asset("assets/images/bell.png", height: 30)),
      InkWell(
          onTap: () {
            print("pressed");
            String email = notregisteredusers.data!.elementAt(index).email!;
            int roleIndex = notregisteredusers.data!.elementAt(index).roleType!;
            String role = Roles.values.elementAt(roleIndex).name;
            buildPinAlert(context, email: email, role: role);
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

class DataRequest {
  String? profile;
  String? username;
  String? fullname;
  String? phonenumber;
  String? email;
  String? role;
  String? action;

  DataRequest({
    required this.profile,
    required this.username,
    required this.fullname,
    required this.phonenumber,
    required this.email,
    required this.role,
    required this.action,
  });
}

List<Data> myDataRequest = [
  Data(
    profile: "1",
    username: 'Raj',
    fullname: 'Raj Shinde',
    phonenumber: '9987171941',
    email: 'rajshinde06@gmail.com',
    role: 'Agronomist',
    action: '24524',
  ),
  Data(
    profile: "2",
    username: 'pankaj',
    fullname: 'pankaj Gupta',
    phonenumber: '9821667219',
    email: 'pankajgipta@gmail.com',
    role: 'Landholder',
    action: '`52435`',
  ),
  Data(
    profile: "3",
    username: 'Kishan',
    fullname: 'Kishan Bhuta',
    phonenumber: '9835654981',
    email: 'kishbhutaa@gmial.com',
    role: 'Farmer',
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

class AlterDialogss extends StatefulWidget {
  const AlterDialogss({Key? key}) : super(key: key);

  @override
  State<AlterDialogss> createState() => _AlterDialogssState();
}

class _AlterDialogssState extends State<AlterDialogss> {
  _buildDialog() {
    print("reached here");
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
