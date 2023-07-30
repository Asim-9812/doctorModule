import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:medical_app/src/app/app.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';
import 'package:medical_app/src/presentation/doctor/doctor_dashboard/presentation/doctor_home_page.dart';
import 'package:medical_app/src/presentation/doctor/doctor_utilities/presentation/doctor_utilities.dart';
import 'package:medical_app/src/presentation/doctor/documents/presentation/document_page.dart';
import 'package:medical_app/src/test/test1.dart';
import 'package:medical_app/src/test/testpage.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../patient/documents/presentation/document_page.dart';
import '../../../patient/scan/presentation/qr_scan.dart';
import '../../../patient/settings/presentation/settings_page.dart';
import '../../../patient/utilities/presentation/patient_utilities.dart';
import '../../patient_reports/presentation/report_page_doctor.dart';




class DoctorMainPage extends StatefulWidget {
  const DoctorMainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<DoctorMainPage> createState() => _AnimatedBarExampleState();
}

class _AnimatedBarExampleState extends State<DoctorMainPage> {
  dynamic selected;
  PageController controller = PageController();


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, //to make floating action button notch transparent

      //to avoid the floating action button overlapping behavior,
      // when a soft keyboard is displayed
      // resizeToAvoidBottomInset: false,

      bottomNavigationBar: StylishBottomBar(
        elevation: 10,
        option: AnimatedBarOptions(
          // iconSize: 32,
          barAnimation: BarAnimation.fade,
          iconStyle: IconStyle.animated,
          // opacity: 0.3,
        ),
        items: [
          BottomBarItem(
            icon: const FaIcon(CupertinoIcons.home,size: 24,),
            // selectedIcon: const Icon(CupertinoIcons.home,size: 24,),
            selectedColor: ColorManager.primary,
            // unSelectedColor: Colors.purple,
            // backgroundColor: Colors.orange,
            title: const Text('Home'),
          ),
          BottomBarItem(
            icon: const FaIcon(Icons.file_copy,size: 24,),
            // selectedIcon: const FaIcon(FontAwesomeIcons.folder),
            selectedColor: ColorManager.primary,
            // unSelectedColor: Colors.purple,
            // backgroundColor: Colors.orange,
            title: const Text('Documents'),
          ),
          BottomBarItem(
            icon: const FaIcon(CupertinoIcons.doc_chart,size: 24,),
            // selectedIcon: const FaIcon(FontAwesomeIcons.folder),
            selectedColor: ColorManager.primary,
            // unSelectedColor: Colors.purple,
            // backgroundColor: Colors.orange,
            title: const Text('Reports'),
          ),
          BottomBarItem(
            icon: const FaIcon(Icons.grid_view_outlined,size: 24,),
            // selectedIcon: const FaIcon(FontAwesomeIcons.folder),
            selectedColor: ColorManager.primary,
            // unSelectedColor: Colors.purple,
            // backgroundColor: Colors.orange,
            title: const Text('Utilities'),
          ),

        ],
        hasNotch: false,
        fabLocation: StylishBarFabLocation.center,
        currentIndex: selected ?? 0,
        onTap: (index) {
          controller.jumpToPage(index);
          setState(() {
            selected = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: ColorManager.primaryDark,
          child: FaIcon(CupertinoIcons.chat_bubble_2_fill,size: 40.sp,)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: PageView(
        controller: controller,
        children: [
          DoctorHomePage(),
          DoctorDocumentPage(),
          PatientReportPageDoctor(),
          DoctorUtilityPage()
        ],
      ),
    );
  }
}
