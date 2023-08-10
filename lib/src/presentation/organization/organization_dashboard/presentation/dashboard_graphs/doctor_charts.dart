





import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../core/resources/style_manager.dart';
import '../../../../../core/resources/value_manager.dart';
import '../../../../../data/services/user_services.dart';
import '../../../../login/domain/model/user.dart';

class DoctorCharts extends StatefulWidget {
  const DoctorCharts({super.key});

  @override
  State<DoctorCharts> createState() => _DoctorChartsState();
}

class _DoctorChartsState extends State<DoctorCharts> {

  List<User> doctors = [];


  @override
  void initState() {
    super.initState();
    _getDoctorsList();
    _calculateGenderCounts();
  }

  void _getDoctorsList() async {
    final List<User> doctorList = await UserService().getDoctors();
    setState(() {
      doctors = doctorList;
    });
  }


  Map<String, int> _calculateGenderCounts() {
    Map<String, int> genderCounts = {
      'Male': 0,
      'Female': 0,
      'Others': 0,
    };

    for (var data in doctors) {
      final gender = data.genderID;
      if (gender == 1) {
        genderCounts['Male'] = (genderCounts['Male'] ?? 0) + 1;
      } else if (gender == 2) {
        genderCounts['Female'] = (genderCounts['Female'] ?? 0) + 1;
      } else {
        genderCounts['Others'] = (genderCounts['Others'] ?? 0) + 1;
      }
    }

    return genderCounts;
  }

  @override
  Widget build(BuildContext context) {

    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    // Check if width is greater than height
    bool isWideScreen = screenSize.width > 500;
    bool isNarrowScreen = screenSize.width < 400;
    Map<String, int> genderCounts = _calculateGenderCounts();
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: ColorManager.white,
        leading: IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.chevron_left,color: Colors.black,)),
        title: Text('Doctors',style: getMediumStyle(color: ColorManager.black,fontSize: isNarrowScreen? 24.sp:28),),

      ),
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: ColorManager.black.withOpacity(0.5)
            )
        ),
        margin: EdgeInsets.symmetric(horizontal: 18.w,vertical: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Total Doctors',style: getMediumStyle(color: ColorManager.black,fontSize: 24),),
            h20,
            SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              series: <ChartSeries>[
                ColumnSeries<String, String>(
                  dataSource: genderCounts.keys.toList(),
                  xValueMapper: (String gender, _) => gender,
                  yValueMapper: (String gender, _) => genderCounts[gender]!,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                  pointColorMapper: (String gender, _) {
                    if (gender == 'Male') {
                      return ColorManager.blue.withOpacity(0.7);
                    } else if (gender == 'Female') {
                      return ColorManager.premiumContainer.withOpacity(0.7);
                    } else {
                      return ColorManager.red.withOpacity(0.5);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
