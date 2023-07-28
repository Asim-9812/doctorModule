


import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';
import 'package:medical_app/src/core/resources/value_manager.dart';
import 'package:medical_app/src/data/model/country_model.dart';
import 'package:medical_app/src/data/services/country_services.dart';
import 'package:medical_app/src/presentation/patient/quick_services/domain/services/cost_category_services.dart';

import '../../../../core/resources/style_manager.dart';
import '../../../common/snackbar.dart';
import '../domain/model/cost_category_model.dart';

class ETicket extends StatefulWidget {
  const ETicket({super.key});

  @override
  State<ETicket> createState() => _ETicketState();
}

class _ETicketState extends State<ETicket> {
  List<String> genderType = ['Select Gender','Male', 'Female', 'Other'];
  String selectedGender = 'Select Gender';
  int genderId = 0;
  final formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _nidController = TextEditingController();
  final TextEditingController _uhidController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _licenseController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _policyController = TextEditingController();

  List<Country> countries = [];
  int? countryId;
  String? selectedCountry;

  List<ProvinceModel> provinces = [];
  int? provinceId;
  String? selectedProvince;

  List<DistrictModel> districts = [];
  int? districtId;
  String? selectedDistrict;


  List<MunicipalityModel> municipalities = [];
  int? municipalityId;
  String? selectedMunicipality;



  List<CostCategoryModel> costCategory = [];
  int? costId ;
  String? selectedCategory;


  @override
  void initState() {
    super.initState();

    _getCountry();
    _getCostCategory();


  }



  /// fetch country list...
  void _getCountry() async {
    List<Country> countryList = await CountryService().getCountry();
    setState(() {
      countries = countryList;
      selectedCountry = countries.isNotEmpty ? countries[0].countryName : 'Select a country';
      countryId = countries.isNotEmpty ? countries[0].countryId : 0;
    });
    _getProvince();
  }

  /// fetch province list...
  void _getProvince() async {
    List<ProvinceModel> provinceList = await CountryService().getProvince(countryId: countryId!);
    setState(() {
      provinces = provinceList;
      selectedProvince = provinces.isNotEmpty ? provinces[0].provinceName : 'Select a Province';
      provinceId = provinces.isNotEmpty ? provinces[0].provinceId : 0;

    });
    _getDistrict();
  }


  /// fetch district list...

  void _getDistrict() async {

    List<DistrictModel> districtList = await CountryService().getDistrict(provinceId: provinceId!);
    setState(() {
      districts = districtList;
      selectedDistrict = districts.isNotEmpty ? districts[0].districtName : 'Select a District';
      districtId = districts.isNotEmpty ? districts[0].districtId : 0;
    });
    _getMunicipality();
  }


  /// fetch municipality list...

  void _getMunicipality() async {

    List<MunicipalityModel> municipalityList = await CountryService().getMunicipality(districtId: districtId!);
    setState(() {
      municipalities = municipalityList;
      selectedMunicipality = municipalities.isNotEmpty ? municipalities[0].municipalityName : 'Select a Municipality';
      municipalityId = municipalities.isNotEmpty ? municipalities[0].municipalityId : 0;
    });
  }

  ///fetch cost category list...
  void _getCostCategory() async {
    List<CostCategoryModel> costCategoryList = await CostCategoryServices().getCostCategoryList();
    setState(() {
      costCategory = costCategoryList;
      costId =costCategory.isNotEmpty ? costCategory[0].costCategoryID  : 0;
      selectedCategory = costCategory.isNotEmpty ? costCategory[0].costCategoryType : 'Select a category';

    });
  }





