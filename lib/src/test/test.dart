import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class Test extends StatefulWidget {

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  bool? _geolocationStatus;
  LocationPermission? _locationPermission;

  @override
  void initState() {
    super.initState();
    checkGeolocationStatus();
  }

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
      setState(() {
        // Permission denied
      });
    } else if (_locationPermission == LocationPermission.deniedForever) {
      setState(() {
        // Permission denied forever
      });
    } else if (_locationPermission == LocationPermission.always ||
        _locationPermission == LocationPermission.whileInUse) {
      setState(() {
        // Permission given
      });
    }
  }

  Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (_locationPermission == LocationPermission.denied)
            Column(
              children: [
                Text('Permission denied'),
                ElevatedButton(
                  onPressed: () {
                    checkLocationPermission();
                  },
                  child: Text('Ask for permission again'),
                ),
              ],
            ),
          if (_locationPermission == LocationPermission.deniedForever)
            Column(
              children: [
                Text('Permission denied forever. Please give access from settings'),
                ElevatedButton(
                  onPressed: () {
                    openAppSettings();
                  },
                  child: Text('Open Settings'),
                ),
              ],
            ),
          if (_locationPermission == LocationPermission.always ||
              _locationPermission == LocationPermission.whileInUse)
            Text('Permission given'),
        ],
      ),
    );
  }
}
