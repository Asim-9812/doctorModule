



import 'package:flutter/material.dart';

class PatientReportPageDoctor extends StatefulWidget {
  const PatientReportPageDoctor({super.key});

  @override
  State<PatientReportPageDoctor> createState() => _PatientReportPageDoctorState();
}

class _PatientReportPageDoctorState extends State<PatientReportPageDoctor> {
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
