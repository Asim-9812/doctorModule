



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/style_manager.dart';
import '../../../../core/resources/value_manager.dart';
import '../../../../dummy_datas/dummy_datas.dart';

class DocPatientProfile extends StatefulWidget {
  const DocPatientProfile({super.key});

  @override
  State<DocPatientProfile> createState() => _DocPatientProfileState();
}

class _DocPatientProfileState extends State<DocPatientProfile> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    // Check if width is greater than height
    bool isWideScreen = screenSize.width > 500;
    bool isNarrowScreen = screenSize.width < 380;
    return Scaffold(
      backgroundColor: ColorManager.white.withOpacity(0.99),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: ColorManager.white,
        leading: IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.chevron_left,color: Colors.black,)),
        title: Text('Profile',style: getMediumStyle(color: ColorManager.black,fontSize: isNarrowScreen? 24.sp:28),),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.edit_note_outlined,color: ColorManager.primary,size: 30,))
        ],

      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            profileBanner(context),
            h20,
            _patientStat(),
            h20,
            Container(
              margin: EdgeInsets.symmetric(horizontal: 18.w),
              padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 12.h),
              decoration: BoxDecoration(
                color: ColorManager.dotGrey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: ColorManager.black.withOpacity(0.5)
                )
            ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: ColorManager.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
                        child: Center(
                          child: FaIcon(Icons.medical_information,color: ColorManager.black,),
                        ),
                      ),
                      w10,
                      Text('Medical History',style: getRegularStyle(color: ColorManager.black),)
                    ],
                  ),
                  FaIcon(Icons.chevron_right,color: ColorManager.black,)
                ],
              ),
            ),
            h20,
            _patientVisit(),
            h100
          ],
        ),
      ),
    );
  }


  _patientStat(){
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),

                    color: ColorManager.red.withOpacity(0.15)
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 18.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FaIcon(FontAwesomeIcons.heartPulse,color: ColorManager.red.withOpacity(0.5),),
                        w10,
                        Text('Heart Rate',style: getRegularStyle(color: ColorManager.black),)
                      ],
                    ),
                    h10,
                    Text('120 bpm',style: getMediumStyle(color: ColorManager.black),),
                    h20,
                    Text('Recorded date: 2023-08-09',style: getRegularStyle(color: ColorManager.black,fontSize:  16),)
                  ],

                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),

                    color: ColorManager.primary.withOpacity(0.15)
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 18.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FaIcon(FontAwesomeIcons.heartCircleBolt,color: ColorManager.primaryDark.withOpacity(0.5),),
                        w10,
                        Text('Blood Pressure',style: getRegularStyle(color: ColorManager.black),)
                      ],
                    ),
                    h10,
                    Text('120/80 mm Hg',style: getMediumStyle(color: ColorManager.black),),
                    h20,
                    Text('Recorded Date: 2023-08-09',style: getRegularStyle(color: ColorManager.black,fontSize: 16),)
                  ],

                ),
              ),
            ],
          ),
        ),
        h20,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),

                    color: ColorManager.blue.withOpacity(0.15)
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 18.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FaIcon(CupertinoIcons.graph_circle_fill,color: ColorManager.blue.withOpacity(0.5),),
                        w10,
                        Text('Cholesterol',style: getRegularStyle(color: ColorManager.black),)
                      ],
                    ),
                    h10,
                    Text('97 mg/dl',style: getMediumStyle(color: ColorManager.black),),
                    h20,
                    Text('Recorded date: 2023-08-09',style: getRegularStyle(color: ColorManager.black,fontSize:  16),)
                  ],

                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),

                    color: ColorManager.orange.withOpacity(0.15)
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 18.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FaIcon(FontAwesomeIcons.heartCircleCheck,color: ColorManager.orange.withOpacity(0.5),),
                        w10,
                        Text('Sugar',style: getRegularStyle(color: ColorManager.black),)
                      ],
                    ),
                    h10,
                    Text('90 mg/dl',style: getMediumStyle(color: ColorManager.black),),
                    h20,
                    Text('Recorded Date: 2023-08-09',style: getRegularStyle(color: ColorManager.black,fontSize: 16),)
                  ],

                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _patientVisit(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        h20,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Text('Patient Visit History',style: getMediumStyle(color: ColorManager.black),overflow: TextOverflow.fade,),
        ),
        h10,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: MaterialStateColor.resolveWith((states) => ColorManager.primaryDark),
            headingTextStyle: getRegularStyle(color: ColorManager.white,fontSize: 18),
            columns: [
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Doctor')),
              DataColumn(label: Text('Treatment')),
            ],
            rows: patientHistory.asMap().entries.map((entry) {
              final int index = entry.key;
              final Map<String,dynamic> history = entry.value;
              final Color rowColor = index % 2 == 0 ? ColorManager.white : ColorManager.dotGrey.withOpacity(0.3); // Alternate colors

              return DataRow(
                color: MaterialStateColor.resolveWith((states) => rowColor),
                cells: [
                  DataCell(Text(history['date'])),
                  DataCell(Text(history['doctor'])),
                  DataCell(Text(history['treatment'])),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  /// Profile...

  Widget profileBanner(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    // Check if width is greater than height
    bool isWideScreen = screenSize.width > 500;
    bool isNarrowScreen = screenSize.width < 380;





    return Card(
      elevation: 3,
      shadowColor: ColorManager.textGrey.withOpacity(0.4),
      child: Container(
        height: MediaQuery.of(context).size.height * 1/4,
        padding: EdgeInsets.symmetric(horizontal: 18.w,vertical:12.h),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 120.h,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/containers/Tip-Container-3.png'),fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)
                    )
                ),
              ) ,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    shape: CircleBorder(),
                    elevation: 5,
                    child: CircleAvatar(
                      backgroundColor: ColorManager.white,
                      radius: isNarrowScreen? 50.r:50,
                      child: CircleAvatar(
                        backgroundColor: ColorManager.black,
                        radius: isNarrowScreen? 45.r:45,
                        child: FaIcon(FontAwesomeIcons.person,color: ColorManager.white,),
                      ),
                    ),
                  ),
                  w10,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('User',style: getMediumStyle(color: ColorManager.black,fontSize: isNarrowScreen? 32.sp:32),),
                      h10,
                      Row(
                        children: [
                          Text('Gender',style: getRegularStyle(color: ColorManager.textGrey,fontSize: isNarrowScreen?16.sp:16),),
                          w10,
                          Text('|',style: getRegularStyle(color: ColorManager.textGrey,fontSize: isNarrowScreen?12.sp:12),),
                          w10,
                          Text('23 yrs',style: getRegularStyle(color: ColorManager.textGrey,fontSize: isNarrowScreen?16.sp:16),),
                          w10,
                          Text('|',style: getRegularStyle(color: ColorManager.textGrey,fontSize:isNarrowScreen?12.sp: 12),),
                          w10,
                          Text('Address',style: getRegularStyle(color: ColorManager.textGrey,fontSize: isNarrowScreen?16.sp:16),),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Profile items func & ui ...

  Widget _profileItems({
    VoidCallback? onTap,
    required String title,
    required IconData icon,
    String? subtitle,
    bool? trailing,
    required Size screenSize

  }) {

    // Check if width is greater than height
    bool isWideScreen = screenSize.width > 500;
    bool isNarrowScreen = screenSize.width < 420;
    if(trailing == null){
      trailing = false;
    }
    return ListTile(
      onTap: onTap,
      splashColor: ColorManager.textGrey.withOpacity(0.2),
      leading: FaIcon(icon,size: isNarrowScreen?24.sp:24,),
      title: Text('$title',style:getRegularStyle(color: ColorManager.black,fontSize:isNarrowScreen?20.sp:20 ),),
      subtitle: subtitle != null? Text('$subtitle',style:getRegularStyle(color: ColorManager.subtitleGrey,fontSize:isNarrowScreen?16.sp:16 ),):null,
      trailing: trailing == true? Icon(Icons.chevron_right,color: ColorManager.iconGrey,):null ,
    );
  }

}


