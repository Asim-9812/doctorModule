import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';
import 'package:medical_app/src/core/resources/style_manager.dart';
import 'package:medical_app/src/core/resources/value_manager.dart';
import 'package:animate_do/animate_do.dart';
import 'package:medical_app/src/app/main_page.dart';
import 'package:medical_app/src/presentation/login/presentation/login_page.dart';

import '../../dashboard/presentation/home_page.dart';
import '../../subscription-plan/presentation/subscription_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  List<String> accountType = ['Professional', 'Patient', 'Merchant'];
  List<String> professionType = ['Doctor', 'Admin', 'Account'];
  List<String> genderType = ['Male', 'Female', 'Other'];
  String selectedAccountType = 'Professional';
  String selectedProfession = 'Doctor';
  String selectedGender = 'Male';
  bool _obscureText = true ;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  final TextEditingController _licenseController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool _isChecked = false;

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
                      style: getSemiBoldHeadStyle(color: Colors.white,fontSize: 40.sp),
                    ),
                    Text(
                      'Create your account',
                      style: getRegularStyle(color: Colors.white,fontSize: 24.sp),
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
                      });
                    },
                  ),
                  if(selectedAccountType == accountType[0])
                    _buildProfessional(),


                  if(selectedAccountType == accountType[1])
                    _buildPatient(),

                  if(selectedAccountType == accountType[2])
                    _buildMerchant(),


                  SizedBox(height: 50.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?',style: getRegularStyle(color: ColorManager.black,fontSize: 18.sp),),
                      TextButton(onPressed: ()=>Get.to(()=>LoginPage(),transition: Transition.fade), child: Text('Login.',style: getRegularStyle(color: ColorManager.blue,fontSize: 18.sp),))
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


  /// For professional account type...

  Widget _buildProfessional() {
    return Column(
      children: [
        SizedBox(
          height: 18.h,
        ),
        DropdownButtonFormField<String>(
          value: selectedProfession,
          decoration: InputDecoration(
            labelText: 'Select Profession',
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
          items: professionType
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
              selectedProfession = value!;
            });
          },
        ),
        SizedBox(
          height: 18.h,
        ),
        TextFormField(
          controller: _licenseController,
          decoration: InputDecoration(
              floatingLabelStyle: getRegularStyle(color: ColorManager.primary),
              labelText: 'License No.',
              labelStyle: getRegularStyle(color: ColorManager.black),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: ColorManager.black
                  )
              )
          ),
        ),
        SizedBox(
          height: 18.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 60.h,
              width: 180.w,
              child: TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                    floatingLabelStyle: getRegularStyle(color: ColorManager.primary),
                    labelText: 'First Name',
                    labelStyle: getRegularStyle(color: ColorManager.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: ColorManager.black
                        )
                    )
                ),
              ),
            ),
            Container(
              height: 60.h,
              width: 180.w,
              child: TextFormField(
                controller: _secondNameController,
                decoration: InputDecoration(
                    floatingLabelStyle: getRegularStyle(color: ColorManager.primary),
                    labelText: 'Last Name',
                    labelStyle: getRegularStyle(color: ColorManager.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: ColorManager.black
                        )
                    )
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 18.h,
        ),

        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
              floatingLabelStyle: getRegularStyle(color: ColorManager.primary),
              labelText: 'E-mail',
              labelStyle: getRegularStyle(color: ColorManager.black),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: ColorManager.black
                  )
              )
          ),
        ),
        SizedBox(
          height: 18.h,
        ),
        TextFormField(
          controller: _mobileController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
              floatingLabelStyle: getRegularStyle(color: ColorManager.primary),
              labelText: 'Mobile Number',
              labelStyle: getRegularStyle(color: ColorManager.black),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: ColorManager.black
                  )
              ),
          ),
        ),

        SizedBox(
          height: 18.h,
        ),
        ElevatedButton(
          onPressed: ()=>Get.to(()=>SubscriptionPage(),transition: Transition.fade),
          style: TextButton.styleFrom(
              backgroundColor: ColorManager.primary,
              foregroundColor: Colors.white,
              fixedSize: Size(380.w, 50.h),
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(10),
              )),
          child: Text(
            'Register',
            style: getMediumStyle(
                color: ColorManager.white,
                fontSize: 24.sp),
          ),
        ),
      ],
    );
  }


  /// For patient account type...

  Widget _buildPatient() {
    String? gender;
    return Column(
      children: [
        SizedBox(
          height: 18.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 60.h,
              width: 180.w,
              child: TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                    floatingLabelStyle: getRegularStyle(color: ColorManager.primary),
                    labelText: 'First Name',
                    labelStyle: getRegularStyle(color: ColorManager.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: ColorManager.black
                        )
                    )
                ),
              ),
            ),
            Container(
              height: 60.h,
              width: 180.w,
              child: TextFormField(
                controller: _secondNameController,
                decoration: InputDecoration(
                    floatingLabelStyle: getRegularStyle(color: ColorManager.primary),
                    labelText: 'Last Name',
                    labelStyle: getRegularStyle(color: ColorManager.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: ColorManager.black
                        )
                    )
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 18.h,
        ),

        DropdownButtonFormField<String>(
          value: selectedGender,
          decoration: InputDecoration(
            labelText: 'Select Gender',
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
          items: genderType
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
              selectedGender = value!;
            });
          },
        ),
        SizedBox(
          height: 18.h,
        ),

        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
              floatingLabelStyle: getRegularStyle(color: ColorManager.primary),
              labelText: 'E-mail',
              labelStyle: getRegularStyle(color: ColorManager.black),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: ColorManager.black
                  )
              )
          ),
        ),
        SizedBox(
          height: 18.h,
        ),
        TextFormField(
          controller: _mobileController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            floatingLabelStyle: getRegularStyle(color: ColorManager.primary),
            labelText: 'Mobile Number',
            labelStyle: getRegularStyle(color: ColorManager.black),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: ColorManager.black
                )
            ),
          ),
        ),
        SizedBox(
          height: 50.h,
        ),
        ElevatedButton(
          onPressed: ()=>Get.to(()=>SubscriptionPage(),transition: Transition.fade),
          style: TextButton.styleFrom(
              backgroundColor: ColorManager.primary,
              foregroundColor: Colors.white,
              fixedSize: Size(380.w, 50.h),
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(10),
              )),
          child: Text(
            'Register',
            style: getMediumStyle(
                color: ColorManager.white,
                fontSize: 24.sp),
          ),
        ),
      ],
    );
  }


  /// For merchant account type...

  Widget _buildMerchant() {
    return Column(
      children: [
        SizedBox(
          height: 18.h,
        ),
        TextFormField(
          controller: _panController,
          decoration: InputDecoration(
              floatingLabelStyle: getRegularStyle(color: ColorManager.primary),
              labelText: 'PAN',
              labelStyle: getRegularStyle(color: ColorManager.black),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: ColorManager.black
                  )
              )
          ),
        ),
        SizedBox(
          height: 18.h,
        ),
        TextFormField(
          controller: _firstNameController,
          decoration: InputDecoration(
              floatingLabelStyle: getRegularStyle(color: ColorManager.primary),
              labelText: 'Name',
              labelStyle: getRegularStyle(color: ColorManager.black),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: ColorManager.black
                  )
              )
          ),
        ),
        SizedBox(
          height: 18.h,
        ),
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
              floatingLabelStyle: getRegularStyle(color: ColorManager.primary),
              labelText: 'E-mail',
              labelStyle: getRegularStyle(color: ColorManager.black),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: ColorManager.black
                  )
              )
          ),
        ),
        SizedBox(
          height: 18.h,
        ),
        TextFormField(
          controller: _mobileController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            floatingLabelStyle: getRegularStyle(color: ColorManager.primary),
            labelText: 'Mobile Number',
            labelStyle: getRegularStyle(color: ColorManager.black),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: ColorManager.black
                )
            ),
          ),
        ),
        SizedBox(
          height: 18.h,
        ),
        TextFormField(
          controller: _passController,
          obscureText: _obscureText,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            floatingLabelStyle: getRegularStyle(color: ColorManager.primary),
            labelText: 'Password',
            labelStyle: getRegularStyle(color: ColorManager.black),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: ColorManager.black
                )
            ),
              suffixIcon: IconButton(
                onPressed: (){
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: _obscureText? FaIcon(CupertinoIcons.eye,color: ColorManager.black,):FaIcon(CupertinoIcons.eye_slash,color: ColorManager.black,),
              )
          ),
        ),
        SizedBox(
          height: 50.h,
        ),
        ElevatedButton(
          onPressed: ()=>Get.to(()=>SubscriptionPage(),transition: Transition.fade),
          style: TextButton.styleFrom(
              backgroundColor: ColorManager.primary,
              foregroundColor: Colors.white,
              fixedSize: Size(380.w, 50.h),
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(10),
              )),
          child: Text(
            'Register',
            style: getMediumStyle(
                color: ColorManager.white,
                fontSize: 24.sp),
          ),
        ),
      ],
    );
  }

}
