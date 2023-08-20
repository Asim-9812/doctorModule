


import 'package:flutter/material.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../dummy_datas/dummy_datas.dart';

class SugarGraphs extends StatefulWidget {
  const SugarGraphs({super.key});

  @override
  State<SugarGraphs> createState() => _SugarGraphsState();
}

class _SugarGraphsState extends State<SugarGraphs> {
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(),
      axes: <ChartAxis>[
        NumericAxis(opposedPosition: true, name: 'Glucose',title: AxisTitle(text: 'Glucose level')),
        NumericAxis(name: 'Insulin',title: AxisTitle(text: 'Insulin level'),edgeLabelPlacement: EdgeLabelPlacement.none),
      ],
      series: <ChartSeries>[
        LineSeries<GlucoseInsulinData, DateTime>(
          dataSource: dummyGlucoseInsulinData,
          xValueMapper: (GlucoseInsulinData data, _) => data.date,
          yValueMapper: (GlucoseInsulinData data, _) => data.glucoseLevel,
          name: 'Glucose',
          yAxisName: 'Glucose',
        ),
        LineSeries<GlucoseInsulinData, DateTime>(
          dataSource: dummyGlucoseInsulinData,
          xValueMapper: (GlucoseInsulinData data, _) => data.date,
          yValueMapper: (GlucoseInsulinData data, _) => data.insulinLevel,
          name: 'Insulin',
          yAxisName: 'Insulin',
        ),
      ],
      legend: Legend(
          isResponsive: true,
          isVisible: true,
          position: LegendPosition.top
      ),
    );
  }
}
