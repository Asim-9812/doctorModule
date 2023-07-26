


import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';
import 'package:medical_app/src/core/resources/style_manager.dart';
import 'package:medical_app/src/dummy_datas/dummy_datas.dart';
import '../../../../core/resources/value_manager.dart';
import 'notfication_general.dart';
import 'notification_personal.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    return FadeIn(
      child: Scaffold(
        backgroundColor: ColorManager.white.withOpacity(0.98),
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: 1,
          leading: IconButton(
            onPressed: ()=>Get.back(),
            icon: FaIcon(Icons.chevron_left,color: ColorManager.black,),
          ),
          centerTitle: true,
          title: Text('Notifications',style: getMediumStyle(color: ColorManager.black),),
        ),
        body: FadeInUp(
          duration: Duration(milliseconds: 900),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              h20,
              Center(
                child: Container(
                  height: 70.w,
                  width: 390.h,
                  decoration: BoxDecoration(
                      color: ColorManager.dotGrey.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(15)
                ),
                  child:  TabBar(
                      controller: _tabController,
                      padding: EdgeInsets.symmetric(
                          vertical: 8.h, horizontal: 8.w),
                      labelStyle: getMediumStyle(
                          color: ColorManager.white,
                        fontSize: 18
                      ),
                      unselectedLabelStyle: getMediumStyle(
                          color: ColorManager.textGrey,
                          fontSize: 18
                      ),
                      isScrollable: false,
                      labelPadding: EdgeInsets.only(left: 15.w, right: 15.w),
                      labelColor: ColorManager.white,

                      unselectedLabelColor: ColorManager.textGrey,
                      // indicatorColor: primary,
                      indicator: BoxDecoration(
                          color: ColorManager.blue,
                          borderRadius: BorderRadius.circular(15)),
                      tabs: [
                        Tab(
                          text: 'General',
                        ),
                        Tab(text: 'Personal'),
                      ]),
                ),
              ),
              h20,
              Container(
                height: MediaQuery.of(context).size.height*3.9/5,
                child: TabBarView(
                  // physics: NeverScrollableScrollPhysics(),

                  controller: _tabController,
                  children: [
                    General(notificationList: notificationData.where((element) => element['type']=='general').toList()),
                    Personal(notificationList: notificationData.where((element) => element['type']=='personal').toList()),
                  ],
                  //MyClass(id: class_id, school_id: school_id, class_teacher: class_teacher, teacher_subject: teacher_subject, classSub_id: classSub_id,)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
