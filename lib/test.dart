import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Charts extends StatelessWidget {
  const Charts({Key? key}) : super(key: key);

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
        palette: const <Color>[
          Color(0xffe0f0db),
          Color(0xffc0d3b6),
          Color(0xff87aa7d),
          Color(0xff548a4d),
          Color(0xff327c04),
        ],
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
