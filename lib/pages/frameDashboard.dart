import 'package:ente/constants/baseAppbar.dart';
import 'package:ente/models/framemodel.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class FrameDashboard extends StatefulWidget {
  final UserFrame frameData;

  const FrameDashboard({Key key, this.frameData}) : super(key: key);
  @override
  _FrameDashboardState createState() => _FrameDashboardState();
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class _FrameDashboardState extends State<FrameDashboard> {
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];
  @override
  Widget build(BuildContext context) {
    final BoxDecoration _boxDecoration = BoxDecoration(
      color: Theme.of(context).primaryColor.withOpacity(.3),
      borderRadius: BorderRadius.circular(
        15.0,
      ),
    );
    return Scaffold(
      appBar: BaseAppBar(
        username: widget.frameData.name,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 700,
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            // parent container housing all other widgets
            child: Column(
              children: [
                Container(
                  height: 30,
                  width: double.infinity,
                  // decoration: _boxDecoration,
                  child: Center(
                      child: Text(
                    '${widget.frameData.name}',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.teal.shade900,
                        fontWeight: FontWeight.bold),
                  )),
                ),
                Container(
                  height: 270,
                  child: Column(
                    children: [
                      // frist container [give it a height, it takes up the width of the parent]
                      Container(
                        height: 100,
                        // decoration: _boxDecoration,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.amber.withOpacity(.7),
                                  borderRadius: BorderRadius.circular(
                                    15.0,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Orders',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '89',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(.7),
                                  borderRadius: BorderRadius.circular(
                                    15.0,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 4),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Customers',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '89',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),

                            // add spacing
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(.7),
                                  borderRadius: BorderRadius.circular(
                                    15.0,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Sales',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '89 %',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // add spacing
                      SizedBox(
                        height: 15,
                      ),

                      // second child of the column [consists of a Row with children]
                      Expanded(
                        child: Row(
                          // row
                          children: [
                            // Container(
                            //   // first child
                            //   width:
                            //       80, // give it a width, it takes up the height of parent since it is wrapped with an expanded widget
                            //   decoration: _boxDecoration,
                            // ),

                            // add spacing
                            // SizedBox(
                            //   // second child
                            //   width: 15,
                            // ),

                            Expanded(
                              // thrid child [consists a column with children ]
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        80, // give it a height, it takes up the width of parent since it is wrapped with an expanded widget
                                    decoration: _boxDecoration,
                                  ),

                                  // add spacing
                                  SizedBox(
                                    // second child
                                    height: 20,
                                  ),

                                  Expanded(
                                    // third child [consists of a row with 3 containsers]
                                    child: Row(
                                      children: [
                                        Expanded(
                                          // first container
                                          child: Container(
                                            decoration: _boxDecoration,
                                            child: Column(
                                              children: [
                                                Icon(Icons.visibility),
                                                Text('products')
                                              ],
                                            ),
                                          ),
                                        ),

                                        // add spacing
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          // second container
                                          child: Container(
                                            decoration: _boxDecoration,
                                            child: Column(
                                              children: [
                                                Icon(Icons.add_outlined),
                                                Text('products')
                                              ],
                                            ),
                                          ),
                                        ),

                                        // add spacing
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          // third container
                                          child: Container(
                                            decoration: _boxDecoration,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: Container(
                    // height: 20,
                    // color: Colors.amber,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        15.0,
                      ),
                    ),
                    child: Column(children: [
                      //Initialize the chart widget
                      SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          // Chart title
                          title: ChartTitle(
                            text: 'Half yearly sales analysis',
                            textStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          // Enable legend
                          legend: Legend(isVisible: true),
                          // Enable tooltip
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <ChartSeries<_SalesData, String>>[
                            LineSeries<_SalesData, String>(
                                dataSource: data,
                                xValueMapper: (_SalesData sales, _) =>
                                    sales.year,
                                yValueMapper: (_SalesData sales, _) =>
                                    sales.sales,
                                name: 'Sales',
                                // Enable data label
                                dataLabelSettings:
                                    DataLabelSettings(isVisible: true))
                          ]),
                      Expanded(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            //Initialize the spark charts widget
                            child: SfSparkLineChart.custom(
                              //Enable the trackball
                              trackball: SparkChartTrackball(
                                  activationMode: SparkChartActivationMode.tap),
                              //Enable marker
                              marker: SparkChartMarker(
                                  displayMode: SparkChartMarkerDisplayMode.all),
                              //Enable data label
                              labelDisplayMode: SparkChartLabelDisplayMode.all,
                              xValueMapper: (int index) => data[index].year,
                              yValueMapper: (int index) => data[index].sales,
                              dataCount: 5,
                            ),
                          ),
                        ),
                      )
                    ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
