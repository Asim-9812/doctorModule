


import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/resources/color_manager.dart';
import '../../../core/resources/style_manager.dart';
import '../../../core/resources/value_manager.dart';

class BSA extends StatefulWidget {
  const BSA({super.key});

  @override
  State<BSA> createState() => _BSAState();
}

class _BSAState extends State<BSA> {
  int frequency = 0;
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _cmController = TextEditingController();
  final TextEditingController _ftController = TextEditingController();
  final TextEditingController _inchController = TextEditingController();
  final TextEditingController _dosageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int format = 1;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    // Check if width is greater than height
    bool isWideScreen = screenSize.width > 500;
    bool isNarrowScreen = screenSize.width < 380;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: ColorManager.white.withOpacity(0.99),
        appBar: AppBar(
          elevation: 1,
          backgroundColor: ColorManager.white,
          leading: IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.chevron_left,color: Colors.black,)),
          title: Text('BSA based Dosage',style: getMediumStyle(color: ColorManager.black,fontSize: isNarrowScreen? 24.sp:28),),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  h20,
                  Text('1. Patient\'s weight in KG?',style: getRegularStyle(color: ColorManager.black),),
                  h10,
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
                    color: ColorManager.dotGrey.withOpacity(0.2),
                    child: TextFormField(
                      controller: _weightController,
                      keyboardType: TextInputType.phone,
                      style: getMediumStyle(color: ColorManager.black),
                      decoration: InputDecoration(
                          border: UnderlineInputBorder()
                      ),
                    ),
                  ),
                  h20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('2. Patient\'s height?',style: getRegularStyle(color: ColorManager.black),),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 50.w,
                                child: Radio<int>(
                                  value: 1,
                                  groupValue: format,
                                  onChanged: (value) {
                                    setState(() {
                                      format = value!;
                                    });
                                  },
                                ),
                              ),
                              Text('In CM')
                            ],
                          ),
                          w20,
                          Column(
                            children: [
                              Container(
                                width: 50.w,
                                child: Radio<int>(
                                  value: 2,
                                  groupValue: format,
                                  onChanged: (value) {
                                    setState(() {
                                      format = value!;
                                    });
                                  },
                                ),
                              ),
                              Text('In ft/inch')
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  h10,
                  format ==1

                 ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
                    color: ColorManager.dotGrey.withOpacity(0.2),
                    child: TextFormField(
                      controller: _cmController,
                      keyboardType: TextInputType.phone,
                      style: getMediumStyle(color: ColorManager.black),
                      decoration: InputDecoration(
                          border: UnderlineInputBorder()
                      ),
                    ),
                  )
                 : Row(
                   children: [
                     Container(
                       width: 50,
                        padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
                        color: ColorManager.dotGrey.withOpacity(0.2),
                        child: TextFormField(
                          controller: _ftController,
                          keyboardType: TextInputType.phone,
                          style: getMediumStyle(color: ColorManager.black),
                          decoration: InputDecoration(
                              border: UnderlineInputBorder()
                          ),
                            inputFormatters: [LengthLimitingTextInputFormatter(1)],

                        ),
                      ),
                     w10,
                     Text('ft',style: getMediumStyle(color: ColorManager.black),),
                     w20,
                     Container(
                       width: 50,
                        padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
                        color: ColorManager.dotGrey.withOpacity(0.2),
                        child: TextFormField(
                          controller: _inchController,
                          keyboardType: TextInputType.phone,
                          style: getMediumStyle(color: ColorManager.black),
                          decoration: InputDecoration(
                              border: UnderlineInputBorder()
                          ),
                          inputFormatters: [LengthLimitingTextInputFormatter(2)],
                        ),
                      ),
                     w10,
                     Text('in',style: getMediumStyle(color: ColorManager.black),),
                   ],
                 ),
                  h20,
                  Text('3. Recommended dosage per mg/m²?',style: getRegularStyle(color: ColorManager.black),),
                  h10,
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
                    color: ColorManager.dotGrey.withOpacity(0.2),
                    child: TextFormField(
                      controller: _dosageController,
                      keyboardType: TextInputType.phone,
                      style: getMediumStyle(color: ColorManager.black),
                      decoration: InputDecoration(
                          border: UnderlineInputBorder()
                      ),
                    ),
                  ),
                  h20,

                  Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size.fromWidth(300)
                        ),
                        onPressed: ()=>_calculateDose(w: double.parse(_weightController.text), d: double.parse(_dosageController.text), c:format ==1 ?double.parse(_cmController.text):null,ft: format==2?int.parse(_ftController.text):null,inch: format==2?int.parse(_inchController.text):null),
                        child: Text('Calculate',style: getMediumStyle(color: ColorManager.white,fontSize: 16),)),
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
  _calculateDose({
    required double w,
    required double d,
    double? c,
    int? ft,
    int? inch

  }){
    final screenSize = MediaQuery.of(context).size;

    // Check if width is greater than height
    bool isWideScreen = screenSize.width > 500;
    bool isNarrowScreen = screenSize.width < 380;
    double cm =0.0;
    if(c != null){
      cm = c;
    } else if(ft !=null && inch != null){
      cm = ((ft * 12) + inch)*2.54;
    }

    final bsa  = 0.007184 * pow(cm, 0.725) * pow(w, 0.425);
    final total = d*(bsa/1.73);
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            backgroundColor: ColorManager.white.withOpacity(0.7),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: isWideScreen? 300:300.w,
                  decoration: BoxDecoration(
                      color: ColorManager.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: ColorManager.black.withOpacity(0.7),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 12.h),
                        child: Text('Calculated amount per single dose',style: getMediumStyle(color: ColorManager.white),),
                      ),
                      h20,
                      Text('${total.toPrecision(2)} mg',style: getMediumStyle(color: ColorManager.white),),
                      h20,
                    ],
                  ),
                ),
                h20,
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size.fromWidth(300)
                    ),
                    onPressed: ()=>Navigator.pop(context), child: Text('OK')),



              ],
            ),
          );
        }
    );
  }
}
