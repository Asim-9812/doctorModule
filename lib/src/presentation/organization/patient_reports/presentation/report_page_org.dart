







import 'package:flutter/material.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';

class OrgPatientReports extends StatefulWidget {
  const OrgPatientReports({super.key});

  @override
  State<OrgPatientReports> createState() => _OrgPatientReportsState();
}

class _OrgPatientReportsState extends State<OrgPatientReports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Center(
        child: Text('patient report page'),
      ),
    );
  }
}
