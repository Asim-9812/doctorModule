



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:medical_app/src/core/resources/style_manager.dart';
import 'package:medical_app/src/data/services/payment_services.dart';

import '../core/resources/value_manager.dart';
import '../presentation/common/snackbar.dart';


class Test extends ConsumerStatefulWidget {
  const Test({super.key});

  @override
  ConsumerState<Test> createState() => _TestState();
}

class _TestState extends ConsumerState<Test> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _successController;
  late final AnimationController _failedController;

  String? loadingString;
  int loadingStatus = 0;
  bool success = false;


  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: ColorManager.white,
      body: ElevatedButton(
        onPressed: (){
          payWithKhaltiInApp();
        },
        child: Text('PAY'),
      ),
    );
  }

  payWithKhaltiInApp(){
    final config = PaymentConfig(
      amount: 10000, // Amount should be in paisa
      productIdentity: 'dell-g5-g5510-2021',
      productName: 'Dell G5 G5510 2021',
      productUrl: 'https://www.khalti.com/#/bazaar',
    );

    KhaltiScope.of(context).pay(
        config: config,
        preferences: [
          PaymentPreference.khalti
        ],
        onSuccess: onSuccess,
        onFailure: onFailure,
      onCancel: onCancel
    );
  }
  void onSuccess(PaymentSuccessModel success) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (context, setState) {
              return FutureBuilder(
                future: ref
                    .read(verificationProvider)
                    .VerificationProcess(token: success.token, amount: success.amount),
                builder: (context, snapshot) {
                  String localLoadingString = loadingString ?? 'Please wait. Verification in process...';
                  int localLoadingStatus = loadingStatus;

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While waiting for the future to complete, show loading animation
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Lottie.asset('assets/jsons/loading.json', repeat: true),
                          h20,
                          Text(
                            '$localLoadingString',
                            style: getRegularStyle(color: ColorManager.black),
                          ),
                          h20,
                          h20,
                          h20,
                          if (localLoadingStatus != 0)
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK'),
                            ),
                        ],
                      ),
                    );
                  } else {
                    // After the future is completed, handle success or failure
                    if (snapshot.hasError) {
                      // If there is an error, show failed animation
                      localLoadingString = 'Payment Failed';
                      localLoadingStatus = 2;
                      print('$localLoadingString $localLoadingStatus');
                    } else {
                      // If the future is successful, show success animation
                      localLoadingString = 'Payment Successful';
                      localLoadingStatus = 1;
                      print('$localLoadingString $localLoadingStatus');
                    }
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          localLoadingStatus == 1
                              ? Lottie.asset('assets/jsons/success.json', repeat: false)
                              : localLoadingStatus == 2
                              ? Lottie.asset('assets/jsons/failed.json', repeat: false)
                              : Lottie.asset('assets/jsons/loading.json', repeat: false),
                          h20,
                          Text(
                            '$localLoadingString',
                            style: getRegularStyle(color: ColorManager.black),
                          ),
                          h20,
                          h20,
                          h20,
                          if (localLoadingStatus != 0)
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK'),
                            ),
                        ],
                      ),
                    );
                  }
                },
              );
            },
          ),
        );
      },
    );
  }



  void onFailure(PaymentFailureModel failure) {
    setState(() {
      loadingString = 'Payment Failed';
      loadingStatus = 2;
    });
    print('$loadingString $loadingStatus');

    final scaffoldMessage = ScaffoldMessenger.of(context);
    debugPrint(failure.toString());
    scaffoldMessage.showSnackBar(
      SnackbarUtil.showFailureSnackbar(
        message: '${failure.toString()}',
        duration: const Duration(milliseconds: 1200),
      ),
    );
  }
  void onCancel(){
    final scaffoldMessage = ScaffoldMessenger.of(context);
    scaffoldMessage.showSnackBar(
        SnackbarUtil.showFailureSnackbar(
            message: 'Payment Cancelled',
            duration: const Duration(milliseconds: 1200)
        )
    );
  }

}
