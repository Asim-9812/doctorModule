

import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';
import 'package:medical_app/src/core/resources/style_manager.dart';
import 'package:medical_app/src/dummy_datas/dummy_datas.dart';
import 'package:medical_app/src/presentation/doctor/profile/presentation/profile_page.dart';

import '../../../../core/resources/value_manager.dart';
import '../../../login/domain/model/user.dart';
import '../../../notification/presentation/notification_page.dart';
import '../../../patient/search-near-by/presentation/search_for_page.dart';
import '../../patient_profile/presentation/doctor_patient_profile_page.dart';

class DoctorHomePage extends StatefulWidget {
  final bool isWideScreen;
  final bool isNarrowScreen;
  DoctorHomePage(this.isWideScreen,this.isNarrowScreen);

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, dynamic>> myCircle = closeCircle;

  List<Map<String, dynamic>> myPatients = patientList;

  int currentPage = 0;
  final int rowsPerPage = 5;


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
              _overallStat(),
              h20,
              _myCircle(),
              h20,
              _myTasks(),

              h20,
              _myAppointments(),
              h20,
              h20,
              h20,

              // FadeInUp(
              //     duration: Duration(milliseconds: 700),
              //     child: _buildCircle()),
              // h10,
              _patientTable(),
              h20,
              h20,

