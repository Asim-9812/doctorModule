



import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:medical_app/src/presentation/register/domain/register_model/register_model.dart';
import 'package:medical_app/src/presentation/subscription-plan/presentation/subscription_page_doctor.dart';

import '../../../core/api.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/style_manager.dart';
import '../../common/snackbar.dart';
import '../../subscription-plan/presentation/subscription_page_organization.dart';
import '../data/register_provider.dart';

class RegisterDoctor extends ConsumerStatefulWidget {
  final int accountId;
  RegisterDoctor({required this.accountId});

  @override
  ConsumerState<RegisterDoctor> createState() => _RegisterOrganizationState();
}

class _RegisterOrganizationState extends ConsumerState<RegisterDoctor> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passController = TextEditingController();
  final TextEditingController _licenseController = TextEditingController();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  int professionId = 0;
  List<String> professionType = ['Select Profession Type','Doctor', 'Admin', 'Account'];
  List<String> genderType = ['Select Gender','Male', 'Female'];


  String selectedProfession = 'Select Profession Type';
  String selectedGender = 'Select Gender';
  int genderId = 0;


  bool _obscureText = true ;
  bool _isChecked = false;

  bool isPostingData = false;

  final dio =Dio();

  RegisterDoctorModel? registerDoctorModel;

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

  Map<String,dynamic> outputValue = {};



  @override
  Widget build(BuildContext context) {
    return _buildProfessional();
  }

  Widget _buildProfessional() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          SizedBox(
            height: 18.h,
          ),
          DropdownButtonFormField<String>(
            validator: (value){
              if(selectedProfession == professionType[0]){
                return 'Please select a Profession';
              }
              return null;
            },
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
                professionId = professionType.indexOf(value);
              });
            },
          ),
          SizedBox(
            height: 18.h,
          ),
          TextFormField(
            controller: _licenseController,
            keyboardType: TextInputType.phone,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value){
              if (value!.isEmpty) {
                return 'License is required';
              }

              if (RegExp(r'^(?=.*?[A-Z])').hasMatch(value)||RegExp(r'^(?=.*?[a-z])').hasMatch(value)||RegExp(r'^(?=.*?[!@#&*~])').hasMatch(value))  {
                return 'Please enter a valid Mobile Number';
              }
              return null;
            },
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value){
                    if (value!.isEmpty) {
                      return 'First Name is required';
                    }
                    if (RegExp(r'^(?=.*?[0-9])').hasMatch(value)||RegExp(r'^(?=.*?[!@#&*~])').hasMatch(value)) {
                      return 'Invalid Name. Only use letters';
                    }
                    return null;
                  },
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
                  controller: _lastNameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value){
                    if (value!.isEmpty) {
                      return 'Last Name is required';
                    }
                    if (RegExp(r'^(?=.*?[0-9])').hasMatch(value)||RegExp(r'^(?=.*?[!@#&*~])').hasMatch(value)) {
                      return 'Invalid Name. Only use letters';
                    }
                    return null;
                  },
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
            validator: (value){
              if(selectedGender == genderType[0]){
                return 'Please select a Gender';
              }
              return null;
            },
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
                genderId = genderType.indexOf(value);
              });
            },
          ),
          SizedBox(
            height: 18.h,
          ),

          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode:
            AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Email is required';
              }
              if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value){
              if (value!.isEmpty) {
                return 'Mobile number is required';
              }
              if (value.length!=10) {
                return 'Enter a valid number';
              }

              if (RegExp(r'^(?=.*?[A-Z])').hasMatch(value)||RegExp(r'^(?=.*?[a-z])').hasMatch(value)||RegExp(r'^(?=.*?[!@#&*~])').hasMatch(value))  {
                return 'Please enter a valid Mobile Number';
              }
              return null;
            },
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Password is required';
              }
              if (value.length < 6) {
                return 'Enter minimum 6 characters';
              }
              if (value.contains(' ')) {
                return 'Do not enter spaces';
              }
              if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(value)) {
                return 'Enter at least one uppercase letter';
              }
              if (!RegExp(r'^(?=.*?[a-z])').hasMatch(value)) {
                return 'Enter at least one lowercase letter';
              }
              if (!RegExp(r'^(?=.*?[0-9])').hasMatch(value)) {
                return 'Enter at least one Digit';
              }
              if (!RegExp(r'^(?=.*?[!@#&*~])').hasMatch(value)) {
                return 'Enter at least one special character';
              }
              return null;
            },
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
          ElevatedButton(
            onPressed: () async {
              if(formKey.currentState!.validate()){
                final scaffoldMessage = ScaffoldMessenger.of(context);
                registerDoctorModel = RegisterDoctorModel(
                    licenseNo:int.parse(_licenseController.text.trim()),
                    genderId: genderId,
                    contactNo: _mobileController.text.trim(),
                    password: _passController.text.trim(),
                    email: _emailController.text.trim(),
                    lastName: _lastNameController.text.trim(),
                    firstName: _firstNameController.text.trim()
                );
                scaffoldMessage.showSnackBar(
                  SnackbarUtil.showProcessSnackbar(
                      message: 'Please select a plan',
                      duration: const Duration(seconds: 2)
                  ),
                );
                Get.to(()=>SubscriptionPageDoctor(registerDoctorModel: registerDoctorModel!));

              }

            },
            //()=>Get.to(()=>SubscriptionPage(),transition: Transition.fade),
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
                  fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
