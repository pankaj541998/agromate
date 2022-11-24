import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../component/top_bar.dart';

class CropPlan extends StatefulWidget {
  const CropPlan({Key? key}) : super(key: key);

  @override
  State<CropPlan> createState() => _CropPlanState();
}

class _CropPlanState extends State<CropPlan> {
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

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(height: 30),
            TopBar(),
            const SizedBox(height: 30),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: const Text(
                          'Crop Plans',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () => Get.toNamed('/add_crop_plan'),
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
                  const SizedBox(height: 30),
                  datatable(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
                sortAscending: sort,
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
                            "Irrigation Type",
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
                            "Catlivr",
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
                            "Start date",
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
                            "End date",
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
                            "Area",
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
                            "Expected Yield",
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
                            "AC",
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
          alignment: Alignment.center, child: Text(data.phone.toString()))),
      DataCell(
          Align(alignment: Alignment.center, child: Text(data.age.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.crop.toString()))),
      DataCell(
          Align(alignment: Alignment.center, child: Text(data.it.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.catlivr.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.startDate.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.endDate.toString()))),
      DataCell(Align(
          alignment: Alignment.center, child: Text(data.area.toString()))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Text(data.expectedYield.toString()))),
      DataCell(
          Align(alignment: Alignment.center, child: Text(data.ac.toString()))),
    ],
  );
}

class Data {
  String? name;
  String? phone;
  String? age;
  String? crop;
  String? it;
  String? catlivr;
  String? startDate;
  String? endDate;
  String? area;
  String? expectedYield;
  String? ac;

  Data({
    required this.name,
    required this.phone,
    required this.age,
    required this.crop,
    required this.it,
    required this.catlivr,
    required this.startDate,
    required this.endDate,
    required this.area,
    required this.expectedYield,
    required this.ac,
  });
}

