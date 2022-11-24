import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:get/get.dart';

import '../../component/custom_Elevated_Button.dart';
import '../../component/text_Input_field.dart';

class TableViewCrop extends StatefulWidget {
  const TableViewCrop({Key? key}) : super(key: key);

  @override
  State<TableViewCrop> createState() => _TableViewCropState();
}

class _TableViewCropState extends State<TableViewCrop> {
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

  late String _selectedValue;
  List<String> listOfValue = [
    'Week 1',
    'Week 2',
    'Week 3',
    'Week 4',
  ];
  buildPin() {
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
                          "Add New Crop program",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Crop",
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
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Yield Per Hectare",
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
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "plant Population",
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
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Week",
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
                            title: "Add",
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      InkWell(
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () => Get.back(),
                          child: const Icon(Icons.arrow_back_ios)),
                      const Text(
                        'Select A Crop Program',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Row(
                        children: [
                          InkWell(
                            hoverColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () => Get.toNamed('/grid_view_crop'),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xffF7F9EA),
                                border: Border.all(
                                  color: const Color(0xff327C04),
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 3),
                                child: Text(
                                  'Grid',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff327C04),
                                border: Border.all(
                                  color: const Color(0xff327C04),
                                ),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 3),
                                child: Text(
                                  'Table',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF327C04),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 9),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.add,
                                color: Color(0xffffffff),
                                size: 20,
                              ),
                              const SizedBox(width: 6),
                              InkWell(
                                onTap: () {
                                  buildPin();
                                },
                                child: const Text(
                                  'Add',
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xffffffff)),
                                ),
                              )
                            ],
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
                                myData = filterData!
                                    .where(
                                      (element) =>
                                          element.name!.toLowerCase().contains(
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
                              color: const Color(0xff327C04).withOpacity(0.11),
                            ),
                            itemSize: 25,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xff000000),
                            ),
                            prefixInsets: const EdgeInsetsDirectional.fromSTEB(
                                10, 8, 0, 8),
                            placeholder: 'Search Celeb....',
                            suffixInsets: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 15, 2),
                            placeholderStyle: TextStyle(
                              fontSize: 16,
                              color: const Color(0xff000000).withOpacity(0.38),
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
          ),
          const SizedBox(height: 20),
          const Divider(
            height: 5,
            color: Colors.grey,
            thickness: 1,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
            child: Column(
              children: [
                datatable(),
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
                              "Id",
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
                              "Plant Population",
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
                              "Yield Per Hectares",
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
                              "Weeks",
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
          Align(alignment: Alignment.center, child: Text(data.id.toString()))),
      DataCell(
          Align(alignment: Alignment.center, child: Text(data.name ?? "Name"))),
      DataCell(
          Align(alignment: Alignment.center, child: Text(data.pp.toString()))),
      DataCell(
          Align(alignment: Alignment.center, child: Text(data.yph.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.weeks.toString()))),
      DataCell(Align(alignment: Alignment.center, child: data.action)),
    ],
  );
}

class Data {
  String? id;
  String? name;
  String? pp;
  String? yph;
  String? weeks;
  Widget? action;

  Data({
    required this.id,
    required this.name,
    required this.pp,
    required this.yph,
    required this.weeks,
    required this.action,
  });
}

