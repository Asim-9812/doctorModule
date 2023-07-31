
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
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:medical_app/src/data/model/registered_patient_model.dart';
import 'package:medical_app/src/data/services/registered_patient_services.dart';
import 'package:medical_app/src/data/services/user_services.dart';
import 'package:medical_app/src/presentation/patient/quick_services/presentation/telemedicine.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/style_manager.dart';
import '../../../../core/resources/value_manager.dart';
import '../../../../dummy_datas/dummy_datas.dart';
import '../../../../test/test.dart';
import '../../../login/domain/model/user.dart';
import '../../../notification/presentation/notification_page.dart';
import '../../../patient/quick_services/presentation/e_ticket.dart';
import '../../doctor_statistics/presentation/doc_stat_page.dart';

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
    _getDoctorsList();
    _getPatientList();

  }



  Future<void> _refreshData() async {
    // Implement the logic to refresh the data here
    _getDoctorsList();
    _getPatientList();
    // You can add more functions to update other data if needed
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
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: CustomScrollView(
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
        ),
        extendBody: true,
      ),
    );
  }


  Widget buildBody(BuildContext context) {



    return SliverToBoxAdapter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          h20,
          _overallStat(),
          h20,
          _surveyStat(),
          h20,
          Container(
            height: 300,
            width: 180,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: ColorManager.black.withOpacity(0.5),
                    width: 0.5
                )
            ),
            margin: EdgeInsets.symmetric(horizontal: 32.w,vertical: 18.h),
            padding: EdgeInsets.symmetric(vertical: 18.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Patient Groups',style: getMediumStyle(color: ColorManager.black,fontSize: 20),),
                Divider(
                  thickness: 0.5,
                  color: ColorManager.black,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    h10,

                  ],
                )
              ],
            ),
          ),
          h20,

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: ColorManager.black.withOpacity(0.5),
                width: 0.5
              )
            ),
            margin: EdgeInsets.symmetric(horizontal: 32.w,vertical: 18.h),
              child: SfCharts()),
          h100,
          h100, h100, h100, h100

        ],
      ),
    );
  }


  Widget _overallStat() {
    int todayRegisters = _getTotalPatientsRegisteredToday();
    int yesterdayRegisters = _getPatientsRegisteredYesterday();


    double percentageChange = ((todayRegisters - yesterdayRegisters) / yesterdayRegisters) * 100;

    bool isIncrease = percentageChange > 0;
    return Container(
      height: 220,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          w18,
          Container(
            decoration: BoxDecoration(
                color: ColorManager.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: ColorManager.black.withOpacity(0.5),
                    width: 0.5
                )
            ),
            margin: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
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
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FaIcon(CupertinoIcons.graph_square,color: ColorManager.primaryDark,),
                      w10,
                      Text('Overall Patients Stat',style: getMediumStyle(color: ColorManager.black,fontSize: 24),)
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
                  ),
                  h20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Total patients registered :',style: getRegularStyle(color: ColorManager.black),),
                      w10,
                      Text('${patients.length}',style: getRegularStyle(color: ColorManager.black,fontSize: 28),),
                    ],
                  ),
                ],
              ),
            ),

          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
            ),
            margin: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
            height:200,
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 90,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorManager.black.withOpacity(0.5),
                      width: 0.5
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('OPD Patient',style: getMediumStyle(color: ColorManager.black,fontSize: 20),),
                          h16,
                          Text('12',style: getMediumStyle(color: ColorManager.black),),
                        ],
                      ),
                      FaIcon(CupertinoIcons.person_2_alt,color: ColorManager.primary,size: 32,)
                    ],
                  ),
                ),
                Container(
                  height: 90,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorManager.black.withOpacity(0.5),
                      width: 0.5
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Today\'s Operation',style: getMediumStyle(color: ColorManager.black,fontSize: 18),),
                          h16,
                          Text('5',style: getMediumStyle(color: ColorManager.black),),
                        ],
                      ),
                      FaIcon(Icons.emergency,color: ColorManager.yellowFellow,size: 28,)
                    ],
                  ),
                ),

              ],
            ),

          ),
          w20
        ],
      ),
    );
  }

  Column _surveyStat(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Hospital Survey',style: getMediumStyle(color: ColorManager.black,fontSize: 24),),
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
        h20,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 200,
              width: 160,
              margin: EdgeInsets.only(left: 18),
              decoration: BoxDecoration(
                border: Border.all(
                    color: ColorManager.black.withOpacity(0.5),
                    width: 0.5
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 12.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Available Beds ',style: getMediumStyle(color: ColorManager.black,fontSize: 16),),
                      h10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('12',style: getMediumStyle(color: ColorManager.black),),
                          FaIcon(CupertinoIcons.bed_double,color: ColorManager.primary,size: 24,)
                        ],
                      ),
                    ],
                  ),
                  h10,
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total Beds ',style: getMediumStyle(color: ColorManager.black,fontSize: 16),),
                      h10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('100',style: getMediumStyle(color: ColorManager.black),),
                          FaIcon(CupertinoIcons.bed_double_fill,color: ColorManager.blue,size: 24,)
                        ],
                      ),
                    ],
                  ),
                  h20,
                  LinearProgressBar(
                    maxSteps: 100,
                    currentStep: 88,
                    progressColor: ColorManager.primaryOpacity80,
                    backgroundColor: ColorManager.iconGrey.withOpacity(0.2),
                  )

                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: ()=>Get.to(()=>DocStatPage()),
                  child: Container(
                    height: 90,
                    width: 160,
                    margin: EdgeInsets.only(right: 18),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: ColorManager.black.withOpacity(0.5),
                          width: 0.5
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 12.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Available Doctors',style: getMediumStyle(color: ColorManager.black,fontSize: 16),),
                        h10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('${doctors.length}',style: getMediumStyle(color: ColorManager.black),),
                            FaIcon(CupertinoIcons.person,color: ColorManager.primary,size: 24,)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                h20,
                Container(
                  height: 90,
                  width: 160,
                  margin: EdgeInsets.only(right: 18),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: ColorManager.black.withOpacity(0.5),
                        width: 0.5
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 12.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total Ambulance',style: getMediumStyle(color: ColorManager.black,fontSize: 16),),
                      h10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('12',style: getMediumStyle(color: ColorManager.black),),
                          FaIcon(FontAwesomeIcons.ambulance,color: ColorManager.red.withOpacity(0.5),size: 20,)
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
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
                      onPressed: ()=>Get.to(()=>ETicket()),
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

class LinearProgressBar extends StatelessWidget {
  final int maxSteps;
  final int currentStep;
  final Color progressColor;
  final Color backgroundColor;

  LinearProgressBar({
    required this.maxSteps,
    required this.currentStep,
    required this.progressColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    double progress = currentStep.toDouble() / maxSteps.toDouble();
    Color targetColor = ColorManager.brightRed; // Change the target color to red

    // Calculate the interpolated color based on progress
    Color currentColor = Color.lerp(progressColor, targetColor, progress) ??
        Colors.transparent; // If lerp returns null, fallback to transparent

    return LinearProgressIndicator(

      value: progress,
      valueColor: AlwaysStoppedAnimation<Color>(currentColor),
      backgroundColor: backgroundColor,
    );
  }
}



class UserData {
  final DateTime date;
  final int numberOfUsers;
  final String userType;

  UserData(this.date, this.numberOfUsers, this.userType);
}

class SfCharts extends StatefulWidget {
  const SfCharts({super.key});

  @override
  State<SfCharts> createState() => _SfChartsState();
}

class _SfChartsState extends State<SfCharts> {

  final List<UserData> dummyData = [
    UserData(DateTime(2023, 7, 1), 50, 'trial'),
    UserData(DateTime(2023, 7, 2), 60, 'trial'),
    UserData(DateTime(2023, 7, 3), 80, 'trial'),
    UserData(DateTime(2023, 7, 4), 70, 'trial'),
    UserData(DateTime(2023, 7, 1), 30, 'gold'),
    UserData(DateTime(2023, 7, 2), 40, 'gold'),
    UserData(DateTime(2023, 7, 3), 55, 'gold'),
    UserData(DateTime(2023, 7, 4), 50, 'gold'),
    UserData(DateTime(2023, 7, 1), 20, 'silver'),
    UserData(DateTime(2023, 7, 2), 25, 'silver'),
    UserData(DateTime(2023, 7, 3), 35, 'silver'),
    UserData(DateTime(2023, 7, 4), 30, 'silver'),
    UserData(DateTime(2023, 7, 1), 10, 'premium'),
    UserData(DateTime(2023, 7, 2), 15, 'premium'),
    UserData(DateTime(2023, 7, 3), 20, 'premium'),
    UserData(DateTime(2023, 7, 4), 25, 'premium'),
  ];


  List<AreaSeries<UserData, DateTime>> getSeriesData(List<String> userTypes) {
    List<AreaSeries<UserData, DateTime>> seriesList = [];

    for (String userType in userTypes) {
      List<UserData> filteredData =
      dummyData.where((data) => data.userType == userType).toList();
      seriesList.add(AreaSeries<UserData, DateTime>(
        dataSource: filteredData,
        xValueMapper: (UserData data, _) => data.date,
        yValueMapper: (UserData data, _) => data.numberOfUsers,
        name: userType,
        color: _getUserTypeColor(userType),
      ));
    }

    return seriesList;
  }

  Color _getUserTypeColor(String userType) {
    switch (userType) {
      case 'trial':
        return ColorManager.primary.withOpacity(0.5);
      case 'gold':
        return ColorManager.brightYellow.withOpacity(0.8);
      case 'silver':
        return ColorManager.silver.withOpacity(0.99);
      case 'premium':
        return ColorManager.premiumContainer.withOpacity(1);
      default:
        return ColorManager.black.withOpacity(0.5);
    }
  }



  final List<String> userTypes = ['trial', 'gold', 'silver', 'premium'];

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(),
      title: ChartTitle(text: 'Number of Users by User Type'),
      series: getSeriesData(userTypes),
      legend: Legend(
        width: '20%',
        alignment: ChartAlignment.far,
        isVisible: true,
      ),
    );
  }
}



