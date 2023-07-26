import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:medical_app/src/app/app.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';
import 'package:medical_app/src/test/test1.dart';
import 'package:medical_app/src/test/testpage.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../documents/presentation/document_page.dart';
import '../settings/presentation/settings_page.dart';
import 'presentation/home_page.dart';
import '../scan/presentation/qr_scan.dart';
import '../utilities/presentation/utilities_page.dart';



class PatientMainPage extends StatefulWidget {
  const PatientMainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PatientMainPage> createState() => _AnimatedBarExampleState();
}

class _AnimatedBarExampleState extends State<PatientMainPage> {
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
            icon: const FaIcon(Icons.grid_view_outlined,size: 24,),
            // selectedIcon: const FaIcon(FontAwesomeIcons.folder),
            selectedColor: ColorManager.primary,
            // unSelectedColor: Colors.purple,
            // backgroundColor: Colors.orange,
            title: const Text('Utilities'),
          ),
          BottomBarItem(
            icon: const FaIcon(Icons.menu,size: 24,),
            // selectedIcon: const FaIcon(FontAwesomeIcons.folder),
            selectedColor: ColorManager.primary,
            // unSelectedColor: Colors.purple,
            // backgroundColor: Colors.orange,
            title: const Text('Menu'),
          ),
        ],
        hasNotch: true,
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
        onPressed: () =>Get.to(()=>QRViewExample()),
        backgroundColor: ColorManager.primaryOpacity80,
        child: FaIcon(Icons.qr_code_2_outlined,size: 40.sp,)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: PageView(
        controller: controller,
        children: [
          HomePage(),
          DocumentPage(),
          UtilitiesPage(),
          SettingsPage()
        ],
      ),
    );
  }
}
