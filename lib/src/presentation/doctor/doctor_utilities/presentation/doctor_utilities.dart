



import 'package:flutter/material.dart';

class DoctorUtilityPage extends StatefulWidget {
  const DoctorUtilityPage({super.key});

  @override
  State<DoctorUtilityPage> createState() => _PatientReportPageState();
}

class _PatientReportPageState extends State<DoctorUtilityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Utilities page'),
      ),
    );
  }
}
