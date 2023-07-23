import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';
import 'package:medical_app/src/core/resources/style_manager.dart';
import 'package:medical_app/src/core/resources/value_manager.dart';
import 'package:animate_do/animate_do.dart';
import 'package:medical_app/src/presentation/dashboard/presentation/home_page.dart';
import 'package:medical_app/src/app/main_page.dart';
import 'package:medical_app/src/presentation/register/presentation/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<String> accountType = ['Professional', 'Patient', 'Merchant'];
  String selectedValue = 'Professional';
  bool _obscureText = true ;
  int selectedOption = 0;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

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
        body: Column(
          children: [
            _buildBody(),
            _buildBody2()

          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      height: MediaQuery.of(context).size.height * 1.5 / 5,
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
                padding: EdgeInsets.only(left: 32.w, bottom: 50.h),
                child: Text(
                  'Sign into your Account',
                  style: getSemiBoldHeadStyle(color: Colors.white,fontSize: 40),
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
        height: MediaQuery.of(context).size.height * 3.5 / 5,
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
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                h10,
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 100,
                      width: 80,
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
                                  'assets/icons/org_login.png',
                                  width: selectedOption == 0 ?50:30,
                                  height: selectedOption == 0 ?50:30,
                                ),
                              ),
                            ),
                            h10,
                            Text(
                              'Organization',
                              style: getRegularStyle(color: selectedOption == 0 ? ColorManager.black : ColorManager.textGrey, fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ),
                    w05,
                    Container(
                      height: 100,
                      width: 70,
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
                                  'assets/icons/doctor_login.png',
                                  width: selectedOption == 1 ?50:30,
                                  height: selectedOption == 1 ?50:30,
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
                      height: 100,
                      width: 80,
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
                                  'assets/icons/patient_login.png',
                                  width: selectedOption == 2 ?50:30,
                                  height: selectedOption == 2 ?50:30,
                                ),
                              ),
                            ),
                            h10,
                            Text(
                              'Patient',
                              style: getRegularStyle(color: selectedOption == 2 ? ColorManager.black : ColorManager.textGrey, fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
                h20,
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
                  controller: _passController,
                  obscureText: _obscureText,
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
                  height: 18.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Transform.scale(
                          scale: 1,
                          child: Checkbox(
                            value: _isChecked,
                            onChanged: (value) {
                              _isChecked = !_isChecked;
                              setState(() {});
                            },
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.resolveWith(
                                    (states) => getColor(states)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                        Text(
                          'Remember me',
                          style: getRegularStyle(
                              color: ColorManager.textGrey,
                              fontSize: 16),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () { },
                      child: Text(
                        'Forgot Password?',
                        style: getMediumStyle(
                            color: ColorManager.blue, fontSize: 15),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 18.h,
                ),
                ElevatedButton(
                  onPressed: ()=>Get.to(()=>MainPage(),transition: Transition.fade),
                  style: TextButton.styleFrom(
                      backgroundColor: ColorManager.primary,
                      foregroundColor: Colors.white,
                      fixedSize: Size(380.w, 50.h),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(10),
                      )),
                  child: Text(
                    'Sign In',
                    style: getMediumStyle(
                        color: ColorManager.white,
                        fontSize: 24),
                  ),
                ),
                SizedBox(height: 50.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account yet?',style: getRegularStyle(color: ColorManager.black,fontSize: 18),),
                    TextButton(
                        onPressed: ()=>Get.to(()=>RegisterPage(),transition: Transition.fadeIn),
                        child: Text('Register.',style: getRegularStyle(color: ColorManager.blue,fontSize: 18),))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}
