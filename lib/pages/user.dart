import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/dropdown_btn.dart';
import 'package:flutter_agro_new/component/services/constants.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:flutter_agro_new/main.dart';
import 'package:flutter_agro_new/models/not_registered_user_model.dart';
import 'package:flutter_agro_new/models/registered_users_model.dart';
import 'package:flutter_agro_new/pages/popup.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../component/custom_Elevated_Button.dart';
import '../component/text_Input_field.dart';

final StreamController<bool> _requestuserrefresh = StreamController.broadcast();
late RegisteredUserModel registeredusers;
late NotRegisteredUserModel notregisteredusers;
final email = TextEditingController();
TextEditingController controller = TextEditingController();
final useremailTextEditingController = TextEditingController();
final roleTextEditingController = TextEditingController();
final firstNameTextEditingController = TextEditingController();
final lastNameTextEditingController = TextEditingController();
final phoneTextEditingController = TextEditingController();
// final email = TextEditingController();
String role = 'Admin';
int roleIndex = 0;
int id = 0;
int no = 0;
final GlobalKey<FormState> _form = GlobalKey<FormState>();

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
    // _requestuserrefresh.add(true);

    return "null";
  } else {
    return 'throw (Exception("Search Error"))';
  }
}

Future<String> updateUser(id, roleIndex) async {
  debugPrint("reached");
  Map<String, String> updata = {
    "first_name": firstNameTextEditingController.text.toString(),
    "last_name": lastNameTextEditingController.text.toString(),
    "user_id": id,
    "phone": phoneTextEditingController.text.toString(),
    "role_type": roleIndex
  };
  return await updateUserAPI(updata);
}

Future<String> updateUserAPI(Map<String, String> updata) async {
  final _chuckerHttpClient = await http.Client();

  final prefs = await SharedPreferences.getInstance();
  http.Response response = await _chuckerHttpClient.post(
    Uri.parse("https://agromate.website/laravel/api/update_user"),
    body: updata,
  );

  if (response.statusCode == 200) {
    print("update api response is ${response.body}");
    return 'null';
  } else {
    return 'throw (Exception("Search Error"))';
  }
}

Future<String> resendMail(id) async {
  debugPrint("reached");
  Map<String, String> updata = {"user_id": id};
  return await resendMailAPI(updata);
}