  @override
  Widget build(BuildContext context) {
    if (costCategory.isEmpty) {
      // If costCategory is empty, show the loading spinner
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SpinKitDualRing(
            size: 50.sp,
            color: ColorManager.primary,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          backgroundColor: ColorManager.primaryOpacity80,
          elevation: 1,
          leading: IconButton(
            onPressed: ()=>Get.back(),
            icon: FaIcon(Icons.chevron_left,color: ColorManager.white,),
          ),
          title: Text('Register',style: getMediumStyle(color: ColorManager.white),),
        ),
        body: _buildRegistration(),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.w,vertical: 20.h),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              backgroundColor: ColorManager.primaryDark,
              fixedSize: Size.fromHeight(40)
            ),
            onPressed: (){},
            child: Text('Submit'),
          ),
        ),
      ),
    );
  }

  Widget _buildRegistration(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 12.h),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _nameDetails(),
              h20,
              _patientDetails(),
              h20,
              _register(),
              h100,



            ],
          ),
        ),
      ),
    );
  }

  Column _nameDetails(){

    print(costId);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Name',style: getMediumStyle(color: ColorManager.black,fontSize: 18),),
        h10,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 60,
              width: 180,
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
                    hintText: 'First Name',
                    hintStyle: getRegularStyle(color: ColorManager.textGrey),
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
              height: 60,
              width: 180,
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
                    hintText: 'Last Name',
                    hintStyle: getRegularStyle(color: ColorManager.textGrey),
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
        h20,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('National ID',style: getMediumStyle(color: ColorManager.black,fontSize: 18),),
                h10,
                Container(
                  height: 60,
                  width: 180,
                  child: TextFormField(
                    controller: _nidController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value){
                      if (value!.isEmpty) {
                        return 'National ID is required';
                      }
                      if (RegExp(r'^(?=.*?[A-Z])').hasMatch(value)||RegExp(r'^(?=.*?[a-z])').hasMatch(value)||RegExp(r'^(?=.*?[!@#&*~])').hasMatch(value)) {
                        return 'Invalid ID. Only use numbers';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        floatingLabelStyle: getRegularStyle(color: ColorManager.primary),
                        hintText: 'National ID',
                        hintStyle: getRegularStyle(color: ColorManager.textGrey),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Unviersal Health ID',style: getMediumStyle(color: ColorManager.black,fontSize: 18),),
                h10,
                Container(
                  height: 60,
                  width: 180,
                  child: TextFormField(
                    controller: _uhidController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value){
                      if (value!.isEmpty) {
                        return 'ID is required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        floatingLabelStyle: getRegularStyle(color: ColorManager.primary),
                        hintText: 'Universal Health Id',
                        hintStyle: getRegularStyle(color: ColorManager.textGrey),
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
          ],
        ),
        h20,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Registration Details',style: getMediumStyle(color: ColorManager.black,fontSize: 22),),
            Container(
              width: 210,
              child: Divider(
                thickness: 0.5,
                color: ColorManager.black.withOpacity(0.5),
              ),
            )
          ],
        ),
        h20,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Cost Category',style: getMediumStyle(color: ColorManager.black,fontSize: 18),),
                h10,
                Container(
                  height: 60,
                  width: 180,
                  child: DropdownButtonFormField<String>(
                    menuMaxHeight: 400,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    padding: EdgeInsets.zero,
                    value: selectedCategory,
                    validator: (value){
                      if(selectedCategory == 'Select a Category'){
                        return 'Please select a Category';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: ColorManager.black.withOpacity(0.5)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: ColorManager.black.withOpacity(0.5)),
                      ),
                    ),
                    items: costCategory
                        .map(
                          (CostCategoryModel item) => DropdownMenuItem<String>(
                        value: item.costCategoryType,
                        child: Text(
                          item.costCategoryType,
                          style: getRegularStyle(color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedCategory = value!;
                        costId = costCategory.firstWhere(
                              (costCategory) => costCategory.costCategoryType == value,
                          orElse: () => CostCategoryModel(costCategoryID: 0, costCategoryType: '', isActive: false),
                        ).costCategoryID;
                      });
                      print('$costId');
                    },
                  ),
                ),
              ],
            ),

            if(selectedCategory != 'General')
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Policy No.',style: getMediumStyle(color: ColorManager.black,fontSize: 18),),
                h10,
                Container(
                  height: 60,
                  width: 180,
                  child: TextFormField(
                    controller: _policyController,
                    keyboardType: TextInputType.phone,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value){
                      if (value!.isEmpty) {
                        return 'Policy no. is required';
                      }

                      if (RegExp(r'^(?=.*?[A-Z])').hasMatch(value)||RegExp(r'^(?=.*?[a-z])').hasMatch(value)||RegExp(r'^(?=.*?[!@#&*~])').hasMatch(value))  {
                        return 'Please enter a valid Policy no.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        floatingLabelStyle: getRegularStyle(color: ColorManager.primary),
                        labelText: 'Policy No.',
                        labelStyle: getRegularStyle(color: ColorManager.textGrey),
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
          ],
        ),
        h10,


      ],
    );
  }
  
  Column _patientDetails(){

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Patient Details',style: getMediumStyle(color: ColorManager.black,fontSize: 22),),
            Container(
              width: 250,
              child: Divider(
                thickness: 0.5,
                color: ColorManager.black.withOpacity(0.5),
              ),
            )
          ],
        ),
        h20,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('DOB',style: getMediumStyle(color: ColorManager.black,fontSize: 18),),
                h10,
                Container(
                  height: 60,
                  width: 180,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value){
                      if (value!.isEmpty) {
                        return 'ID is required';
                      }
                      return null;
                    },
                    maxLines: 1,
                    controller: _dobController,
                    onTap: () async {
                      DateTime? date = DateTime(1900);
                      FocusScope.of(context)
                          .requestFocus(new FocusNode());

                      date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1818),
                          lastDate: DateTime(1830));

                      _dobController.text =
                      "${date!.year}-${date.month}-${date.day}";

                    },
                    decoration: InputDecoration(
                        hintText: 'DOB',
                        hintStyle: getRegularStyle(color: ColorManager.textGrey),
                        floatingLabelStyle: getRegularStyle(color: ColorManager.primary),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Moblie No.',style: getMediumStyle(color: ColorManager.black,fontSize: 18),),
                h10,
                Container(
                  height: 60,
                  width: 180,
                  child: TextFormField(
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
                      labelStyle: getRegularStyle(color: ColorManager.textGrey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: ColorManager.black
                          )
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        h20,
        Text('Gender',style: getMediumStyle(color: ColorManager.black,fontSize: 18),),
        h10,
        Container(
          height: 60,
          width: 180,
          child: DropdownButtonFormField<String>(

            padding: EdgeInsets.zero,
            value: selectedGender,
            validator: (value){
              if(selectedGender == genderType[0]){
                return 'Please select a Gender';
              }
              return null;
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: ColorManager.black.withOpacity(0.5)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: ColorManager.black.withOpacity(0.5)),
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
        ),
        h20,
        Text('Email',style: getMediumStyle(color: ColorManager.black,fontSize: 18),),
        h10,
        Container(
          height: 60,
          width: 380,
          child: TextFormField(
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
                labelStyle: getRegularStyle(color: ColorManager.textGrey),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: ColorManager.black
                    )
                )
            ),
          ),
        ),
        h20,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Country',style: getMediumStyle(color: ColorManager.black,fontSize: 18),),
                h10,
                Container(
                  height: 60,
                  width: 180,
                  child: DropdownButtonFormField<String>(
                    menuMaxHeight: 400,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    padding: EdgeInsets.zero,
                    value: selectedCountry,
                    validator: (value){
                      if(selectedCountry == 'Select a Country'){
                        return 'Please select a Country';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: ColorManager.black.withOpacity(0.5)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: ColorManager.black.withOpacity(0.5)),
                      ),
                    ),
                    items: countries
                        .map(
                          (Country item) => DropdownMenuItem<String>(
                        value: item.countryName,
                        child: Text(
                          item.countryName,
                          style: getRegularStyle(color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedCountry = value!;
                        countryId = countries.firstWhere(
                              (country) => country.countryName == value,
                          orElse: () => Country(countryId: 0, countryName: '', isActive: false),
                        ).countryId;
                      });
                      _getProvince();
                      _getDistrict();
                      _getMunicipality();

                    },
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Province',style: getMediumStyle(color: ColorManager.black,fontSize: 18),),
                h10,
                Container(
                  height: 60,
                  width: 180,
                  child: DropdownButtonFormField<String>(
                    menuMaxHeight: 400,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    padding: EdgeInsets.zero,
                    value: selectedProvince,
                    validator: (value){
                      if(selectedProvince == 'Select a Country'){
                        return 'Please select a Country';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: ColorManager.black.withOpacity(0.5)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: ColorManager.black.withOpacity(0.5)),
                      ),
                    ),
                    items: provinces.where((element) => element.countryId == countryId)
                        .map(
                          (ProvinceModel item) => DropdownMenuItem<String>(
                        value: item.provinceName,
                        child: Text(
                          item.provinceName,
                          style: getRegularStyle(color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedProvince = value!;
                        provinceId = provinces.firstWhere(
                              (province) => province.provinceName == value,
                          orElse: () => ProvinceModel(provinceId: 0, provinceName: '', isActive: false, countryId: 0),
                        ).provinceId;
                      });
                      _getDistrict();
                      _getMunicipality();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        h20,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('District',style: getMediumStyle(color: ColorManager.black,fontSize: 18),),
                h10,
                Container(
                  height: 60,
                  width: 180,
                  child: DropdownButtonFormField<String>(
                    menuMaxHeight: 400,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    padding: EdgeInsets.zero,
                    value: selectedDistrict,
                    validator: (value){
                      if(selectedDistrict == 'Select a District'){
                        return 'Please select a District';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: ColorManager.black.withOpacity(0.5)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: ColorManager.black.withOpacity(0.5)),
                      ),
                    ),
                    items:districts
                        .map(
                          (DistrictModel item) => DropdownMenuItem<String>(
                        value: item.districtName,
                        child: Text(
                          item.districtName,
                          style: getRegularStyle(color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedDistrict = value!;
                        districtId = districts.firstWhere(
                              (district) => district.districtName == value,
                          orElse: () => DistrictModel(districtId: 0, districtName: '', provinceId: 0, provinceName: ''),
                        ).districtId;
                      });
                      _getMunicipality();
                    },
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Municipality',style: getMediumStyle(color: ColorManager.black,fontSize: 18),),
                h10,
                Container(
                  height: 60,
                  width: 180,
                  child: DropdownButtonFormField<String>(
                    menuMaxHeight: 400,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    padding: EdgeInsets.zero,
                    value: selectedMunicipality,
                    validator: (value){
                      if(selectedMunicipality == 'Select a Municipality'){
                        return 'Please select a Municipality';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: ColorManager.black.withOpacity(0.5)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: ColorManager.black.withOpacity(0.5)),
                      ),
                    ),
                    items:municipalities
                        .map(
                          (MunicipalityModel item) => DropdownMenuItem<String>(
                        value: item.municipalityName,
                        child: Text(
                          item.municipalityName,
                          style: getRegularStyle(color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedMunicipality = value!;
                        municipalityId = municipalities.firstWhere(
                              (municipality) => municipality.municipalityName == value,
                          orElse: () => MunicipalityModel(municipalityId: 0, municipalityName: '', districtId: 0, districtName: ''),
                        ).municipalityId;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),

      ],
    );
  }
  
  Column _register(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Department Details',style: getMediumStyle(color: ColorManager.black,fontSize: 22),),
            Container(
              width: 210,
              child: Divider(
                thickness: 0.5,
                color: ColorManager.black.withOpacity(0.5),
              ),
            )
          ],
        ),
        h20,
        Text('Choose a department',style: getMediumStyle(color: ColorManager.black,fontSize: 18),),

      ],
    );
  }

}
