

import 'package:flutter/material.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';

class OrgReportPage extends StatelessWidget {
  const OrgReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: ColorManager.white,
     body: Center(
       child: Text('Report Page'),
     ),
    );
  }
}
