import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:medical_app/src/data/model/registered_patient_model.dart';
import 'package:medical_app/src/data/services/registered_patient_services.dart';
import 'package:medical_app/src/data/services/user_services.dart';
import 'package:medical_app/src/presentation/patient/quick_services/presentation/telemedicine.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/style_manager.dart';
import '../../../../core/resources/value_manager.dart';
import '../../../../dummy_datas/dummy_datas.dart';
import '../../../login/domain/model/user.dart';
import '../../../notification/presentation/notification_page.dart';

class OrgHomePage extends StatefulWidget {
  const OrgHomePage({super.key,});

  @override
  State<OrgHomePage> createState() => _OrgHomePageState();
}

class _OrgHomePageState extends State<OrgHomePage> {

  bool? _geolocationStatus;
  LocationPermission? _locationPermission;
  geo.Position? _userPosition;

  List<User> doctors = [];
  List<RegisteredPatientModel> patients = [];



  @override
  void initState() {
    super.initState();
    checkGeolocationStatus();
    _calculateGenderCounts();
    _getDoctorsList();
    _getPatientList();

  }

  ///geolocator settings...

  Future<void> checkGeolocationStatus() async {
    _geolocationStatus = await Geolocator.isLocationServiceEnabled();
    if (_geolocationStatus == LocationPermission.denied) {
      setState(() {
        _geolocationStatus = false;
      });
    } else {
      checkLocationPermission();
    }
  }

  Future<void> checkLocationPermission() async {
    _locationPermission = await Geolocator.requestPermission();
    if (_locationPermission == LocationPermission.denied) {
      print('permission denied');
    } else if (_locationPermission == LocationPermission.deniedForever) {
      print('permission denied');
    } else if (_locationPermission == LocationPermission.always ||
        _locationPermission == LocationPermission.whileInUse) {
      print('permission given');

      final _currentPosition = await Geolocator.getCurrentPosition();

      _userPosition = _currentPosition;
      print(_userPosition);
    }
  }

  void _getDoctorsList() async {
    final List<User> doctorList = await UserService().getDoctors();
    setState(() {
      doctors = doctorList;
    });
  }


  void _getPatientList() async {
    final List<RegisteredPatientModel> patientList = await RegisteredPatientService().getRegisteredPatients();
    setState(() {
      patients = patientList;
    });
    _getTotalPatientsRegisteredToday();
  }

  int _getTotalPatientsRegisteredToday() {
    // Get the current date in the format "yyyy-MM-dd"
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // Filter the patients list based on the entryDate
    List<RegisteredPatientModel> patientsRegisteredToday = patients
        .where((patient) =>
    DateFormat('yyyy-MM-dd').format(patient.entryDate) == currentDate)
        .toList();
    print(patientsRegisteredToday);

    return patientsRegisteredToday.length;
  }

  int _getPatientsRegisteredYesterday() {
    // Get the date for yesterday
    DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
    String yesterdayDate = DateFormat('yyyy-MM-dd').format(yesterday);

    // Filter the patients list based on the entryDate
    List<RegisteredPatientModel> patientsRegisteredYesterday = patients
        .where((patient) =>
    DateFormat('yyyy-MM-dd').format(patient.entryDate) == yesterdayDate)
        .toList();

    // Return the total number of patients registered yesterday
    return patientsRegisteredYesterday.length;
  }


  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();




