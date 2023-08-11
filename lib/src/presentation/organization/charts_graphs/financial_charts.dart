





import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/resources/style_manager.dart';
import '../../../core/resources/value_manager.dart';
import '../../../dummy_datas/dummy_datas.dart';


class FinancialCharts extends StatefulWidget {
  const FinancialCharts({super.key});

  @override
  State<FinancialCharts> createState() => _DoctorChartsState();
}

class _DoctorChartsState extends State<FinancialCharts> {
  bool tapped = false;
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {

    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    // Check if width is greater than height
    bool isWideScreen = screenSize.width > 500;
    bool isNarrowScreen = screenSize.width < 400;
    return Container(

      child: Column(

        children: [


          Container(
            decoration: BoxDecoration(

                border: Border.all(
                    color: ColorManager.black.withOpacity(0.3)
                )
            ),
            child: ExpansionPanelList(
                expandIconColor: ColorManager.primaryDark,
                elevation: 0,
                expandedHeaderPadding: EdgeInsets.zero,
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    _isExpanded = !_isExpanded; // Toggle the expansion state
                  });
                },
                children:[
                  ExpansionPanel(
                    isExpanded: _isExpanded,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(

                        onTap: (){
                          setState(() {
                            _isExpanded = !_isExpanded; // Toggle the expansion state
                          });
                        },
                        title: Text('Statistical Graph', style: getMediumStyle(color:ColorManager.black, fontSize: 20)),
                      ); // Empty header, handled above
                    },
                    body: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Income & expense',style: getMediumStyle(color: Colors.black,fontSize: 20),),
                            InkWell(
                                onTap: (){
                                  setState(() {
                                    tapped =!tapped;
                                  });
                                },
                                child: FaIcon(tapped? CupertinoIcons.eye:CupertinoIcons.eye_slash,color: Colors.black,))
                          ],
                        ),
                        SfCartesianChart(
                          zoomPanBehavior: ZoomPanBehavior(
                            enablePanning: true,
                            enablePinching: true,
                            zoomMode: ZoomMode.xy,

                          ),
                          legend: Legend(
                            isVisible: tapped,
                            position: LegendPosition.top,
                          ),
                          primaryXAxis: CategoryAxis(),
                          series: <ChartSeries>[
                            LineSeries<Map<String, dynamic>, String>(
                              dataLabelSettings: DataLabelSettings(
                                  isVisible: tapped,
                                  color: ColorManager.blue,
                                  labelIntersectAction: LabelIntersectAction.none
                              ),
                              dataSource: financialData,
                              xValueMapper: (Map<String, dynamic> data, _) => DateFormat('dd').format(DateTime.parse(data['date'])).toString(),
                              yValueMapper: (Map<String, dynamic> data, _) => data['totalIncome'],
                              name: 'Total Income',
                            ),
                            LineSeries<Map<String, dynamic>, String>(
                              dataLabelSettings: DataLabelSettings(
                                  isVisible: tapped,
                                  color: ColorManager.red
                              ),
                              dataSource: financialData,
                              xValueMapper: (Map<String, dynamic> data, _) => DateFormat('dd').format(DateTime.parse(data['date'])).toString(),
                              yValueMapper: (Map<String, dynamic> data, _) => data['totalExpenses'],
                              name: 'Total Expenses',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                ]



            ),
          ),

          h20,
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary
              ),
              onPressed: (){},
              child: Text('View full information',style: getRegularStyle(color: ColorManager.white,fontSize: 16),)
          )




        ],
      ),
    );
  }
}
