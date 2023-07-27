



import 'package:flutter/material.dart';

class PatientReportPage extends StatefulWidget {
  const PatientReportPage({super.key});

  @override
  State<PatientReportPage> createState() => _PatientReportPageState();
}

class _PatientReportPageState extends State<PatientReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Report page'),
      ),
    );
  }
}
