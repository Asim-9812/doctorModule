


import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sensors/flutter_sensors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medical_app/src/core/resources/style_manager.dart';
import 'package:medical_app/src/presentation/login/domain/service/login_service.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:weather/weather.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';

import '../../../../core/resources/value_manager.dart';
import '../../../login/presentation/status_page.dart';



class SettingsPage extends ConsumerStatefulWidget {
  final bool isWideScreen;
  final bool isNarrowScreen;
  SettingsPage(this.isWideScreen,this.isNarrowScreen);

  @override
  ConsumerState<SettingsPage> createState() => _UtilitiesPageState();
}

class _UtilitiesPageState extends ConsumerState<SettingsPage> {




  @override
  Widget build(BuildContext context) {

    return FadeIn(
      duration: Duration(milliseconds: 500),
      child: Scaffold(
        backgroundColor: ColorManager.dotGrey.withOpacity(0.01),

        appBar: AppBar(
          elevation: 1,
          backgroundColor: ColorManager.white,
          automaticallyImplyLeading: false,
          title: Text('Settings',style: getMediumStyle(color: ColorManager.black,fontSize: widget.isNarrowScreen? 20.sp:28.sp),),
        ),
        body: SingleChildScrollView(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              h20,
              FadeInUp(
                duration: Duration(milliseconds: 700),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Account & Settings',style: getMediumStyle(color: ColorManager.black,fontSize: widget.isNarrowScreen?24.sp: 24),),
                          w10,
                          Container(
                            width:widget.isNarrowScreen?160.w: 220.w,
                            child: Divider(
                              thickness: 0.5,
                              color: ColorManager.black,
                            ),

                          )
                        ],
                      ),
                      h10,
                      _profileItems(title: 'Change Password', icon: FontAwesomeIcons.key, onTap: (){},trailing: true),
                      _profileItems(title: 'Language', icon: Icons.sort_by_alpha, onTap: (){},trailing: true),
                      _profileItems(title: 'Permissions', icon: FontAwesomeIcons.universalAccess, onTap: (){},trailing: true),
                    ],
                  ),
                ),
              ),
              h20,
              FadeInUp(
                duration: Duration(milliseconds: 850),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Help & Support',style: getMediumStyle(color: ColorManager.black,fontSize:widget.isNarrowScreen?24.sp: 24),),
                          w10,
                          Container(
                            width: widget.isNarrowScreen?200.w:250.w,
                            child: Divider(
                              thickness: 0.5,
                              color: ColorManager.black,
                            ),

                          )
                        ],
                      ),
                      h10,
                      _profileItems(title: 'Emergency Support', icon: Icons.warning_amber, onTap: (){},trailing: true),
                      _profileItems(title: 'Help Center', icon: Icons.question_mark, onTap: (){},trailing: true),
                      _profileItems(title: 'Terms & Policies', icon: FontAwesomeIcons.book, onTap: (){},trailing: true),
                      h20,
                      h20,
                      _profileItems(
                          title: 'Log out',
                          icon: Icons.login_outlined,
                          onTap: () {
                            ref.read(userProvider.notifier).userLogout();
                            print('logout');
                            Get.offAll(() => StatusPage(accountId: 0,));
                          }
                      ),
                    ],
                  ),
                ),
              ),

              h20,
              h20,
              h20,
              FadeInUp(
                duration: Duration(milliseconds: 1000),
                child: Container(

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Version 1.0.0',style: getRegularStyle(color: ColorManager.black,fontSize: 16),),
                      h10,
                      Text('Developed by Search Technology',style: getRegularStyle(color: ColorManager.black,fontSize: 16),),
                      h10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.facebook),
                          w12,
                          FaIcon(FontAwesomeIcons.linkedin),
                          w12,
                          FaIcon(FontAwesomeIcons.twitter),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              h100,

            ],
          ),
        ),
      ),
    );
  }
  Widget _profileItems({
    VoidCallback? onTap,
    required String title,
    required IconData icon,
    String? subtitle,
    bool? trailing,
  }) {
    if (trailing == null) {
      trailing = false;
    }
    return ListTile(
      onTap: onTap, // Pass the onTap callback here
      splashColor: ColorManager.textGrey.withOpacity(0.2),
      leading: FaIcon(icon, size: widget.isNarrowScreen?24.sp :24,),
      title: Text('$title', style: getRegularStyle(color: ColorManager.black, fontSize: widget.isNarrowScreen? 20.sp:20),),
      subtitle: subtitle != null ? Text('$subtitle', style: getRegularStyle(color: ColorManager.subtitleGrey, fontSize: widget.isNarrowScreen?16.sp:16),) : null,
      trailing: trailing == true ? Icon(Icons.chevron_right, color: ColorManager.iconGrey,size: widget.isNarrowScreen?20.sp:20,) : null,
    );
  }


}
