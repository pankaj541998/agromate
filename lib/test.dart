import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// class Charts extends StatelessWidget {
//   const Charts({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final List<BarData> barData = [
//       BarData('Farm utilization1', 300),
//       BarData('Farm utilization2', 400),
//       BarData('Farm utilization3', 300),
//       BarData('Farm utilization4', 350),
//       BarData('Farm utilization5', 180)
//     ];
//     return SizedBox(
//       height: 210,
//       width: 250,
//       child: SfCartesianChart(
//         palette: const <Color>[
//           Color(0xffe0f0db),
//           Color(0xffc0d3b6),
//           Color(0xff87aa7d),
//           Color(0xff548a4d),
//           Color(0xff327c04),
//         ],
//         series: <ChartSeries>[
//           BarSeries<BarData, String>(
//             dataSource: barData,
//             xValueMapper: (BarData data, _) => data.x,
//             yValueMapper: (BarData data, _) => data.y,
//           )
//         ],
//         primaryXAxis: CategoryAxis(),
//       ),
//     );
//   }
// }

// class BarData {
//   BarData(this.x, this.y, [this.color]);
//   final String x;
//   final double y;
//   final Color? color;
// }
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getwidget/getwidget.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: GFColors.WHITE,
        appBar: AppBar(
          backgroundColor: GFColors.DARK,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              CupertinoIcons.back,
              color: GFColors.SUCCESS,
            ),
          ),
          title: const Text(
            'Accordion',
            style: TextStyle(fontSize: 17),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 15, top: 30),
              child: GFTypography(
                text: 'Basic Accordion',
                type: GFTypographyType.typo5,
                dividerWidth: 25,
                dividerColor: Color(0xFF19CA4B),
              ),
            ),
            GFAccordion(
                titleBorder: Border(
                  top: BorderSide(
                      color: Colors.black.withOpacity(0.2), width: 0.5),
                  left: BorderSide(
                      color: Colors.black.withOpacity(0.2), width: 0.5),
                  right: BorderSide(
                      color: Colors.black.withOpacity(0.2), width: 0.5),
                  bottom: BorderSide(
                      color: Colors.black.withOpacity(0.2), width: 0.5),
                ),
                contentBorder: Border(
                  top: BorderSide(
                      color: Colors.black.withOpacity(0.2), width: 0.5),
                  bottom: BorderSide(
                      color: Colors.black.withOpacity(0.2), width: 0.5),
                  left: BorderSide(
                      color: Colors.black.withOpacity(0.2), width: 0.5),
                  right: BorderSide(
                      color: Colors.black.withOpacity(0.2), width: 0.5),
                ),
                title: 'GF Accordion',
                content:
                    'GetWidget is an open source library that comes with pre-build 1000+ UI components.'
                    ' The library is built to make flutter development faster and more enjoyable.'),
            const Padding(
              padding: EdgeInsets.only(left: 15, top: 30),
              child: GFTypography(
                text: 'Accordion with Text',
                type: GFTypographyType.typo5,
                dividerWidth: 25,
                dividerColor: Color(0xFF19CA4B),
              ),
            ),
            GFAccordion(
                titleBorder: Border(
                  top: BorderSide(
                      color: Colors.black.withOpacity(0.2), width: 0.5),
                  left: BorderSide(
                      color: Colors.black.withOpacity(0.2), width: 0.5),
                  right: BorderSide(
                      color: Colors.black.withOpacity(0.2), width: 0.5),
                  bottom: BorderSide(
                      color: Colors.black.withOpacity(0.2), width: 0.5),
                ),
                contentBorder: Border(
                  top: BorderSide(
                      color: Colors.black.withOpacity(0.2), width: 0.5),
                  bottom: BorderSide(
                      color: Colors.black.withOpacity(0.2), width: 0.5),
                  left: BorderSide(
                      color: Colors.black.withOpacity(0.2), width: 0.5),
                  right: BorderSide(
                      color: Colors.black.withOpacity(0.2), width: 0.5),
                ),
                title: 'GF Accordion',
                content:
                    'GetWidget is an open source library that comes with pre-build 1000+ UI components.'
                    ' The library is built to make flutter development faster and more enjoyable.',
                collapsedIcon: const Text('Show'),
                expandedIcon: const Text(
                  'Hide',
                  style: TextStyle(color: Colors.red),
                )),
            const Padding(
              padding: EdgeInsets.only(left: 15, top: 30),
              child: GFTypography(
                text: 'Accordion with Icon',
                type: GFTypographyType.typo5,
                dividerWidth: 25,
                dividerColor: Color(0xFF19CA4B),
              ),
            ),
            GFAccordion(
              titleBorder: Border(
                top: BorderSide(
                    color: Colors.black.withOpacity(0.2), width: 0.5),
                left: BorderSide(
                    color: Colors.black.withOpacity(0.2), width: 0.5),
                right: BorderSide(
                    color: Colors.black.withOpacity(0.2), width: 0.5),
                bottom: BorderSide(
                    color: Colors.black.withOpacity(0.2), width: 0.5),
              ),
              contentBorder: Border(
                top: BorderSide(
                    color: Colors.black.withOpacity(0.2), width: 0.5),
                bottom: BorderSide(
                    color: Colors.black.withOpacity(0.2), width: 0.5),
                left: BorderSide(
                    color: Colors.black.withOpacity(0.2), width: 0.5),
                right: BorderSide(
                    color: Colors.black.withOpacity(0.2), width: 0.5),
              ),
              title: 'GF Accordion',
              content:
                  'GetWidget is an open source library that comes with pre-build 1000+ UI components.'
                  ' The library is built to make flutter development faster and more enjoyable.',
              collapsedIcon: Icon(Icons.add_circle_outline),
              expandedIcon: Icon(
                Icons.remove_circle_outline,
                color: Colors.red,
              ),
            ),
          ],
        ),
      );
}

class TestAccordian extends StatefulWidget {
  const TestAccordian({
    Key? key,
  }) : super(key: key);

  @override
  _TestAccordianState createState() => _TestAccordianState();
}

class _TestAccordianState extends State<TestAccordian> {
  // selected's value = 0. For default first item is open.
  int selected = 0; //attention

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ExpansionTile Collapse',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                key: Key('builder ${selected.toString()}'), //attention
                padding: EdgeInsets.only(left: 13.0, right: 13.0, bottom: 25.0),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      Divider(
                        height: 17.0,
                        color: Colors.white,
                      ),
                      ExpansionTile(
                        key: Key(index.toString()), //attention
                        initiallyExpanded: index == selected, //attention

                        leading: Icon(
                          Icons.person,
                          size: 50.0,
                          color: Colors.black,
                        ),
                        title: Text('ExpansionTile ${index}',
                            style: TextStyle(
                                color: Color(0xFF09216B),
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          'Software Engineer',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold),
                        ),
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(25.0),
                            child: Text(
                              'DETAİL ${index} \n' + 'Expanded',
                            ),
                          )
                        ],
                        onExpansionChanged: ((newState) {
                          if (newState)
                            setState(() {
                              Duration(seconds: 20000);
                              selected = index;
                            });
                          else
                            setState(() {
                              selected = -1;
                            });
                        }),
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
