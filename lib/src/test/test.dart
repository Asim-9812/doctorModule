import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:medical_app/src/core/utils/shimmer.dart';

class Test extends StatefulWidget {

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  bool? _geolocationStatus;
  LocationPermission? _locationPermission;


  @override
  Widget build(BuildContext context) {
    return buildShimmerEffect();
  }
}