List<Data> myData = [
  Data(
    id: '1',
    name: "Buffer",
    pp: '4BL01',
    yph: 'Chemical',
    weeks: 'Bladbuff - ml',
    action: Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => Get.toNamed('/view_details'),
            child: const Icon(
              Icons.remove_red_eye_outlined,
              color: Color(0xff000000),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              Alert(context) {
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
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500),
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
                                              MaterialStateProperty.all(
                                                  Colors.white),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
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
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(
                                              const Color(0xFF327C04),
                                            ),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
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
            },
            child: const Icon(
              Icons.delete_outlined,
              color: Color(0xff000000),
            ),
          ),
        ),
      ],
    ),
  ),
  Data(
    id: '2',
    name: "Buffer",
    pp: '4BL01',
    yph: 'Chemical',
    weeks: 'Bladbuff - ml',
    action: Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => Get.toNamed('/view_details'),
            child: const Icon(
              Icons.remove_red_eye_outlined,
              color: Color(0xff000000),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {},
            child: const Icon(
              Icons.delete_outlined,
              color: Color(0xff000000),
            ),
          ),
        ),
      ],
    ),
  ),
  Data(
    id: '3',
    name: "Buffer",
    pp: '4BL01',
    yph: 'Chemical',
    weeks: 'Bladbuff - ml',
    action: Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => Get.toNamed('/view_details'),
            child: const Icon(
              Icons.remove_red_eye_outlined,
              color: Color(0xff000000),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {},
            child: const Icon(
              Icons.delete_outlined,
              color: Color(0xff000000),
            ),
          ),
        ),
      ],
    ),
  ),
  Data(
    id: '4',
    name: "Buffer",
    pp: '4BL01',
    yph: 'Chemical',
    weeks: 'Bladbuff - ml',
    action: Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => Get.toNamed('/view_details'),
            child: const Icon(
              Icons.remove_red_eye_outlined,
              color: Color(0xff000000),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {},
            child: const Icon(
              Icons.delete_outlined,
              color: Color(0xff000000),
            ),
          ),
        ),
      ],
    ),
  ),
  Data(
    id: '5',
    name: "Buffer",
    pp: '4BL01',
    yph: 'Chemical',
    weeks: 'Bladbuff - ml',
    action: Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => Get.toNamed('/view_details'),
            child: const Icon(
              Icons.remove_red_eye_outlined,
              color: Color(0xff000000),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {},
            child: const Icon(
              Icons.delete_outlined,
              color: Color(0xff000000),
            ),
          ),
        ),
      ],
    ),
  ),
  Data(
    id: '6',
    name: "Buffer",
    pp: '4BL01',
    yph: 'Chemical',
    weeks: 'Bladbuff - ml',
    action: Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => Get.toNamed('/view_details'),
            child: const Icon(
              Icons.remove_red_eye_outlined,
              color: Color(0xff000000),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {},
            child: const Icon(
              Icons.delete_outlined,
              color: Color(0xff000000),
            ),
          ),
        ),
      ],
    ),
  ),
  Data(
    id: '7',
    name: "Buffer",
    pp: '4BL01',
    yph: 'Chemical',
    weeks: 'Bladbuff - ml',
    action: Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => Get.toNamed('/view_details'),
            child: const Icon(
              Icons.remove_red_eye_outlined,
              color: Color(0xff000000),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {},
            child: const Icon(
              Icons.delete_outlined,
              color: Color(0xff000000),
            ),
          ),
        ),
      ],
    ),
  ),
  Data(
    id: '8',
    name: "Buffer",
    pp: '4BL01',
    yph: 'Chemical',
    weeks: 'Bladbuff - ml',
    action: Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => Get.toNamed('/view_details'),
            child: const Icon(
              Icons.remove_red_eye_outlined,
              color: Color(0xff000000),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {},
            child: const Icon(
              Icons.delete_outlined,
              color: Color(0xff000000),
            ),
          ),
        ),
      ],
    ),
  ),
  Data(
    id: '9',
    name: "Buffer",
    pp: '4BL01',
    yph: 'Chemical',
    weeks: 'Bladbuff - ml',
    action: Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => Get.toNamed('/view_details'),
            child: const Icon(
              Icons.remove_red_eye_outlined,
              color: Color(0xff000000),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {},
            child: const Icon(
              Icons.delete_outlined,
              color: Color(0xff000000),
            ),
          ),
        ),
      ],
    ),
  ),
  Data(
    id: '8',
    name: "Buffer",
    pp: '4BL01',
    yph: 'Chemical',
    weeks: 'Bladbuff - ml',
    action: Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => Get.toNamed('/view_details'),
            child: const Icon(
              Icons.remove_red_eye_outlined,
              color: Color(0xff000000),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {},
            child: const Icon(
              Icons.delete_outlined,
              color: Color(0xff000000),
            ),
          ),
        ),
      ],
    ),
  ),
];