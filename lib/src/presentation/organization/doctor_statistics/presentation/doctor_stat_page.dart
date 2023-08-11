



import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';
import 'package:medical_app/src/presentation/organization/charts_graphs/doctor_charts.dart';
import 'package:medical_app/src/presentation/organization/doctor_statistics/presentation/operation_tbl.dart';

import '../../../../core/resources/style_manager.dart';
import '../../../../core/resources/value_manager.dart';
import '../../../../dummy_datas/dummy_datas.dart';

class DoctorReportsPage extends StatefulWidget {
  final bool isWideScreen;
  final bool isNarrowScreen;
  DoctorReportsPage(this.isWideScreen,this.isNarrowScreen);

  @override
  State<DoctorReportsPage> createState() => _DoctorReportsPageState();
}

class _DoctorReportsPageState extends State<DoctorReportsPage> with TickerProviderStateMixin{
  
  bool _isExpanded = false;
  bool _isExpanded2 = false;
  bool _isExpanded3 = false;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.blue.withOpacity(0.7),
        centerTitle: true,
        title: Text('Doctors',style: getMediumStyle(color: ColorManager.white,fontSize: 24),),
        actions: [
          IconButton(onPressed: (){}, icon: FaIcon(Icons.search))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            h20,
            _overallStat(),
            h20,
            _charts(),
            h20,
           _tabBar(),
            h100,
          ],
        ),
      )
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
                        child: FaIcon(Icons.health_and_safety,color: ColorManager.white,)),
                    w10,
                    Text('Doctors',style: getMediumStyle(color: ColorManager.white,fontSize: widget.isWideScreen?24 :widget.isNarrowScreen?18.sp:24.sp),)
                  ],
                ),
                h20,
                Text('Available Doctors:',style: getRegularStyle(color: ColorManager.white,fontSize: widget.isWideScreen?18:widget.isNarrowScreen?16.sp:18.sp),),
                h10,
                Text('10',style: getMediumStyle(color: ColorManager.white,fontSize: widget.isWideScreen?40:widget.isNarrowScreen?30.sp:40.sp),),
                h10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Total Doctors :',style: getRegularStyle(color: ColorManager.white,fontSize: widget.isWideScreen?18:widget.isNarrowScreen?16.sp:18.sp),),
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
  
  
  Widget _charts(){
    return Container(

      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
      child: Column(
        children: [
          Text('Doctors Statistics',
            style: getMediumStyle(color: Colors.black, fontSize: 20),),
          h10,
          Container(
            decoration: BoxDecoration(
                color: ColorManager.blue.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: ColorManager.black.withOpacity(0.5)
                )
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: ExpansionPanelList(
                expandIconColor: ColorManager.primaryDark,
                elevation: 0,
                expandedHeaderPadding: EdgeInsets.zero,
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    _isExpanded = !_isExpanded; // Toggle the expansion state
                  });
                },
                children: [
                  ExpansionPanel(
                    isExpanded: _isExpanded,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(

                        onTap: () {
                          setState(() {
                            _isExpanded =
                            !_isExpanded; // Toggle the expansion state
                          });
                        },
                        title: Text('Total Doctors', style: getMediumStyle(
                            color: ColorManager.black, fontSize: 20)),
                      ); // Empty header, handled above
                    },
                    body: Container(
                      width: double.infinity,
                      height: 450,
                      child: DoctorCharts(),
                    ),
                  ),

                ]


            ),
          ),
          h10,
          Container(
            decoration: BoxDecoration(
                color: ColorManager.primaryDark,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: ColorManager.black.withOpacity(0.5)
                )
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: ExpansionPanelList(
                expandIconColor: ColorManager.primaryDark,
                elevation: 0,
                expandedHeaderPadding: EdgeInsets.zero,
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    _isExpanded2 = !_isExpanded2; // Toggle the expansion state
                  });
                },
                children: [
                  ExpansionPanel(
                    isExpanded: _isExpanded2,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        onTap: () {
                          setState(() {
                            _isExpanded2 =
                            !_isExpanded2; // Toggle the expansion state
                          });
                        },
                        title: Text('Department Wise', style: getMediumStyle(
                            color: ColorManager.black, fontSize: 20)),
                      ); // Empty header, handled above
                    },
                    body: Container(
                        width: double.infinity,
                        height: 450,
                        child: DepartmentChart()
                    ),
                  ),

                ]


            ),
          ),
          h10,
          Container(
            decoration: BoxDecoration(
                color: ColorManager.orange.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: ColorManager.black.withOpacity(0.5)
                )
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: ExpansionPanelList(
                expandIconColor: ColorManager.primaryDark,
                elevation: 0,
                expandedHeaderPadding: EdgeInsets.zero,
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    _isExpanded3 = !_isExpanded3; // Toggle the expansion state
                  });
                },
                children: [
                  ExpansionPanel(
                    isExpanded: _isExpanded3,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        onTap: () {
                          setState(() {
                            _isExpanded3 = !_isExpanded3; // Toggle the expansion state
                          });
                        },
                        title: Text('Surgical Statistics', style: getMediumStyle(
                            color: ColorManager.black, fontSize: 20)),
                      ); // Empty header, handled above
                    },
                    body: Container(
                        width: double.infinity,
                        height: 450,
                        child: SurgeryChart()
                    ),
                  ),

                ]


            ),
          ),
        ],
      ),
    );
  }

  Widget _tabBar(){
    TabController _tabBarController = TabController(length: 2, vsync: this);
    return  Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
          decoration: BoxDecoration(
            color: ColorManager.dotGrey.withOpacity(0.2),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10)
            )

          ),
          child: TabBar(
              controller: _tabBarController,
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
                  color: ColorManager.blue.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10)),
              tabs: [
                Tab(
                  text: 'Operations',
                ),
                Tab(text: 'Appointments'),
              ]),
        ),
        SizedBox(
          height: 400,
          child: TabBarView(
            controller: _tabBarController,
            children: [
              OperationTable(),
              OperationTable(),

            ]
          ),
        )
      ],
    );
  }
  
}