List<Data> myData = [
  Data(
    name: "VARKPLAAS",
    phone: 'A',
    age: 'A1A',
    crop: 'Carrots',
    it: 'Pivot',
    catlivr: 'Laguna',
    startDate: '5/30/2022',
    endDate: '5/30/2022',
    area: '3',
    expectedYield: '35000',
    ac: '',
  ),
  Data(
    name: "David",
    phone: '6464646',
    age: '30',
    crop: 'tet1',
    it: 'tests1',
    catlivr: 'Laguna',
    startDate: '5/30/2022',
    endDate: '5/30/2022',
    area: '3',
    expectedYield: 'gfus',
    ac: '',
  ),
  Data(
    name: "Kamal",
    phone: '8888',
    age: '32',
    crop: 'tet1',
    it: 'tests1',
    catlivr: 'Laguna',
    startDate: '5/30/2022',
    endDate: '5/30/2022',
    area: '3',
    expectedYield: 'gfus',
    ac: '',
  ),
  Data(
    name: "Ali",
    phone: '3333333',
    age: '33',
    crop: 'tet1',
    it: 'tests1',
    catlivr: 'Laguna',
    startDate: '5/30/2022',
    endDate: '5/30/2022',
    area: '3',
    expectedYield: 'gfus',
    ac: '',
  ),
  Data(
    name: "Muzal",
    phone: '987654556',
    age: '23',
    crop: 'tet1',
    it: 'tests1',
    catlivr: 'Laguna',
    startDate: '5/30/2022',
    endDate: '5/30/2022',
    area: '3',
    expectedYield: 'gfus',
    ac: '',
  ),
  Data(
    name: "Taimu",
    phone: '46464664',
    age: '24',
    crop: 'tet1',
    it: 'tests1',
    catlivr: 'Laguna',
    startDate: '5/30/2022',
    endDate: '5/30/2022',
    area: '3',
    expectedYield: 'gfus',
    ac: '',
  ),
  Data(
    name: "Mehdi",
    phone: '5353535',
    age: '36',
    crop: 'tet1',
    it: 'tests1',
    catlivr: 'Laguna',
    startDate: '5/30/2022',
    endDate: '5/30/2022',
    area: '3',
    expectedYield: 'gfus',
    ac: '',
  ),
  Data(
    name: "Rex",
    phone: '244242',
    age: '38',
    crop: 'tet1',
    it: 'tests1',
    catlivr: 'Laguna',
    startDate: '5/30/2022',
    endDate: '5/30/2022',
    area: '3',
    expectedYield: 'gfus',
    ac: '',
  ),
  Data(
    name: "Alex",
    phone: '323232323',
    age: '29',
    crop: 'tet1',
    it: 'tests1',
    catlivr: 'Laguna',
    startDate: '5/30/2022',
    endDate: '5/30/2022',
    area: '3',
    expectedYield: 'gfus',
    ac: '',
  ),
  Data(
    name: "Alex",
    phone: '323232323',
    age: '29',
    crop: 'tet1',
    it: 'tests1',
    catlivr: 'Laguna',
    startDate: '5/30/2022',
    endDate: '5/30/2022',
    area: '3',
    expectedYield: 'gfus',
    ac: '',
  ),
  Data(
    name: "Alex",
    phone: '323232323',
    age: '29',
    crop: 'tet1',
    it: 'tests1',
    catlivr: 'Laguna',
    startDate: '5/30/2022',
    endDate: '5/30/2022',
    area: '3',
    expectedYield: 'gfus',
    ac: '',
  ),
  Data(
    name: "Alex",
    phone: '323232323',
    age: '29',
    crop: 'tet1',
    it: 'tests1',
    catlivr: 'Laguna',
    startDate: '5/30/2022',
    endDate: '5/30/2022',
    area: '3',
    expectedYield: 'gfus',
    ac: '',
  ),
  Data(
    name: "Alex",
    phone: '323232323',
    age: '29',
    crop: 'tet1',
    it: 'tests1',
    catlivr: 'Laguna',
    startDate: '5/30/2022',
    endDate: '5/30/2022',
    area: '3',
    expectedYield: 'gfus',
    ac: '',
  ),
  Data(
    name: "Alex",
    phone: '323232323',
    age: '29',
    crop: 'tet1',
    it: 'tests1',
    catlivr: 'Laguna',
    startDate: '5/30/2022',
    endDate: '5/30/2022',
    area: '3',
    expectedYield: 'gfus',
    ac: '',
  ),
  Data(
    name: "Alex",
    phone: '323232323',
    age: '29',
    crop: 'tet1',
    it: 'tests1',
    catlivr: 'Laguna',
    startDate: '5/30/2022',
    endDate: '5/30/2022',
    area: '3',
    expectedYield: 'gfus',
    ac: '',
  ),
  Data(
    name: "Alex",
    phone: '323232323',
    age: '29',
    crop: 'tet1',
    it: 'tests1',
    catlivr: 'Laguna',
    startDate: '5/30/2022',
    endDate: '5/30/2022',
    area: '3',
    expectedYield: 'gfus',
    ac: '',
  ),
  Data(
    name: "Alex",
    phone: '323232323',
    age: '29',
    crop: 'tet1',
    it: 'tests1',
    catlivr: 'Laguna',
    startDate: '5/30/2022',
    endDate: '5/30/2022',
    area: '3',
    expectedYield: 'gfus',
    ac: '',
  ),
  Data(
    name: "Alex",
    phone: '323232323',
    age: '29',
    crop: 'tet1',
    it: 'tests1',
    catlivr: 'Laguna',
    startDate: '5/30/2022',
    endDate: '5/30/2022',
    area: '3',
    expectedYield: 'gfus',
    ac: '',
  ),
  Data(
    name: "Alex",
    phone: '323232323',
    age: '29',
    crop: 'tet1',
    it: 'tests1',
    catlivr: 'Laguna',
    startDate: '5/30/2022',
    endDate: '5/30/2022',
    area: '3',
    expectedYield: 'gfus',
    ac: '',
  ),
];
