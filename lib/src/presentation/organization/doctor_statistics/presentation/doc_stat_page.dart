





import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/resources/style_manager.dart';
import '../../../../core/resources/value_manager.dart';
import '../../../../data/services/user_services.dart';
import '../../../login/domain/model/user.dart';

class DocStatPage extends StatefulWidget {
  const DocStatPage({super.key});

  @override
  State<DocStatPage> createState() => _DocStatPageState();
}

class _DocStatPageState extends State<DocStatPage> {

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
    Map<String, int> genderCounts = _calculateGenderCounts();
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.primaryOpacity80,
        elevation: 1,
        leading: IconButton(
          onPressed: ()=>Get.back(),
          icon: FaIcon(Icons.chevron_left,color: ColorManager.white,),
        ),
        title: Text('Doctors Statistics',style: getMediumStyle(color: ColorManager.white),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          h20,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Doctors',style: getMediumStyle(color: ColorManager.black,fontSize: 24),),
                Container(
                  width: 220.w,
                  child: Divider(
                    color: ColorManager.black.withOpacity(0.5),
                    thickness: 0.7,
                  ),
                )
              ],
            ),
          ),
          h20,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
            margin: EdgeInsets.symmetric(horizontal: 18.w,vertical: 8.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border:Border.all(
                    color: ColorManager.black.withOpacity(0.5),
                    width: 0.5
                )
            ),
            child: SfCartesianChart(
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
          ),
        ],
      ),
    );
  }
}