Future<String> resendMailAPI(Map<String, String> updata) async {
  final _chuckerHttpClient = await http.Client();
  print(updata);
  final prefs = await SharedPreferences.getInstance();
  http.Response response = await _chuckerHttpClient.post(
    Uri.parse("https://agromate.website/laravel/api/user_remainder_mail"),
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

Future<int> deleteApi(int id) async {
  final http.Response response = await http.get(
    Uri.parse('https://agromate.website/laravel/api/user_delete/$id'),
  );
  return response.statusCode;
}

class _UserState extends State<User> {
  @override
  void initState() {
    // filterData = modes.data!;
    //fetchNotRegisteredUsers();
    fetchRegisteredUsers();
    super.initState();
  }

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
                                    setState(() {
                                      myDataRequest = registeredusers.data!
                                          .where(
                                            (element) => element.email!
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
                        StreamBuilder<bool>(
                            stream: _requestuserrefresh.stream,
                            builder: (context, snapshot) {
                              return FutureBuilder<NotRegisteredUserModel>(
                                future: fetchNotRegisteredUsers(),
                                builder: (ctx, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasData) {
                                      debugPrint(snapshot.data.toString());
                                      return _buildrequesttable(
                                          screenSize, context);
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
                              );
                            }),
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
  email.clear();

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
                            width: 300,
                            child: TextInputField(
                                textEditingController: email,
                                validator: (value) {
                                  if (value != null && value.isEmpty) {
                                    return "Please Enter Email";
                                  }
                                  return null;
                                },
                                hintText: "Email",
                                validatorText: "Please Enter Email"))
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
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
                              final isValid = _form.currentState?.validate();
                              if (isValid!) {
                                print(email);
                                print(roleIndex);

                                addUser();
                                _requestuserrefresh.add(true);
                                // fetchNotRegisteredUsers();
                                Navigator.pop(context);
                                // Navigator.popAndPushNamed(context, "/user");
                                Flushbar(
                                  duration: const Duration(seconds: 2),
                                  message: "New User Added Successfully",
                                ).show(context);
                              } else {
                                Flushbar(
                                  duration: const Duration(seconds: 2),
                                  message: "Please Enter Email and Role",
                                ).show(context);
                              }
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
          ),
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
                  myData: myDataRequest,
                  count: myDataRequest.length,
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

DataRow recentFileDataRow(RegData data, context, int index) {
  int no = index + 1;
  return DataRow(
    cells: [
      DataCell(Align(alignment: Alignment.center, child: Text(no.toString()))),
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
            String firstname =
                registeredusers.data!.elementAt(index).firstName!;
            String lastname = registeredusers.data!.elementAt(index).lastName!;
            String phone =
                registeredusers.data!.elementAt(index).contactNumber!;
            String role =
                registeredusers.data!.elementAt(index).roleType.toString();
            debugPrint(role);
            buildPinAlert(context,
                firstname: firstname,
                lastname: lastname,
                phone: phone,
                role: role,
                id: registeredusers.data!.elementAt(index).id!);
          },
          child: Image.asset("assets/images/edit.png", height: 30)),
      InkWell(
          onTap: () {
            int id = registeredusers.data!.elementAt(index).id!;
            debugPrint(id.toString());
            customAlert(context, id);
          },
          child: Image.asset("assets/images/delete.png", height: 30)),
    ],
  );
}

buildPinAlert(context,
    {required String firstname,
    required String lastname,
    required String phone,
    required String role,
    int? id}) {
  firstNameTextEditingController.text = firstname;
  lastNameTextEditingController.text = lastname;
  phoneTextEditingController.text = phone;
  roleTextEditingController.text = role;
  debugPrint(role);
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
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Enter First Name",
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
                                      firstNameTextEditingController,
                                  hintText: "",
                                  validatorText: ""))
                        ],
                      ),
                      SizedBox(width: 18),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Enter Last Name",
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
                                      lastNameTextEditingController,
                                  hintText: "",
                                  validatorText: ""))
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
                            "Phone Number",
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
                                      phoneTextEditingController,
                                  hintText: "",
                                  validatorText: ""))
                        ],
                      ),
                      SizedBox(width: 18),
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
                            child: DropdownBtn(
                              items: Roles.values.map((e) => e.name).toList(),
                              hint:
                                  Roles.values.elementAt(int.parse(role)).name,
                              onItemSelected: (value) {
                                debugPrint(value);
                                roleTextEditingController.text = Roles.values
                                    .singleWhere(
                                        (element) => element.name == value)
                                    .index
                                    .toString();
                                debugPrint(
                                    roleTextEditingController.toString());
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
                            debugPrint(
                                firstNameTextEditingController.text.toString());
                            debugPrint(
                                lastNameTextEditingController.text.toString());
                            debugPrint(
                                phoneTextEditingController.text.toString());
                            debugPrint(
                                roleTextEditingController.text.toString());
                            setState(() {
                              updateUser(id.toString(),
                                      roleTextEditingController.text.toString())
                                  .then((value) =>
                                      Navigator.pushNamed(context, '/user'));
                            });
                            // updateUser(id.toString());
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
          ],
        );
      },
    ),
  );
}

buildPinShowData(context, id) {
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
                  Text("Resend Mail"),
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
                          onPressed: () {
                            debugPrint("separation");
                            debugPrint(id.toString());
                            resendMail(id.toString());
                            Navigator.pop(context);
                          },
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
                              deleteApi(id).then((value) =>
                                  Navigator.pushNamed(context, '/user'));
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
                  myDataRequest: secondTabResult,
                  count: secondTabResult.length,
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

DataRow recentFileDataRowrequest(NotRegData data, context, int index) {
  int no = index + 1;

  return DataRow(
    cells: [
      DataCell(Align(alignment: Alignment.center, child: Text(no.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.email.toString()))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Text(
            Roles.values.elementAt(data.roleType!).name,
          ))),
      const DataCell(
          Align(alignment: Alignment.center, child: Text("Not Registered"))),
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
          onTap: () {
            int id = notregisteredusers.data!.elementAt(index).id!;

            buildPinShowData(context, id);
          },
          child: Image.asset("assets/images/bell.png", height: 30)),
      // InkWell(
      //     onTap: () {
      //       print("pressed");
      //       String email = notregisteredusers.data!.elementAt(index).email!;
      //       int roleIndex = notregisteredusers.data!.elementAt(index).roleType!;
      //       String role = Roles.values.elementAt(roleIndex).name;
      //       buildPinAlert(context, email: email, role: role);
      //     },
      //     child: Image.asset("assets/images/edit.png", height: 30)),
      // InkWell(
      //     onTap: () {
      //       print("pressed");
      //       customAlert(context);
      //     },
      //     child: Image.asset("assets/images/delete.png", height: 30)),
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

List<RegData> myDataRequest = registeredusers.data!;
List<NotRegData> secondTabResult = notregisteredusers.data!;

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