    return FadeIn(
      duration: Duration(milliseconds: 700),
      child: Scaffold(
        key: scaffoldKey,
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverPersistentHeader(
              delegate: CustomSliverAppBarDelegate(
                  expandedHeight: 180.0, scaffoldKey: scaffoldKey),
              pinned: true,
            ),
            buildBody(context)
          ],
        ),
        extendBody: true,
      ),
    );
  }

  Map<String, int> _calculateGenderCounts() {
    Map<String, int> genderCounts = {
      'Male': 0,
      'Female': 0,
      'Others': 0,
    };

    for (var data in doctors) {
      final gender = data.genderID;
      if (gender == 1) {
        genderCounts['Male'] = (genderCounts['Male'] ?? 0) + 1;
      } else if (gender == 2) {
        genderCounts['Female'] = (genderCounts['Female'] ?? 0) + 1;
      } else {
        genderCounts['Others'] = (genderCounts['Others'] ?? 0) + 1;
      }
    }

    return genderCounts;
  }
  Widget buildBody(BuildContext context) {
    int todayRegisters = _getTotalPatientsRegisteredToday();
    int yesterdayRegisters = _getPatientsRegisteredYesterday();


    double percentageChange = ((todayRegisters - yesterdayRegisters) / yesterdayRegisters) * 100;

    bool isIncrease = percentageChange > 0;

    Map<String, int> genderCounts = _calculateGenderCounts();
    return SliverToBoxAdapter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          h20,
          Container(
            decoration: BoxDecoration(
              color: ColorManager.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: ColorManager.black.withOpacity(0.5),
                width: 0.5
              )
            ),
            margin: EdgeInsets.symmetric(horizontal: 18.w,vertical: 8.h),
            height:200,
            width: 280,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 32.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FaIcon(CupertinoIcons.graph_square,color: ColorManager.primaryDark,),
                      w10,
                      Text('Overall Stat',style: getMediumStyle(color: ColorManager.black,fontSize: 24),)
                    ],
                  ),
                  h20,
                  Text('Total Patients Registered Today :',style: getRegularStyle(color: ColorManager.black,fontSize: 18),),
                  h10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '$todayRegisters',
                        style: getSemiBoldHeadStyle(color: isIncrease ? ColorManager.primary : ColorManager.red.withOpacity(0.8),),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '${percentageChange.abs().toStringAsFixed(1)}% ',
                        style: getRegularStyle(
                          color: isIncrease ? ColorManager.primaryDark : ColorManager.red.withOpacity(0.8),
                          fontSize: 18,
                        ),
                      ),
                      FaIcon(
                        isIncrease ? CupertinoIcons.arrowtriangle_up_fill : CupertinoIcons.arrowtriangle_down_fill,
                        color: isIncrease ? ColorManager.primaryDark : ColorManager.red.withOpacity(0.7),
                        size: 18,
                      ),
                    ],
                  )
                ],
              ),
            ),

          ),
          h20,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Doctors Statistics',style: getMediumStyle(color: ColorManager.black,fontSize: 24),),
                Container(
                  width: 220.w,
                  child: Divider(
                    color: ColorManager.black.withOpacity(0.5),
                    thickness: 0.5,
                  ),
                )
              ],
            ),
          ),
          h10,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
            margin: EdgeInsets.symmetric(horizontal: 18.w,vertical: 8.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border:Border.all(
                color: ColorManager.black.withOpacity(0.5),
                width: 0.5
              )
            ),
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              series: <ChartSeries>[
                ColumnSeries<String, String>(
                  dataSource: genderCounts.keys.toList(),
                  xValueMapper: (String gender, _) => gender,
                  yValueMapper: (String gender, _) => genderCounts[gender]!,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                  pointColorMapper: (String gender, _) {
                    if (gender == 'Male') {
                      return ColorManager.blue.withOpacity(0.7);
                    } else if (gender == 'Female') {
                      return ColorManager.premiumContainer.withOpacity(0.7);
                    } else {
                      return ColorManager.red.withOpacity(0.5);
                    }
                  },
                ),
              ],
            ),
          ),
          h100,
          h100, h100, h100, h100

        ],
      ),
    );
  }

}

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final GlobalKey<ScaffoldState> scaffoldKey;


  const CustomSliverAppBarDelegate( {
    required this.expandedHeight,
    required this.scaffoldKey
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent,) {
    final userBox = Hive.box<User>('session').values.toList();
    String firstName = userBox[0].firstName!;
    final deviceSize = MediaQuery.of(context).size;
    const size = 60;

    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        buildBackground(shrinkOffset, context, scaffoldKey,firstName),
        if(shrinkOffset == 180.0)buildAppBar(shrinkOffset,context),

      ],
    );
  }

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;



  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;


  Widget buildAppBar(double shrinkOffset,BuildContext context) => Opacity(
      opacity: appear(shrinkOffset),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 30.h),
        // height: 40.h,
        color: ColorManager.white,
        child: ListTile(
          leading: InkWell(
            // onTap: ()=>Get.to(()=>ProfilePage(),transition: Transition.fade),
            child: CircleAvatar(
              backgroundColor: ColorManager.black,
              radius: 20,
              child: FaIcon(FontAwesomeIcons.person,color: ColorManager.white,),
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                  // onTap: ()=>Get.to(()=>SearchNearByPage(),transition: Transition.fadeIn),
                  child: Icon(Icons.search,color: ColorManager.black,size: 20,)),
              w20,
              InkWell(
                  onTap: ()=>Get.to(()=>NotificationPage()),
                  child: Icon(Icons.notifications_none_outlined,color: ColorManager.black,size: 20,)),
            ],
          ),
        ),
      )

  );

  Widget buildBackground(double shrinkOffset, BuildContext context, GlobalKey<ScaffoldState> scaffoldKey, String firstName) => Opacity(
    opacity: disappear(shrinkOffset),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.5/5,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: InkWell(
                  // onTap: ()=>Get.to(()=>ProfilePage(),transition: Transition.fade),
                  child: CircleAvatar(
                    backgroundColor: ColorManager.black,
                    child: FaIcon(FontAwesomeIcons.person,color: ColorManager.white,),
                  ),
                ),
                leadingWidth: 40,
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Good Morning,',style: getRegularStyle(color: ColorManager.textGrey,fontSize: 16),),
                    Text('$firstName',style: getMediumStyle(color: ColorManager.black,fontSize: 24),),
                  ],
                ),
                actions: [
                  IconButton(
                      onPressed: ()=>Get.to(()=>NotificationPage()),
                      icon: Icon(Icons.notifications_none_outlined,color: ColorManager.black,size: 30,))
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              // onTap: ()=>Get.to(()=>SearchNearByPage(),transition: Transition.fadeIn),
              splashColor: ColorManager.primary.withOpacity(0.4),
              child: Container(
                  height: 50.h,
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
                          Text('Search...',style: getRegularStyle(color: ColorManager.textGrey,fontSize: 15),),
                        ],
                      ),
                      SizedBox()
                    ],
                  )
              ),
            ),
          ],
        ),
      ),
    ),
  );





  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;



}





