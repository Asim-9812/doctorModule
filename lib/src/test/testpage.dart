


import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sensors/flutter_sensors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medical_app/src/core/resources/style_manager.dart';
import 'package:weather/weather.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';

import '../core/resources/value_manager.dart';


class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _UtilitiesPageState();
}

class _UtilitiesPageState extends State<Settings> {




  @override
  Widget build(BuildContext context) {

    return FadeIn(
      duration: Duration(milliseconds: 500),
      child: Scaffold(
        backgroundColor: ColorManager.dotGrey.withOpacity(0.01),

        appBar: AppBar(
          elevation: 1,
          backgroundColor: ColorManager.white,
          title: Text('Settings',style: getMediumStyle(color: ColorManager.black),),
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
                          Text('Account & Settings',style: getMediumStyle(color: ColorManager.black,fontSize: 24),),
                          w10,
                          Container(
                            width: 220.w,
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
                          Text('Help & Support',style: getMediumStyle(color: ColorManager.black,fontSize: 24),),
                          w10,
                          Container(
                            width: 250.w,
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
                          onTap: (){}
                      ),
                    ],
                  ),
                ),
              ),

              h100,
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
    if(trailing == null){
      trailing = false;
    }
    return ListTile(
      onTap: onTap,
      splashColor: ColorManager.textGrey.withOpacity(0.2),
      leading: FaIcon(icon,size: 24,),
      title: Text('$title',style:getRegularStyle(color: ColorManager.black,fontSize:20 ),),
      subtitle: subtitle != null? Text('$subtitle',style:getRegularStyle(color: ColorManager.subtitleGrey,fontSize:16 ),):null,
      trailing: trailing == true? Icon(Icons.chevron_right,color: ColorManager.iconGrey,):null ,
    );
  }

}
