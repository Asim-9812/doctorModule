import 'package:flutter/material.dart';
import 'package:medical_app/src/core/resources/style_manager.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../data/model/registered_patient_model.dart';
import '../data/services/registered_patient_services.dart';



class MyHomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<_SalesData> data = [];
  List<RegisteredPatientModel> patients = [];

  @override
  void initState() {
    super.initState();
    _getPatientList();
  }

  void _getPatientList() async {
    final List<RegisteredPatientModel> patientList =
    await RegisteredPatientService().getRegisteredPatients();
    setState(() {
      patients = patientList;
      _updateChartData();
    });
  }

  void _updateChartData() {
    Map<DateTime, int> datePatientCountMap = _calculateDatePatientCounts(patients);
    data = [];
    datePatientCountMap.forEach((date, patientCount) {
      int maleCount = _getGenderCountOnDate(patients, date, 1);
      int femaleCount = _getGenderCountOnDate(patients, date, 2);
      int otherCount = patientCount - maleCount - femaleCount;
      data.add(_SalesData(date, maleCount, femaleCount, otherCount));
    });
  }

  Map<DateTime, int> _calculateDatePatientCounts(
      List<RegisteredPatientModel> patients) {
    Map<DateTime, int> datePatientCountMap = {};
    for (var patient in patients) {
      DateTime entryDate = patient.entryDate;
      if (datePatientCountMap.containsKey(entryDate)) {
        datePatientCountMap[entryDate] = datePatientCountMap[entryDate]! + 1;
      } else {
        datePatientCountMap[entryDate] = 1;
      }
    }
    return datePatientCountMap;
  }

  int _getGenderCountOnDate(
      List<RegisteredPatientModel> patients, DateTime date, int genderID) {
    return patients
        .where((patient) =>
    patient.entryDate.year == date.year &&
        patient.entryDate.month == date.month &&
        patient.entryDate.day == date.day &&
        patient.genderID == genderID)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Syncfusion Flutter chart'),
        ),
        body: Column(children: [
          //Initialize the chart widget
          SfCartesianChart(
            primaryXAxis: DateTimeAxis(), // Use DateTimeAxis for x-axis
            series: <ChartSeries<_SalesData, DateTime>>[
              LineSeries<_SalesData, DateTime>(
                dataSource: data,
                xValueMapper: (_SalesData sales, _) => sales.date,
                yValueMapper: (_SalesData sales, _) => sales.maleCount,
                name: 'Male',
              ),
              LineSeries<_SalesData, DateTime>(
                dataSource: data,
                xValueMapper: (_SalesData sales, _) => sales.date,
                yValueMapper: (_SalesData sales, _) => sales.femaleCount,
                name: 'Female',
              ),
              LineSeries<_SalesData, DateTime>(
                dataSource: data,
                xValueMapper: (_SalesData sales, _) => sales.date,
                yValueMapper: (_SalesData sales, _) => sales.otherCount,
                name: 'Other',
              ),
            ],
          ),
        ]));
  }
}

class _SalesData {
  _SalesData(this.date, this.maleCount, this.femaleCount, this.otherCount);

  final DateTime date;
  final int maleCount;
  final int femaleCount;
  final int otherCount;
}