

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';
import 'package:medical_app/src/core/resources/style_manager.dart';
import 'package:medical_app/src/dummy_datas/dummy_datas.dart';
import 'package:medical_app/src/presentation/doctor/doctor_dashboard/presentation/drawer/drawer_items.dart';
import 'package:medical_app/src/presentation/doctor/profile/presentation/profile_page.dart';

import '../../../../core/resources/value_manager.dart';
import '../../../login/domain/model/user.dart';
import '../../../notification/presentation/notification_page.dart';
import '../../../patient/search-near-by/presentation/search_for_page.dart';

class DoctorHomePage extends StatefulWidget {
  final bool isWideScreen;
  final bool isNarrowScreen;
  DoctorHomePage(this.isWideScreen,this.isNarrowScreen);

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, dynamic>> myCircle = [...closeCircle,
    {
      "name" : 'View all >',
      'picture' : 'assets/icons/group.png',
    }];

  List<Map<String, dynamic>> myPatients = [...patientList,
    {
      "name" : 'View all ',
      'picture' : 'assets/icons/group.png',
    }];


  @override
  Widget build(BuildContext context) {
    final userBox = Hive.box<User>('session').values.toList();
    String firstName = userBox[0].firstName!;
    return FadeIn(
      delay: Duration(milliseconds: 200),
      duration: Duration(milliseconds: 500),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: ColorManager.white,
        endDrawerEnableOpenDragGesture: false,

        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: ColorManager.black),
          backgroundColor: ColorManager.white,
          toolbarHeight: 100,
          leadingWidth: 70,
          leading: Padding(
            padding: EdgeInsets.only(left: 18),
            child: InkWell(
              onTap: ()=>Get.to(()=>DocProfilePage()),
              child: CircleAvatar(
                backgroundColor: ColorManager.black,
                radius: widget.isNarrowScreen? 40 : 40.r,
                child: FaIcon(FontAwesomeIcons.person,color: ColorManager.white,),
              ),
            ),
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Good Morning',style: getRegularStyle(color: ColorManager.textGrey,fontSize: widget.isNarrowScreen? 14.sp:14 ),),
              Text('$firstName',style: getMediumStyle(color: ColorManager.black,fontSize: widget.isNarrowScreen?32.sp:32),),
            ],
          ),
          actions: [
            IconButton(
                onPressed: ()=>Get.to(()=>NotificationPage()),
                icon: Icon(Icons.notifications_none_outlined,color: ColorManager.black,)),

          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                // onTap: ()=>Get.to(()=>SearchNearByPage(),transition: Transition.fadeIn),
                splashColor: ColorManager.primary.withOpacity(0.4),
                child: Center(
                  child: Container(
                      height: 50.h,
                      width: 390.w,
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      decoration: BoxDecoration(
                          color: ColorManager.searchColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color:ColorManager.searchColor,
                              width: 1
                          )
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.search,color: ColorManager.iconGrey,),
                              w10,
                              Text('Search medical...',style: getRegularStyle(color: ColorManager.textGrey,fontSize: widget.isNarrowScreen?15.sp:15),),
                            ],
                          ),
                          SizedBox()
                        ],
                      )
                  ),
                ),
              ),
              h20,
              FadeInUp(
                  duration: Duration(milliseconds: 700),
                  child: _buildCircle()),
              h10,
              FadeInUp(
                  duration: Duration(milliseconds: 900),
                  child: _buildPatients()),
              h20,
              h20,
              h20,
              FadeInUp(
                  duration: Duration(milliseconds: 1200),
                  child: _buildAppointments()),
              h100,
            ],

          ),
        )
      ),
    );
  }

  ///my circle
  Widget _buildCircle() {
    return Container(
      height: 200.h,
      width: double.infinity,
      // color: Colors.red,
      child: Stack(
        children: [
          Center(
            child: Container(
              height: 150.h,
              width: 390.w,
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: ColorManager.white,
                  border: Border.all(
                      color: ColorManager.black.withOpacity(0.5),
                      width: 0.5
                  )
              ),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: myCircle.length,

                  itemBuilder: (context,index){
                    return Container(
                      width: 120.w,
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Card(
                            elevation: 0,
                            shape: CircleBorder(
                                side: BorderSide(
                                    color: ColorManager.black.withOpacity(0.5),
                                    width: 0.5
                                )
                            ),
                            child: CircleAvatar(
                              backgroundColor: ColorManager.primary.withOpacity(0.1),
                              backgroundImage: myCircle[index]['picture']==null
                                  ? AssetImage('assets/icons/user.png')
                                  :AssetImage(myCircle[index]['picture']),
                              radius: 25.r,
                            ),
                          ),
                          h10,
                          Text('${myCircle[index]['name']}',style: getRegularStyle(color: ColorManager.black,fontSize: widget.isNarrowScreen?16.sp:widget.isWideScreen?14:14.sp),)
                        ],
                      ),
                    );
                  }
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 42.w,vertical: 8.h),
            padding: EdgeInsets.only(left: 8.w),
            width: widget.isWideScreen?70:70.w,
            height: 35.h,
            color: ColorManager.white,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text('My Circle',style: getMediumStyle(color: ColorManager.black,fontSize: widget.isNarrowScreen?18.sp:widget.isWideScreen?14:18.sp),)),
          )
        ],
      ),
    );
  }

  ///my patient...
  Widget _buildPatients() {
    return Container(
      height:widget.isWideScreen?300:widget.isNarrowScreen?310.h:280.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      // color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('My Patients',style: getMediumStyle(color: ColorManager.black,fontSize: widget.isNarrowScreen?20.sp:24),),
              Container(
                width: widget.isNarrowScreen?200.w:240.w,
                child: Divider(
                  color: ColorManager.black.withOpacity(0.5),
                  thickness: 0.5,
                ),
              )
            ],
          ),
          h20,
          Container(
            height: widget.isWideScreen? 250:240.h,
            width: 390.w,
            // padding: EdgeInsets.symmetric(horizontal: 8.w),
            // decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(15),
            //     color: ColorManager.white,
            //     border: Border.all(
            //         color: ColorManager.black.withOpacity(0.5),
            //         width: 0.5
            //     )
            // ),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: myPatients.length,


                itemBuilder: (context,index){
                  return InkWell(
                    onTap: (){},
                    child: Container(
                      width: 150.w,
                      // padding: EdgeInsets.symmetric(horizontal: 2.w),
                      margin: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        color:ColorManager.lightBlueAccent.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: ColorManager.black.withOpacity(0.7),
                          width: 0.5
                        )
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Card(
                            elevation: 0,
                            shape: CircleBorder(
                                side: BorderSide(
                                    color: ColorManager.black.withOpacity(0.5),
                                    width: 0.5
                                )
                            ),
                            child:  CircleAvatar(
                              backgroundColor: ColorManager.white,
                              backgroundImage: myPatients[index]['picture']==null
                                  ? AssetImage('assets/icons/user.png')
                                  :AssetImage(myPatients[index]['picture']),
                              radius: 30,
                            ),
                          ),
                          h10,
                          Text('${myPatients[index]['name']}',style: getRegularStyle(color: ColorManager.black,fontSize: widget.isWideScreen?20:20.sp),),
                          h10,
                          if(myPatients[index]['department']!=null)Text('${myPatients[index]['department']}',style: getRegularStyle(color: ColorManager.textGrey,fontSize: widget.isWideScreen?14:14.sp),),
                          h10,
                          Card(

                           shape: CircleBorder(
                             side: BorderSide(
                               color: ColorManager.black.withOpacity(0.5),
                               width: 0.5
                             )
                           ),
                            child:Padding(
                              padding: const EdgeInsets.all(5.0),
                              child:FaIcon(Icons.chevron_right,color: ColorManager.black,),
                            )
                          )

                        ],
                      ),
                    ),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }


  ///my appointments...
  Widget _buildAppointments() {
    return Container(
      // height: 240.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      // color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('My Appointments',style: getMediumStyle(color: ColorManager.black,fontSize:widget.isNarrowScreen? 24.sp:24),),
              Text('View all >',style: getRegularStyle(color: ColorManager.textGrey,fontSize: widget.isWideScreen?18:widget.isNarrowScreen?14.sp:18),),

            ],
          ),
          h20,
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 8,

              itemBuilder: (context,index){

                // Get the screen size
                final screenSize = MediaQuery.of(context).size;

                // Check if width is greater than height
                bool isExtraWide = screenSize.width > 1000;
                final dateString = appointments[index]['appointmentTime'];
                final formatter = DateFormat("yyyy-MM-dd hh:mm a");
                final appointmentDateTime = formatter.parse(dateString);
                final date = DateFormat('dd').format(appointmentDateTime);
                final day = DateFormat('E').format(appointmentDateTime);
                final time = DateFormat('hh:mm a').format(appointmentDateTime);
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 12.h),
                  height: 120.h,
                  width: 380.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: ColorManager.dotGrey.withOpacity(0.1),
                    border: Border.all(
                      color: ColorManager.black.withOpacity(0.5),
                      width: 0.5
                    )
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration:BoxDecoration(
                          color: ColorManager.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: ColorManager.black.withOpacity(0.5),
                                width: 0.5
                            )
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 8.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('$date',style: getMediumStyle(color: ColorManager.black,fontSize: isExtraWide?18:widget.isNarrowScreen?18.sp:24),),
                            h10,
                            Text('$day',style: getMediumStyle(color: ColorManager.black,fontSize: isExtraWide?14:widget.isNarrowScreen?14.sp:18),)
                          ],
                        ),
                      ),
                      w10,
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: ColorManager.blue.withOpacity(0.4),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 5.h),
                                    child: Text('$time',style: getRegularStyle(color: ColorManager.blueText,fontSize: isExtraWide?12:widget.isNarrowScreen?14.sp:16),)),
                                h16,
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(appointments[index]['appointmentTitle'],style: getMediumStyle(color: ColorManager.black,fontSize: isExtraWide?16:widget.isNarrowScreen?18.sp:20),),
                                    h10,
                                    Text(appointments[index]['patientName'],style: getRegularStyle(color: ColorManager.black,fontSize: isExtraWide?12:widget.isNarrowScreen?16.sp:18),),
                                  ],
                                ),

                              ],
                            ),
                            FaIcon(Icons.more_vert,color: ColorManager.black,size: isExtraWide?20:widget.isNarrowScreen?20.sp:24,)
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
          ),
        ],
      ),
    );
  }


}

