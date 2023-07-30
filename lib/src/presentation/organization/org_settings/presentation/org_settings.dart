










import 'package:flutter/material.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';

class OrgSettings extends StatefulWidget {
  const OrgSettings({super.key});

  @override
  State<OrgSettings> createState() => _OrgSettingsState();
}

class _OrgSettingsState extends State<OrgSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Center(
        child: Text('settings'),
      ),
    );
  }
}
