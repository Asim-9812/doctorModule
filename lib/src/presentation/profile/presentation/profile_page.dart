


import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';
import 'package:medical_app/src/core/resources/style_manager.dart';

import '../../../core/resources/value_manager.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white.withOpacity(0.99),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: ColorManager.white,
        leading: IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.chevron_left,color: Colors.black,)),
        title: Text('Profile',style: getMediumStyle(color: ColorManager.black),),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.edit_note_outlined,color: ColorManager.primary,size: 30,))
        ],

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeIn(
              duration: Duration(milliseconds: 500),
              child: profileBanner(context)),
          Container(
            height: MediaQuery.of(context).size.height * 3/5,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: FadeInUp(
                duration: Duration(milliseconds: 700),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    h16,
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Details',style: getMediumStyle(color: ColorManager.black,fontSize: 24),),
                              w10,
                              Container(
                                width: 320.w,
                                child: Divider(
                                  thickness: 0.5,
                                  color: ColorManager.black,
                                ),

                              )
                            ],
                          ),
                          h10,
                          _profileItems(title: 'Phone Number', icon: FontAwesomeIcons.phone, onTap: (){},subtitle: '98XXXXXXXX'),
                          _profileItems(title: 'E-Mail', icon: Icons.email_outlined, onTap: (){},subtitle: 'user@gmail.com'),
                          _profileItems(title: 'Other Details', icon: FontAwesomeIcons.idCard, onTap: (){},trailing: true),
                        ],
                      ),
                    ),
                    h20,
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Reminders',style: getMediumStyle(color: ColorManager.black,fontSize: 24),),
                              w10,
                              Container(
                                width: 280.w,
                                child: Divider(
                                  thickness: 0.5,
                                  color: ColorManager.black,
                                ),

                              )
                            ],
                          ),
                          h10,
                          _profileItems(title: 'Medicine', icon: FontAwesomeIcons.pills, onTap: (){},trailing: true),
                          _profileItems(title: 'Appointments', icon: Icons.assignment_turned_in_outlined, onTap: (){},trailing: true),
                        ],
                      ),
                    ),
                    h20,
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Medical Records',style: getMediumStyle(color: ColorManager.black,fontSize: 24),),
                              w10,
                              Container(
                                width: 240.w,
                                child: Divider(
                                  thickness: 0.5,
                                  color: ColorManager.black,
                                ),

                              )
                            ],
                          ),
                          h10,
                          _profileItems(title: 'Medical History', icon: FontAwesomeIcons.history, onTap: (){},trailing: true),
                          _profileItems(title: 'Transaction History', icon: Icons.receipt_long, onTap: (){},trailing: true),
                          ],
                      ),
                    ),

                    h20,
                    h20,
                    h20,




                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  /// Profile...
  
  Widget profileBanner(BuildContext context) {
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
                      radius: 50,
                      child: CircleAvatar(
                        backgroundColor: ColorManager.black,
                        radius: 45,
                        child: FaIcon(FontAwesomeIcons.person,color: ColorManager.white,),
                      ),
                    ),
                  ),
                  w10,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('User',style: getMediumStyle(color: ColorManager.black,fontSize: 32),),
                      h10,
                      Row(
                        children: [
                          Text('Gender',style: getRegularStyle(color: ColorManager.textGrey,fontSize: 16),),
                          w10,
                          Text('|',style: getRegularStyle(color: ColorManager.textGrey,fontSize: 12),),
                          w10,
                          Text('23 yrs',style: getRegularStyle(color: ColorManager.textGrey,fontSize: 16),),
                          w10,
                          Text('|',style: getRegularStyle(color: ColorManager.textGrey,fontSize: 12),),
                          w10,
                          Text('Address',style: getRegularStyle(color: ColorManager.textGrey,fontSize: 16),),
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
