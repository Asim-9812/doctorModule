

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_app/src/presentation/login/presentation/login_page.dart';
import 'package:medical_app/src/presentation/login/presentation/status_page.dart';

import 'package:page_transition/page_transition.dart';

import '../../core/resources/color_manager.dart';

class SplashView extends ConsumerWidget {
  const SplashView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        )
    );

    return AnimatedSplashScreen(
      backgroundColor: ColorManager.primaryDark,
      splash: 'assets/images/splash.gif',
      nextScreen: StatusPage(),
      splashIconSize: 360.h,
      centered: true,
      curve: Curves.easeInOut,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      duration: 3000,

    );
  }
}
