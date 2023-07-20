import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:medical_app/src/presentation/profile/presentation/profile_page.dart';
import 'package:medical_app/src/presentation/search-near-by/presentation/search_for_page.dart';

import '../../../core/resources/color_manager.dart';
import '../../../core/resources/style_manager.dart';
import '../../../core/resources/value_manager.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key,});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool? _geolocationStatus;
  LocationPermission? _locationPermission;
  Position? _userPosition;

  @override
  void initState() {
    super.initState();
    checkGeolocationStatus();
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

      final _currentPosition= await Geolocator.getCurrentPosition();

      _userPosition = _currentPosition;
      print(_userPosition);

    }
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
              delegate: CustomSliverAppBarDelegate(expandedHeight: 180.0, scaffoldKey: scaffoldKey),
              pinned: true,
            ),
            buildBody(context)
          ],
        ),
        extendBody: true,
      ),
    );
  }

  Widget buildBody(BuildContext context){
    return SliverToBoxAdapter(
      child: Column(
        children: [
          FadeInUp(
            duration: Duration(milliseconds: 500),
              child: FactCarousel()),
          h10,

          FadeInUp(
              duration: Duration(milliseconds: 800),
              child: buildQuickServices()),
          FadeInUp(
              duration: Duration(milliseconds: 1000),
              child: buildPersonalServices()),

          SizedBox(
            height: 300.h,
          )



        ],
      ),
    );
  }

  /// Quick Services...
  Widget buildQuickServices() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 12.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quick Services',style: getMediumStyle(color: ColorManager.black,fontSize: 28.sp),),

          h10,
          Container(
            height: 150.h,
            width: double.infinity,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 12.w),
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  height: 120,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius:BorderRadius.circular(10),
                      color: ColorManager.brightGreen
                  ),
                  child: Stack(
                    children: [
                      Center(child: Image.asset('assets/images/eticket.png')),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: Container(
                            height: 25,
                            width: 90,
                            decoration: BoxDecoration(
                              color: ColorManager.textGrey.withOpacity(0.7),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)
                              ),
                            ),
                            child: Center(
                              child: Text('E-Ticket',style: getMediumStyle(color: ColorManager.white,fontSize: 16),),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                w10,
                Container(
                  height: 120,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius:BorderRadius.circular(10),
                      color: ColorManager.yellowFellow
                  ),
                  child: Stack(
                    children: [
                      Center(child: Image.asset('assets/images/call.png')),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: Container(
                            height: 25,
                            width: 90,
                            decoration: BoxDecoration(
                              color: ColorManager.textGrey.withOpacity(0.7),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)
                              ),
                            ),
                            child: Center(
                              child: Text('Call for test',style: getMediumStyle(color: ColorManager.white,fontSize: 16),),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                w10,
                Container(
                  height: 120,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius:BorderRadius.circular(10),
                      color: ColorManager.blueContainer
                  ),
                  child: Stack(
                    children: [
                      Center(child: Image.asset('assets/images/tele.png')),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: Container(
                            height: 25,
                            width: 120,
                            decoration: BoxDecoration(
                              color: ColorManager.textGrey.withOpacity(0.7),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)
                              ),
                            ),
                            child: Center(
                              child: Text('Telecommunication',style: getMediumStyle(color: ColorManager.white,fontSize: 16),),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                w10,
                Container(
                  height: 120,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius:BorderRadius.circular(10),
                      color: ColorManager.brightPink
                  ),
                  child: Stack(
                    children: [
                      Center(child: Image.asset('assets/images/pharmacy.png')),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: Container(
                            height: 25,
                            width: 90,
                            decoration: BoxDecoration(
                              color: ColorManager.textGrey.withOpacity(0.7),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)
                              ),
                            ),
                            child: Center(
                              child: Text('Pharmacy',style: getMediumStyle(color: ColorManager.white,fontSize: 16),),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Personal Services...
  Widget _personalServices({
    required String name,
    IconData? icon,
    String? img,
}) {
    return Card(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              color: ColorManager.black,
              width: 0.3
          )
      ),
      elevation: 0,
      child: InkWell(
        onTap: () {
          // Add your onTap logic here if needed
        },
        splashColor: ColorManager.primary.withOpacity(0.5),// Customize the splash color
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              icon!=null?FaIcon(icon,size: 34.sp,color: ColorManager.black.withOpacity(0.7),): Image.asset('$img',width: 34.w,height: 34.h,),
              h10,
              name.length<=12?Text('$name',style: getRegularStyle(color: ColorManager.textGrey,fontSize: 16.sp,),):Text('$name',style: getRegularStyle(color: ColorManager.textGrey,fontSize: 12.sp),textAlign: TextAlign.center,)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPersonalServices() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 12.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Personal Services',style: getMediumStyle(color: ColorManager.black,fontSize: 28.sp),),

          h10,
          GridView(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 3/3,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 12.h
            ),
            children: [
              _personalServices(name: 'Prescription', icon: FontAwesomeIcons.filePrescription),
              _personalServices(name: 'Discharge Summary', icon: Icons.sticky_note_2_rounded),
              _personalServices(name: 'Lab', icon: FontAwesomeIcons.microscope),
              _personalServices(name: 'X-Ray', icon: FontAwesomeIcons.xRay),
              _personalServices(name: 'USG', img: 'assets/icons/ultrasound.png'),
              _personalServices(name: 'CT Scan', img: 'assets/icons/tomography.png'),
              _personalServices(name: 'MRI', img:'assets/icons/ct-scan.png'),
              _personalServices(name: 'Sugar', img:'assets/icons/sugar.png'),
              _personalServices(name: 'Blood Pressure', img:'assets/icons/bp.png'),





            ],
          )
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
    final deviceSize = MediaQuery.of(context).size;
    const size = 60;

    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        buildBackground(shrinkOffset, context, scaffoldKey),
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
          onTap: ()=>Get.to(()=>ProfilePage(),transition: Transition.fade),
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
                onTap: ()=>Get.to(()=>SearchNearByPage(),transition: Transition.fadeIn),
                child: Icon(Icons.search,color: ColorManager.black,size: 20,)),
            w20,
            InkWell(
                onTap: (){},
                child: Icon(Icons.notifications_none_outlined,color: ColorManager.black,size: 20,)),
          ],
        ),
      ),
    )

  );

  Widget buildBackground(double shrinkOffset, BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) => Opacity(
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
                  onTap: ()=>Get.to(()=>ProfilePage(),transition: Transition.fade),
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
                    Text('User',style: getMediumStyle(color: ColorManager.black,fontSize: 24),),
                  ],
                ),
                actions: [
                  IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.notifications_none_outlined,color: ColorManager.black,size: 30,))
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: ()=>Get.to(()=>SearchNearByPage(),transition: Transition.fadeIn),
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
                        Text('Search for nearby...',style: getRegularStyle(color: ColorManager.textGrey,fontSize: 15),),
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

class FactCarousel extends StatelessWidget {
  final List<String> imageList = ['assets/images/containers/Tip-Container.png', 'assets/images/containers/Tip-Container 2.png', 'assets/images/containers/Tip-Container-3.png'];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
      items: imageList.map((image) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(image)),
            borderRadius: BorderRadius.circular(20)
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 12.h),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  FaIcon(Icons.lightbulb,color: ColorManager.white,),
                  w10,
                  Text('Did you know?',style: getHeadBoldStyle(color: ColorManager.white,fontSize: 26.sp),),
                ],
              ),
              h12,
              Text('In a day, an average human must drink upto 4L of water.',style: getRegularStyle(color: ColorManager.white,fontSize: 18),maxLines: 3,),
              h12,
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.white,
                  elevation: 5
                ),
                  onPressed: (){},
                  child: Text('Know More',style: getRegularStyle(color: ColorManager.black,fontSize: 18),)
              )

            ],
          ),
          
        );
      }).toList(),
    );
  }



}




