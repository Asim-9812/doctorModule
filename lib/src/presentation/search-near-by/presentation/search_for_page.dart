import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:medical_app/src/app/main_page.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';
import 'package:medical_app/src/core/resources/font_manager.dart';
import 'package:medical_app/src/core/resources/style_manager.dart';
import 'package:medical_app/src/dummy_datas/dummy_datas.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../core/resources/value_manager.dart';

class SearchNearByPage extends StatefulWidget {
  const SearchNearByPage({Key? key}) : super(key: key);

  @override
  State<SearchNearByPage> createState() => _SearchNearByPageState();
}

class _SearchNearByPageState extends State<SearchNearByPage> {
  int selectedOption = 0;
  bool? _geolocationStatus;
  LocationPermission? _locationPermission;
  Position? _userPosition;

  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    checkGeolocationStatus().then((_) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        _showAlertDialog();
      });
    });
  }

  /* Geolocator settings & permissions*/

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
    if (_locationPermission == LocationPermission.denied ||
        _locationPermission == LocationPermission.deniedForever) {
      print('permission denied');
      _showPermissionDialog();
      setState(() {
        // Permission denied
      });
    } else if (_locationPermission == LocationPermission.always ||
        _locationPermission == LocationPermission.whileInUse) {
      print('permission given');
      final _currentPosition = await Geolocator.getCurrentPosition();
      _userPosition = _currentPosition;
      print(_userPosition);
      setState(() {
        // Permission given
      });
    }
  }

  /// location permission settings dialog...

  Future<void> _showPermissionDialog() async {
    final result = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(
          'Give Permission',
          style: getMediumStyle(color: ColorManager.textGrey, fontSize: 24),
        ),
        content: Text('Please enable location services to use this feature accurately.'),
        actions: [
          TextButton(
            onPressed: () {
              Get.offAll(() => MainPage());
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              openAppSettings().then((value) => Navigator.of(context).pop()).then((value) => checkLocationPermission());
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
    if (result != null) {
      setState(() {
        selectedOption = result;
      });
    }
  }

  Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
  }

  @override
  Widget build(BuildContext context) {
    print(selectedOption);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: FadeIn(
        duration: Duration(milliseconds: 700),
        child: Scaffold(
          backgroundColor: ColorManager.white.withOpacity(0.95),
          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: 1,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: FaIcon(Icons.chevron_left, color: ColorManager.black),
            ),
            centerTitle: true,
            title: Text(
              'Search',
              style: getMediumStyle(color: ColorManager.black),
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeInUp(
                    duration: Duration(milliseconds: 500),
                    child: _buildSearch()),
                FadeInUp(
                    duration: Duration(milliseconds: 500),
                    delay: Duration(milliseconds: 500),
                    child: _buildBody()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// build search...

  Widget _buildSearch() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.w),
      child: TextFormField(
        // autofocus: true,
        style: getRegularStyle(color: ColorManager.black, fontSize: 20),
        onChanged: (value) {
          setState(() {
            searchQuery = value;
          });
        },
        decoration: InputDecoration(
          hintText: selectedOption == 0
              ? 'Search for Hospital nearby'
              : selectedOption == 1
              ? 'Search for Doctor nearby'
              : selectedOption == 2
              ? 'Search for Ambulance nearby'
              : 'Search for Clinic nearby',
          hintStyle: getRegularStyle(color: ColorManager.textGrey, fontSize: 20),
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
          filled: true,
          fillColor: ColorManager.lightBlueAccent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: ColorManager.blueText, width: 0.5),
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: FaIcon(Icons.search, color: ColorManager.blueText),
          ),
          prefixIconConstraints: BoxConstraints.tight(Size(48, 24)),
          suffixIconConstraints: BoxConstraints.tight(Size(32, 24)),
          suffixIcon: InkWell(
            onTap: () => _showAlertDialog(),
            child: FaIcon(Icons.filter_list, color: ColorManager.blueText),
          ),
        ),
      ),
    );
  }

  /// select search category...

  Future<void> _showAlertDialog() async {
    final result = await showDialog(
      context: context,
      builder: (context) => ZoomIn(
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            'Search for nearby',
            style: getMediumStyle(color: ColorManager.textGrey, fontSize: 24),
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 80,
                    width: 60,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedOption = 0;
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: selectedOption == 0 ? ColorManager.primaryDark : ColorManager.dotGrey),
                              shape: BoxShape.circle,
                              color: selectedOption == 0 ? ColorManager.primary : Colors.transparent,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/icons/hospital.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ),
                          h10,
                          Text(
                            'Hospital',
                            style: getRegularStyle(color: selectedOption == 0 ? ColorManager.black : ColorManager.textGrey, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                  w05,
                  Container(
                    height: 80,
                    width: 60,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedOption = 1;
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: selectedOption == 1 ? ColorManager.primaryDark : ColorManager.dotGrey),
                              shape: BoxShape.circle,
                              color: selectedOption == 1 ? ColorManager.primary : Colors.transparent,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/icons/doctor.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ),
                          h10,
                          Text(
                            'Doctor',
                            style: getRegularStyle(color: selectedOption == 1 ? ColorManager.black : ColorManager.textGrey, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                  w05,
                  Container(
                    height: 80,
                    width: 60,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedOption = 2;
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: selectedOption == 2 ? ColorManager.primaryDark : ColorManager.dotGrey),
                              shape: BoxShape.circle,
                              color: selectedOption == 2 ? ColorManager.primary : Colors.transparent,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/icons/ambulance.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ),
                          h10,
                          Text(
                            'Ambulance',
                            style: getRegularStyle(color: selectedOption == 2 ? ColorManager.black : ColorManager.textGrey, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                  w05,
                  Container(
                    height: 80,
                    width: 60,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedOption = 3;
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: selectedOption == 3 ? ColorManager.primaryDark : ColorManager.dotGrey),
                              shape: BoxShape.circle,
                              color: selectedOption == 3 ? ColorManager.primary : Colors.transparent,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/icons/clinic.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ),
                          h10,
                          Text(
                            'Clinic',
                            style: getRegularStyle(color: selectedOption == 3 ? ColorManager.black : ColorManager.textGrey, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(selectedOption);
              },
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );
    if (result != null) {
      setState(() {
        selectedOption = result;
      });
    }
  }

  /// calculate distance...

  double calculateDistance(double lat1, double lon1, double lat2, double lon2, {bool inKilometers = true}) {
    const double earthRadius = 6371; // Radius of the Earth in kilometers

    double degToRad(double deg) {
      return deg * (pi / 180);
    }

    double dLat = degToRad(lat2 - lat1);
    double dLon = degToRad(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) + cos(degToRad(lat1)) * cos(degToRad(lat2)) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    if (!inKilometers) {
      distance *= 1000; // Convert distance to meters
    }

    return distance;
  }

  /// buildBody....
  Widget _buildBody() {
    List<dynamic> dataList;
    switch (selectedOption) {
      case 0:
        dataList = hospitalInfo;
        break;
      case 1:
        dataList = doctorInfo;
        break;
      case 2:
        dataList = ambulanceInfo;
        break;
      case 3:
        dataList = clinicInfo;
        break;
      default:
        dataList = hospitalInfo;
    }

    final filteredData = dataList.where((item) {
      final name = item['name'].toString().toLowerCase();
      final contact = item['contact'].toString().toLowerCase();
      return name.contains(searchQuery.toLowerCase()) || contact.contains(searchQuery.toLowerCase());
    }).toList();

    return Container(
      height: 500.h,
      width: 380.w,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: filteredData.length,
        itemBuilder: (context, index) {
          double distance = 0.0;

          switch (selectedOption) {
            case 0:
              if (_userPosition != null) {
                final double _distance = calculateDistance(
                  _userPosition!.latitude,
                  _userPosition!.longitude,
                  filteredData[index]['latitude'],
                  filteredData[index]['longitude'],
                );
                distance = _distance;
              }
              return _buildItems(
                icon: 'hospital',
                onTap: () {},
                name: '${filteredData[index]['name']}',
                contact: '${filteredData[index]['contact']}',
                distance: distance.toStringAsFixed(2),
                latitude: filteredData[index]['latitude'],
                longitude: filteredData[index]['longitude'],
              );
            case 1:
              return _buildItems(
                icon: 'doctor',
                onTap: () {},
                name: '${filteredData[index]['name']}',
                contact: '${filteredData[index]['contact']}',
                email: '${filteredData[index]['email']}',
              );
            case 2:
              if (_userPosition != null) {
                final double _distance = calculateDistance(
                  _userPosition!.latitude,
                  _userPosition!.longitude,
                  filteredData[index]['latitude'],
                  filteredData[index]['longitude'],
                );
                distance = _distance;
              }
              return _buildItems(
                icon: 'ambulance',
                onTap: () {},
                name: '${filteredData[index]['name']}',
                contact: '${filteredData[index]['contact']}',
                distance: distance.toStringAsFixed(2),
                latitude: filteredData[index]['latitude'],
                longitude: filteredData[index]['longitude'],
              );
            case 3:
              if (_userPosition != null) {
                final double _distance = calculateDistance(
                  _userPosition!.latitude,
                  _userPosition!.longitude,
                  filteredData[index]['latitude'],
                  filteredData[index]['longitude'],
                );
                distance = _distance;
              }
              return _buildItems(
                icon: 'clinic',
                onTap: () {},
                name: '${filteredData[index]['name']}',
                contact: '${filteredData[index]['contact']}',
                distance: distance.toStringAsFixed(2),
                latitude: filteredData[index]['latitude'],
                longitude: filteredData[index]['longitude'],
              );
            default:
              return SizedBox.shrink();
          }
        },
      ),
    );
  }

  /// build nearby items...

  Widget _buildItems({
    required String icon,
    required VoidCallback onTap,
    required String name,
    String? distance,
    required String contact,
    double? latitude,
    double? longitude,
    String? email,
  }) {
    return Container(
      height: 100.h,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: ColorManager.black.withOpacity(0.3), width: 1),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: ListTile(
        onTap: onTap,
        leading: Image.asset(
          'assets/icons/$icon.png',
          width: 50.w,
          height: 50.h,
        ),
        title: Text(
          '$name',
          style: getRegularStyle(color: ColorManager.black, fontSize: 18),
        ),
        subtitle: distance != null
            ? Text(
          '$distance km away',
          style: getRegularStyle(color: ColorManager.textGrey, fontSize: 14),
        )
            : email != null
            ? Text(
          '$email',
          style: getRegularStyle(color: ColorManager.textGrey, fontSize: 14),
        )
            : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () => CallUtils.openCall('$contact'),
              icon: FaIcon(
                Icons.phone,
                color: ColorManager.primaryOpacity80,
              ),
            ),
            if (distance != null)
              IconButton(
                onPressed: () => MapsLauncher.launchCoordinates(latitude!, longitude!),
                icon: FaIcon(
                  Icons.pin_drop_outlined,
                  color: ColorManager.primaryOpacity80,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class CallUtils {
  CallUtils._();

  static Future<void> openCall(String num) async {
    final Uri phone = Uri(
      scheme: 'tel',
      path: num,
    );
    launchUrl(phone);
  }
}
