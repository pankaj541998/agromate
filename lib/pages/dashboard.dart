import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:timelines/timelines.dart';

import '../test.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => DashBoardState();
}

class DashBoardState extends State<DashBoard> {
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
                  children: const [
                    Text(
                      'Dashboard',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff000000),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 4),
                              color: Color.fromARGB(24, 0, 0, 0),
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Overdue Tasks',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffE64848),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                114, 230, 72, 72),
                                            spreadRadius: 2,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Align(
                                        child: SvgPicture.asset(
                                          '/images/task_list.svg',
                                          width: 30,
                                          height: 33,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    const Text(
                                      '45',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xff000000),
                                          fontFamily: 'Poppins'),
                                    ),
                                    const Text(
                                      'Tasks Completed',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff000000),
                                          fontFamily: 'Poppins'),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            Transform.rotate(
                                              angle: -20.4,
                                              child: const Icon(
                                                Icons.arrow_right_alt_rounded,
                                                color: Color(0xffA1B809),
                                              ),
                                            ),
                                            const Text(
                                              '50%',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xffA1B809),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(width: 10),
                                        const Text(
                                          'Since last week',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff000000),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            decoration: const BoxDecoration(
                                              color: Color(0xffE0F0DB),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                child: Row(
                                                  children: const [
                                                    Text(
                                                      '14 Oct 2022-15 Nov 2022',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        color:
                                                            Color(0xff000000),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5.0),
                                                      child: Icon(
                                                        Icons
                                                            .calendar_today_outlined,
                                                        size: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: InkWell(
                                              onTap: () {},
                                              child: const Text(
                                                'View all',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xff000000),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 4),
                              color: Color.fromARGB(24, 0, 0, 0),
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Crop Plans',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'View all',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: const DougnutChart(),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 25,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              left: BorderSide(
                                                color: Color(0xff327c04),
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                          child: const Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.0),
                                            child: Text(
                                              '20 Hec Cabbage',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Container(
                                          height: 20,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              left: BorderSide(
                                                color: Color(0xff548a4d),
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                          child: const Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.0),
                                            child: Text(
                                              '20 Hec Cabbage',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Container(
                                          height: 20,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              left: BorderSide(
                                                color: Color(0xff87aa7d),
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                          child: const Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.0),
                                            child: Text(
                                              '20 Hec Cabbage',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Container(
                                          height: 20,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              left: BorderSide(
                                                color: Color(0xffc0d3b6),
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                          child: const Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.0),
                                            child: Text(
                                              '20 Hec Cabbage',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Container(
                                          height: 20,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              left: BorderSide(
                                                color: Color(0xffe0f0db),
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                          child: const Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.0),
                                            child: Text(
                                              '20 Hec Cabbage',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 4),
                              color: Color.fromARGB(24, 0, 0, 0),
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Daily Activity',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff000000),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Stack(
                                clipBehavior: Clip.hardEdge,
                                children: [
                                  Positioned(
                                    left: 6.5,
                                    top: 0,
                                    child: SizedBox(
                                      height: screenSize.height * 0.16,
                                      child: const DashedLineConnector(
                                        gap: 4,
                                        dash: 4,
                                        space: 0,
                                        thickness: 1,
                                        endIndent: 0,
                                        color: Color(0xff327C04),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: SizedBox(
                                      height: screenSize.height * 0.5,
                                      child: const SolidLineConnector(
                                        color: Color(0xff327C04),
                                        thickness: 3,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 12,
                                                    height: 12,
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xff327C04),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                      left: 8.0,
                                                    ),
                                                    child: Text(
                                                      'Reethik has sent you inventory request',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xff000000),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: SizedBox(
                                                      width: 50,
                                                      child: Divider(
                                                        height: 1,
                                                        color: Colors.grey[300],
                                                      ),
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8.0),
                                                    child: Text(
                                                      '45 Mins ago',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xff000000),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 20.0, top: 8),
                                                child: Text(
                                                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xff000000),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        SizedBox(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 12,
                                                    height: 12,
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xff327C04),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8.0),
                                                    child: Text(
                                                      'Reethik has sent you inventory request',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xff000000),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: SizedBox(
                                                      width: 50,
                                                      child: Divider(
                                                        height: 1,
                                                        color: Colors.grey[300],
                                                      ),
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8.0),
                                                    child: Text(
                                                      '45 Mins ago',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xff000000),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 20.0, top: 8),
                                                child: Text(
                                                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xff000000),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        SizedBox(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 12,
                                                    height: 12,
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xff327C04),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8.0),
                                                    child: Text(
                                                      'Reethik has sent you inventory request',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xff000000),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: SizedBox(
                                                      width: 50,
                                                      child: Divider(
                                                        height: 1,
                                                        color: Colors.grey[300],
                                                      ),
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8.0),
                                                    child: Text(
                                                      '45 Mins ago',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xff000000),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 20.0, top: 8),
                                                child: Text(
                                                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xff000000),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 4),
                              color: Color.fromARGB(24, 0, 0, 0),
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Farm utilization',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                  Text(
                                    'View all',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ],
                              ),
                              const BarChart()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DougnutChart extends StatelessWidget {
  const DougnutChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('David', 1600),
      ChartData('Steve', 120),
      ChartData('Jack', 220),
      ChartData('jain', 250),
      ChartData('Others', 320)
    ];
    return SizedBox(
      height: 210,
      width: 250,
      child: SfCircularChart(
        centerY: '100',
        centerX: '70',
        palette: const <Color>[
          Color(0xffe0f0db),
          Color(0xffc0d3b6),
          Color(0xff87aa7d),
          Color(0xff548a4d),
          Color(0xff327c04),
        ],
        series: <CircularSeries>[
          // Render pie chart
          DoughnutSeries<ChartData, String>(
            dataSource: chartData,
            pointColorMapper: (ChartData data, _) => data.color,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            innerRadius: '60%',
          )
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}

// barchart
class BarChart extends StatefulWidget {
  const BarChart({Key? key}) : super(key: key);

  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  @override
  Widget build(BuildContext context) {
    final List<BarData> barData = [
      BarData('Farm utilization1', 300),
      BarData('Farm utilization2', 400),
      BarData('Farm utilization3', 300),
      BarData('Farm utilization4', 350),
      BarData('Farm utilization5', 180)
    ];
    return SizedBox(
      height: 210,
      width: 250,
      child: SfCartesianChart(
        series: <ChartSeries>[
          BarSeries<BarData, String>(
            dataSource: barData,
            xValueMapper: (BarData data, _) => data.x,
            yValueMapper: (BarData data, _) => data.y,
          )
        ],
        primaryXAxis: CategoryAxis(),
      ),
    );
  }
}

class BarData {
  BarData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}
