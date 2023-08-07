
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import '../core/resources/route_manager.dart';



class MyApp extends StatefulWidget {
  MyApp._internal(); // private named constructor
  int appState = 0;
  static final MyApp instance =
      MyApp._internal(); // single instance -- singleton

  factory MyApp() => instance; // factory for the class instance

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, child) {
        return KhaltiScope(
          publicKey: 'test_public_key_d5355c28fd984efabb516a5b832a769e',
          enabledDebugging: true,
          builder: (context,navKey) {
            return GetMaterialApp(
              supportedLocales:const [
                Locale('en', 'US'),
                Locale('ne', 'NP'),
              ] ,
              navigatorKey: navKey,
              localizationsDelegates: const [
                KhaltiLocalizations.delegate,
              ],
              debugShowCheckedModeBanner: false,
              onGenerateRoute: RouteGenerator.getRoute,
              initialRoute: Routes.splashRoute,
            );
          }
        );
      },
    );
  }
}
