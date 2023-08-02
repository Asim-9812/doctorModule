
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:medical_app/src/app/app.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';
import 'package:medical_app/src/core/resources/style_manager.dart';
import 'package:medical_app/src/presentation/doctor/doctor_dashboard/presentation/doctor_home_page.dart';
import 'package:medical_app/src/presentation/doctor/doctor_utilities/presentation/doctor_utilities.dart';
import 'package:medical_app/src/presentation/doctor/documents/presentation/document_page.dart';
import 'package:medical_app/src/presentation/organization/org_settings/presentation/org_settings.dart';
import 'package:medical_app/src/presentation/organization/organization_dashboard/presentation/org_homepage.dart';
import 'package:medical_app/src/presentation/organization/patient_reports/presentation/report_page_org.dart';
import 'package:medical_app/src/test/test1.dart';
import 'package:medical_app/src/test/testpage.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../../../../core/resources/value_manager.dart';




class OrgMainPage extends StatefulWidget {
  const OrgMainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<OrgMainPage> createState() => _AnimatedBarExampleState();
}

class _AnimatedBarExampleState extends State<OrgMainPage> {
  int selected =0;
  PageController controller = PageController();


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    // Check if width is greater than height
    bool isWideScreen = screenSize.width > 500;
    bool isNarrowScreen = screenSize.width < 420;

    return Scaffold(
      extendBody: true, //to make floating action button notch transparent

      //to avoid the floating action button overlapping behavior,
      // when a soft keyboard is displayed
      // resizeToAvoidBottomInset: false,

      bottomNavigationBar: Container(

        margin: EdgeInsets.only(left: 50.w,right: 50.w,bottom: 40.h),
        height: 60.h,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                onTap: (){
                  setState(() {
                    selected =0;
                  });
                  controller.jumpToPage(selected);
                },
                child: Container(
                  width: isWideScreen? 80 :80.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                     selected==0? FaIcon(CupertinoIcons.home,color: ColorManager.primary,size: isWideScreen?24:24.sp,):FaIcon(CupertinoIcons.home,color: ColorManager.textGrey,size: 18.sp,),
                      w10,
                      if(selected==0)Text('Home',style: getRegularStyle(color: ColorManager.primary,fontSize: isWideScreen? 12 :12.sp),)
                    ],
                  ),
                ),
              ),
              VerticalDivider(
                thickness: 0.5,
                color: ColorManager.textGrey.withOpacity(0.5),
                indent: 8,
                endIndent: 8,
              ),
              InkWell(
                splashColor: Colors.transparent,
                onTap: (){
                  setState(() {
                    selected =1;
                  });
                  controller.jumpToPage(selected);
                },
                child: Container(
                  width: isWideScreen? 80 :80.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      selected==1? FaIcon(CupertinoIcons.doc_chart,color: ColorManager.primary,size: isWideScreen?24:24.sp,):FaIcon(CupertinoIcons.doc_chart,color: ColorManager.textGrey,size: isWideScreen?20:20.sp,),
                      w10,
                      if(selected==1)Text('Reports',style: getRegularStyle(color: ColorManager.primary,fontSize: isWideScreen? 12 :12.sp),)
                    ],
                  ),
                ),
              ),
              VerticalDivider(
                thickness: 0.5,
                color: ColorManager.textGrey.withOpacity(0.5),
                indent: 8,
                endIndent: 8,
              ),
              InkWell(
                splashColor: Colors.transparent,
                onTap: (){
                  setState(() {
                    selected =2;
                  });
                  controller.jumpToPage(selected);
                },
                child: Container(
                  width: isWideScreen? 80 :80.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      selected==2? FaIcon(Icons.settings,color: ColorManager.primary,size: isWideScreen?24:24.sp,):FaIcon(Icons.settings,color: ColorManager.textGrey,size: isWideScreen?20:20.sp,),
                      w10,
                      if(selected==2)Text('Settings',style: getRegularStyle(color: ColorManager.primary,fontSize: isWideScreen? 12 :12.sp),)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          OrgHomePage(isWideScreen,isNarrowScreen),
          OrgPatientReports(),
          OrgSettings(isWideScreen,isNarrowScreen),
        ],
      ),
    );
  }
}
