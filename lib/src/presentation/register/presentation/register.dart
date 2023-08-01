import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';
import 'package:medical_app/src/core/resources/style_manager.dart';
import 'package:medical_app/src/core/resources/value_manager.dart';
import 'package:animate_do/animate_do.dart';
import 'package:medical_app/src/presentation/login/presentation/login_page.dart';
import 'package:medical_app/src/presentation/register/data/register_provider.dart';
import 'package:medical_app/src/presentation/register/presentation/register_doctor.dart';
import 'package:medical_app/src/presentation/register/presentation/register_organization.dart';
import 'package:medical_app/src/presentation/register/presentation/register_patient.dart';
import 'package:medical_app/src/presentation/subscription-plan/presentation/test_output.dart';

import '../../../core/api.dart';
import '../../common/snackbar.dart';
import '../../subscription-plan/presentation/subscription_page_organization.dart';
import '../data/data_provider.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  List<String> accountType = ['Select Account Type','Merchant','Organization','Professional','Patient'];
  int accountId =0;
  String selectedAccountType = 'Select Account Type';
  final formKey = GlobalKey<FormState>();
  bool _isChecked = false;
  bool isPostingData = false;
  final dio =Dio();
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return ColorManager.primary;
  }



  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: ColorManager.primaryDark,
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildBody(),
              _buildBody2()

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      height: MediaQuery.of(context).size.height * 1 / 5,
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            top: -120.h,
            left: -60.h,
            child: ZoomIn(
              duration: const Duration(milliseconds: 700),
              child: CircleAvatar(
                backgroundColor: ColorManager.primary.withOpacity(0.5),
                radius: 150.sp,
              ),
            ),
          ),
          Positioned(
            top: -120.h,
            left: -70.h,
            child: ZoomIn(
              duration: const Duration(milliseconds: 500),
              child: CircleAvatar(
                backgroundColor: ColorManager.primary.withOpacity(0.3),
                radius: 220.sp,
              ),
            ),
          ),
          FadeIn(
            duration: const Duration(milliseconds: 700),
            delay: const Duration(milliseconds: 300),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 32.w, bottom: 30.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'REGISTER',
                      style: getSemiBoldHeadStyle(color: Colors.white,fontSize: 30),
                    ),
                    Text(
                      'Create your account',
                      style: getRegularStyle(color: Colors.white,fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody2() {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    // Check if width is greater than height
    bool isWideScreen = screenSize.width > 500;
    bool isNarrowScreen = screenSize.width < 420;

    return SlideInUp(
      duration: const Duration(milliseconds: 700),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        height: MediaQuery.of(context).size.height * 4 / 5,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: FadeIn(
          duration:const Duration(milliseconds: 800),
          delay:const Duration(milliseconds: 500),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  h20,
                  h20,
                  DropdownButtonFormField<String>(
                    validator: (value){
                      if(selectedAccountType == accountType[0]){
                        return 'Please select a account type';
                      }
                      return null;
                    },
                    value: selectedAccountType,
                    decoration: InputDecoration(
                      labelText: 'Select Account Type',
                      labelStyle: getRegularStyle(color: ColorManager.primary),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    items: accountType
                        .map(
                          (String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: getRegularStyle(color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedAccountType = value!;
                        accountId = accountType.indexOf(value);
                      });
                    },
                  ),
                  if(selectedAccountType == accountType[1]||selectedAccountType==accountType[2])
                    RegisterOrganization(accountId: accountId,),


                  if(selectedAccountType == accountType[3])
                    RegisterDoctor(accountId: accountId),

                  if(selectedAccountType == accountType[4])
                    RegisterPatient(accountId:accountId),



                  SizedBox(height: 50.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?',style: getRegularStyle(color: ColorManager.black,fontSize:isNarrowScreen?14: 18),),
                      TextButton(onPressed: ()=>Get.to(()=>LoginPage(),transition: Transition.fade), child: Text('Login.',style: getRegularStyle(color: ColorManager.blue,fontSize:isNarrowScreen?14: 18),))
                    ],
                  ),
                  h100,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }








}
