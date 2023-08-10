import 'package:flutter/material.dart';
import 'package:frontend/Constants/api.dart';
import 'package:pie_chart/pie_chart.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({super.key});
  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  final colorList = <Color>[Colors.lightBlueAccent, Colors.pinkAccent.shade100];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 25,
                  ),
                  Center(
                      child: Text(
                    'Pie Chart',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  )),
                  SizedBox(height: 100),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: [
                                Container(
                                  width: 7,
                                  height: 7,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.pinkAccent.shade100),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text("Done")
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 7,
                                  height: 7,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.lightBlueAccent.shade400),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text("Incomplete")
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: LayoutBuilder(
                          builder: (context, Constraints) => Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                // color: Color.fromRGBO(193, 214, 233, 1),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: -10,
                                    blurRadius: 17,
                                    offset: Offset(-5, -5),
                                    color: Colors.grey.shade50,
                                  ), // BoxShadow

                                  BoxShadow(
                                    spreadRadius: -2,
                                    blurRadius: 10,
                                    offset: Offset(7, 7),
                                    color: Color.fromRGBO(146, 182, 216, 1),
                                  )
                                ],
                              ),
                              child: PieChart(
                                dataMap: {
                                  // "1": 2, "2": 0
                                  "Done": lengthdone.toDouble(),
                                  "Incomplete": lengthincomp.toDouble()
                                },
                                colorList: colorList,
                                chartRadius: 200,
                                legendOptions:
                                    LegendOptions(showLegends: false),
                                chartValuesOptions: ChartValuesOptions(
                                    showChartValuesInPercentage: true,
                                    chartValueBackgroundColor:
                                        Colors.transparent),
                                animationDuration: const Duration(seconds: 2),
                              )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