              h100,
            ],

          ),
        )
      ),
    );
  }


  Widget _overallStat() {

    return Container(
      height: widget.isWideScreen? 220:180,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          widget.isNarrowScreen?w10:w18,
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    ColorManager.blue,
                    ColorManager.blue,
                    ColorManager.blue.withOpacity(0.9),
                    ColorManager.blue.withOpacity(0.9),
                    ColorManager.blue.withOpacity(0.8),
                    ColorManager.blue.withOpacity(0.8),
                    ColorManager.blue.withOpacity(0.7)
                  ],
                  stops: [0.0,0.65,0.65,0.75,0.75, 0.85,0.85],
                  transform: GradientRotation(5),
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  tileMode: TileMode.repeated
              ),
              borderRadius: BorderRadius.circular(20),

            ),
            margin: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
            padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 18.h),
            height:widget.isWideScreen?200:160.h,
            width: 280.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:ColorManager.white.withOpacity(0.3),
                        ),

                        padding: EdgeInsets.symmetric(vertical: 5.w,horizontal: 10.w),
                        child: FaIcon(Icons.person,color: ColorManager.white,)),
                    w10,
                    Text('Patients',style: getMediumStyle(color: ColorManager.white,fontSize: widget.isWideScreen?24 :widget.isNarrowScreen?18.sp:24.sp),)
                  ],
                ),
                h20,
                Text('Total Patients:',style: getRegularStyle(color: ColorManager.white,fontSize: widget.isWideScreen?18:widget.isNarrowScreen?16.sp:18.sp),),
                h10,
                Text('100',style: getMediumStyle(color: ColorManager.white,fontSize: widget.isWideScreen?40:widget.isNarrowScreen?30.sp:40.sp),),
                h10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('New Patients :',style: getRegularStyle(color: ColorManager.white,fontSize: widget.isWideScreen?18:widget.isNarrowScreen?16.sp:18.sp),),
                    w10,
                    Text('10',style: getMediumStyle(color: ColorManager.white,fontSize: widget.isWideScreen?40:widget.isNarrowScreen?30.sp:40.sp),),
                  ],
                ),

              ],
            ),

          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    ColorManager.primary.withOpacity(0.8),
                    ColorManager.primary.withOpacity(0.8),
                    ColorManager.primary.withOpacity(0.7),
                    ColorManager.primary.withOpacity(0.7),
                    ColorManager.primary.withOpacity(0.6),
                    ColorManager.primary.withOpacity(0.6),
                    ColorManager.primary.withOpacity(0.5)
                  ],
                  stops: [0.0,0.6,0.6, 0.7,0.7,0.8,0.8],
                  transform: GradientRotation(6),
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  tileMode: TileMode.mirror
              ),
              borderRadius: BorderRadius.circular(20),

            ),
            margin: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
            padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 18.h),
            height:160.h,
            width: 280.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:ColorManager.white.withOpacity(0.3),
                        ),

                        padding: EdgeInsets.symmetric(vertical: 5.w,horizontal: 10.w),
                        child: FaIcon(FontAwesomeIcons.notesMedical,color: ColorManager.white,)),
                    w10,
                    Text('Appointments',style: getMediumStyle(color: ColorManager.white,fontSize: widget.isWideScreen?24 :widget.isNarrowScreen?18.sp:24.sp),)
                  ],
                ),
                h20,
                Text('Appointments :',style: getRegularStyle(color: ColorManager.white,fontSize: widget.isWideScreen?18:widget.isNarrowScreen?16.sp:18.sp),),
                h10,
                Text('100',style: getMediumStyle(color: ColorManager.white,fontSize: widget.isWideScreen?40:widget.isNarrowScreen?30.sp:40.sp),),
                h10,
                Text('Last 7 days',style: getRegularStyle(color: ColorManager.white,fontSize: widget.isWideScreen?18:widget.isNarrowScreen?16.sp:18.sp),),

              ],
            ),

          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    ColorManager.orange,
                    ColorManager.orange,
                    ColorManager.orange.withOpacity(0.8),
                    ColorManager.orange.withOpacity(0.8),
                    ColorManager.orange.withOpacity(0.7),
                    ColorManager.orange.withOpacity(0.7),
                    ColorManager.orange.withOpacity(0.6)
                  ],
                  stops: [0.0,0.65,0.65,0.75,0.75, 0.85,0.85],
                  transform: GradientRotation(1),
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  tileMode: TileMode.repeated
              ),
              borderRadius: BorderRadius.circular(20),

            ),
            margin: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
            padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 18.h),
            height:160.h,
            width: 280.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:ColorManager.white.withOpacity(0.3),
                        ),

                        padding: EdgeInsets.symmetric(vertical: 8.w,horizontal: 10.w),
                        child: FaIcon(FontAwesomeIcons.bedPulse,color: ColorManager.white,size: 20,)),
                    w10,
                    Text('Surgical Stats',style: getMediumStyle(color: ColorManager.white,fontSize: widget.isWideScreen?24 :widget.isNarrowScreen?18.sp:24.sp),)
                  ],
                ),
                h20,
                Text('Total Operations :',style: getRegularStyle(color: ColorManager.white,fontSize: widget.isWideScreen?18:widget.isNarrowScreen?16.sp:18.sp),),
                h10,
                Text('10',style: getMediumStyle(color: ColorManager.white,fontSize: widget.isWideScreen?40:widget.isNarrowScreen?30.sp:40.sp),),
                h10,
                Text('Last 7 days',style: getRegularStyle(color: ColorManager.white,fontSize: widget.isWideScreen?18:widget.isNarrowScreen?16.sp:18.sp),),

              ],
            ),

          ),


        ],
      ),
    );
  }


  Widget _myCircle(){
    return Container(

      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 18),
            width: double.infinity,
            decoration: BoxDecoration(
                color: ColorManager.orange.withOpacity(0.4),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                border:Border.all(
                  color: ColorManager.black.withOpacity(0.4)
                )
            ),
            child: Text('My Circle',style: getMediumStyle(color: ColorManager.black,fontSize: 24),),

          ),
          Container(
            decoration: BoxDecoration(
              border: Border.symmetric(
                vertical: BorderSide(
                  color: ColorManager.black.withOpacity(0.5)
                )
              )
            ),
            height: 180,
              width: double.infinity,
              child: ListView.builder(
                itemCount:7,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                itemBuilder: (context , i){
                  return InkWell(
                    onTap: ()=>Get.to(()=>DocProfilePage()),
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorManager.dotGrey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: ColorManager.black.withOpacity(0.5)
                        )
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 8.w),
                      padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 12.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: ColorManager.black,
                            radius: 30.r,
                            child: Icon(Icons.person,color: ColorManager.white,),
                          ),
                          h20,
                          Text('${myCircle[i]['name']}',style: getRegularStyle(color: ColorManager.black,fontSize: 16),),
                          h10,
                          Text('${myCircle[i]['specializeIn']}',style: getRegularStyle(color: ColorManager.black,fontSize: 12),)

                        ],
                      ),
                    ),
                  );
                },
              )

          ),
          InkWell(
            onTap: (){},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 18),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: ColorManager.orange.withOpacity(0.4),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  border:Border.all(
                      color: ColorManager.black.withOpacity(0.4)
                  )
              ),
              child: Center(child: Text('See more',style: getMediumStyle(color: ColorManager.black,fontSize: 24),)),

            ),
          ),
        ],
      ),
    );
  }


  Widget _myTasks(){
    return Container(

      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 18),
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorManager.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('My Tasks',style: getMediumStyle(color: ColorManager.white,fontSize: 24),),
                FaIcon(Icons.add,color: ColorManager.white,),
              ],
            ),

          ),
          Container(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for(int i = 0; i < 3; i++)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 18.h),
                    decoration:BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: ColorManager.black.withOpacity(0.5),
                          width: 0.5
                        ),
                        right: BorderSide(
                            color: ColorManager.black.withOpacity(0.5),
                            width: 0.5
                        ),
                        left: BorderSide(
                            color: ColorManager.black.withOpacity(0.5),
                            width: 0.5
                        ),
                      )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('${i+1}.',style: getRegularStyle(color: ColorManager.black),),
                            w10,
                            Text('${dummyTasks[i]}',style: getRegularStyle(color: ColorManager.black,fontSize: 16),),
                            w10,
                          ],
                        ),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: i%2==0?ColorManager.red.withOpacity(0.4):ColorManager.primary.withOpacity(0.4),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 5.h),
                            child: Text(i%2==0?'High':'Low',style: getRegularStyle(color: ColorManager.black,fontSize: 16))),

                      ],
                    ),
                  )
              ],
            )

          ),
          InkWell(
            onTap: (){},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 12),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  )
              ),
              child: Center(
                  child: Text('See more',style: getMediumStyle(color: ColorManager.white,fontSize: 24),)),

            ),
          ),
        ],
      ),
    );
  }


  Widget _myAppointments(){
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    // Check if width is greater than height
    bool isExtraWide = screenSize.width > 1000;
    return Container(

      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 18),
            width: double.infinity,
            decoration: BoxDecoration(
                color: ColorManager.blue.withOpacity(0.8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )
            ),
            child: Text('My Appointments',style: getMediumStyle(color: ColorManager.white,fontSize: 24),),

          ),
          Container(
              decoration: BoxDecoration(
                  border: Border.symmetric(
                    vertical: BorderSide(
                      color: ColorManager.black.withOpacity(0.4)
                    )
                  )
              ),
              width: double.infinity,
              child: Column(
                children: [
                  for(int i = 0; i< 5;i++)
                  Column(
                    children: [
                      Container(
                        color: ColorManager.dotGrey.withOpacity(0.1),
                        padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 12.h),
                        height: 120.h,
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
                                  Text('25',style: getMediumStyle(color: ColorManager.black,fontSize: isExtraWide?18:widget.isNarrowScreen?18.sp:24),),
                                  h10,
                                  Text('wed',style: getMediumStyle(color: ColorManager.black,fontSize: isExtraWide?14:widget.isNarrowScreen?14.sp:18),)
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
                                          child: Text('10:${40+(i*2)} am',style: getRegularStyle(color: ColorManager.blueText,fontSize: isExtraWide?12:widget.isNarrowScreen?14.sp:16),)),
                                      h16,
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('${appointments[i]['appointmentTitle']}',style: getMediumStyle(color: ColorManager.black,fontSize: isExtraWide?16:widget.isNarrowScreen?18.sp:20),),
                                          h10,
                                          Text('${appointments[i]['patientName']}',style: getRegularStyle(color: ColorManager.black,fontSize: isExtraWide?12:widget.isNarrowScreen?16.sp:18),),
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
                      ),
                      Divider(
                        color: ColorManager.black.withOpacity(0.4),
                      ),
                    ],
                  ),

                ],
              )

          ),
          InkWell(
            onTap: (){},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 12),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: ColorManager.blue.withOpacity(0.8),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  )
              ),
              child: Center(
                  child: Text('See more',style: getMediumStyle(color: ColorManager.white,fontSize: 24),)),

            ),
          ),
        ],
      ),
    );
  }


  Widget _patientTable(){

    int startIndex = currentPage * rowsPerPage;
    int endIndex = (currentPage + 1) * rowsPerPage;

    List<DataRow> rows = patientList.sublist(startIndex, endIndex).map((patient) {
      return DataRow(cells: [
        DataCell(Text((startIndex + patientList.indexOf(patient) + 1).toString())), // Serial Number (S.N.)
        DataCell(Text(patient['name'])),
        DataCell(Text(patient['address'])),
        DataCell(Text(patient['contact'])),
        DataCell(Text(patient['department'])),
        DataCell(Text(patient['gender'])),
        DataCell(IconButton(
          icon: Icon(Icons.remove_red_eye),
          onPressed: ()=>Get.to(()=>DocPatientProfile()),
        )),
      ]);
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Text('My Patients',style: getMediumStyle(color: ColorManager.black),),
        ),
        h20,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingTextStyle: getMediumStyle(color: ColorManager.white,fontSize: 20),
            headingRowColor: MaterialStateColor.resolveWith((states) => ColorManager.primary),
            columns: [
              DataColumn(label: Text('S.N.')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Address')),
              DataColumn(label: Text('Contact')),
              DataColumn(label: Text('Department')),
              DataColumn(label: Text('Gender')),
              DataColumn(label: Text('Action')),
            ],
            rows: rows,
          ),
        ),
        h10,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.navigate_before),
              onPressed: () {
                if (currentPage > 0) {
                  setState(() {
                    currentPage--;
                  });
                }
              },
            ),
            Text('Page ${currentPage + 1}'),
            IconButton(
              icon: Icon(Icons.navigate_next),
              onPressed: () {
                if (endIndex < patientList.length) {
                  setState(() {
                    currentPage++;
                  });
                }
              },
            ),
          ],
        ),
      ],
    );
  }



  ///my patient...
  Widget _buildPatients() {
    return Container(
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
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemCount: myPatients.length,
                shrinkWrap: true,


                itemBuilder: (context,index){
                  return InkWell(
                    onTap: ()=>Get.to(()=>DocPatientProfile()),
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: ColorManager.black.withOpacity(0.5)
                            )
                          ),
                          leading: Card(
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
                          title: Text('${myPatients[index]['name']}',style: getRegularStyle(color: ColorManager.black,fontSize: widget.isWideScreen?20:20.sp),
                        )
                        // Container(
                        //   width: 150.w,
                        //   // padding: EdgeInsets.symmetric(horizontal: 2.w),
                        //   margin: EdgeInsets.symmetric(horizontal: 12.w),
                        //   decoration: BoxDecoration(
                        //     color:ColorManager.lightBlueAccent.withOpacity(0.5),
                        //     borderRadius: BorderRadius.circular(20),
                        //     border: Border.all(
                        //       color: ColorManager.black.withOpacity(0.7),
                        //       width: 0.5
                        //     )
                        //   ),
                        //   child: Column(
                        //     mainAxisSize: MainAxisSize.min,
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     children: [
                        //
                        //       h10,
                        //       Text('${myPatients[index]['name']}',style: getRegularStyle(color: ColorManager.black,fontSize: widget.isWideScreen?20:20.sp),),
                        //       h10,
                        //       if(myPatients[index]['department']!=null)Text('${myPatients[index]['department']}',style: getRegularStyle(color: ColorManager.textGrey,fontSize: widget.isWideScreen?14:14.sp),),
                        //       h10,
                        //       Card(
                        //
                        //        shape: CircleBorder(
                        //          side: BorderSide(
                        //            color: ColorManager.black.withOpacity(0.5),
                        //            width: 0.5
                        //          )
                        //        ),
                        //         child:Padding(
                        //           padding: const EdgeInsets.all(5.0),
                        //           child:FaIcon(Icons.chevron_right,color: ColorManager.black,),
                        //         )
                        //       )
                        //
                        //     ],
                        //   ),
                        // ),
                        ),
                      ),
                    )
                  );
                }
            ),
          ),
        ],
      ),
    );
  }




}

