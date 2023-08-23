import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';
import 'package:medical_app/src/core/resources/string_manager.dart';
import 'package:medical_app/src/test/test2.dart';

import '../core/resources/style_manager.dart';
import '../core/resources/value_manager.dart';
import '../presentation/widgets/list_of_bmi_category/bmi_list.dart';


class TEST extends StatefulWidget {
  @override
  TESTState createState() => TESTState();
}

class TESTState extends State<TEST> {
  double _linePositionY = 200.0;
  double y = 0.4; // Initial Y position of the line
  int selectedOption = 1;
  final TextEditingController weightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  // final TextEditingController inchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  double result = 0.0;
  List bmiList = bmiCategories;
  int category = 0;
  int unit =1;
  int invalidType = 0;
  int invalidType2 = 0;

  double _calculateHeight(double y){
    double res = 10 - (y * 10).toPrecision(1);
    return res;
  }

  double _convertCM(double y){
    double res = 11.75*y+55.75 ;
    setState(() {
      heightController.text = '${res.toPrecision(1)}';
    });
    return res;
  }


  void _calculateBMI({
    required double w,
    required double h
  }) {
    double m = h/100;
    double bmi = w/(m*m);
    setState(() {
      result = bmi;
      isLoading = false;
    });
  }

  (String,int,int) _convertCmToFeetAndInches(double cm) {
    final int totalInches = (cm * 0.393701).round();
    final int feet = totalInches ~/ 12;
    final int inches = totalInches % 12;

    return ('$feet\'$inches"',feet,inches);
  }

  double convertFeetAndInchesToCm(int feet, int inches) {
    double totalCm = (feet * 30.48) + (inches * 2.54);
    return totalCm;
  }



  bool weightValid = true;
  bool ageValid = true;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    // Check if width is greater than height
    bool isWideScreen = screenSize.width > 500;
    bool isNarrowScreen = screenSize.width < 380;

    double fontSize = isWideScreen?14: 14.sp;
    double height = _calculateHeight(y);
    double heightCM = _convertCM(height);
    double size = isWideScreen? ((_calculateHeight(y).toPrecision(1) * 25)+40):((_calculateHeight(y).toPrecision(1) * 25)+40).sp;
    double convertToCm = convertFeetAndInchesToCm(_convertCmToFeetAndInches(heightCM).$2,_convertCmToFeetAndInches(heightCM).$3);
    print(size);
    // Get the screen size

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 3,
          backgroundColor: ColorManager.primary,
          title: Text('BMI Calculator'),
          titleTextStyle: getMediumStyle(color: ColorManager.white),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 1.4 / 2,
                child: GestureDetector(
                  onVerticalDragUpdate: (value) {
                    double yValue = value.delta.dy;
                    if ((y > -1.0 && y <= 0.7) || (yValue > 0 && y <= 0.7)) {
                      // Only allow dragging if y is in the range of -0.1 to 0.5
                      setState(() {
                        y += yValue * 0.004;

                        // Limit y within the range of -0.1 to 0.5
                        y = y.clamp(-1.0, 0.7);


                      });
                      // print(yValue > 0 ? 'downward' : 'upward');
                    }
                  },
                  child: Row(
                    children: [
                      Form(
                        key:_formKey,
                        child: Container(
                          width:MediaQuery.of(context).size.width * 1/ 2 ,
                          padding: EdgeInsets.symmetric(vertical: 24.h),
                          height: MediaQuery.of(context).size.height ,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Text('Height',style: getMediumStyle(color: ColorManager.black,fontSize: 18),),
                              h10,
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 18.w),
                                color: ColorManager.dotGrey.withOpacity(0.2),
                                padding:EdgeInsets.symmetric(horizontal: 8.w,vertical: 12.h) ,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      validator: (value){

                                        if(value!.isEmpty){
                                          return 'Required';
                                        }
                                        else if (RegExp(r'^(?=.*?[A-Z])').hasMatch(value)||RegExp(r'^(?=.*?[a-z])').hasMatch(value)||RegExp(r'^(?=.*?[!@#&*~])').hasMatch(value))  {
                                          return 'Enter a valid number';
                                        }
                                        else{

                                          return null;
                                        }
                                      },
                                      onChanged: (value){
                                        setState(() {
                                          heightController.text = value;
                                        });
                                      },
                                      controller: heightController,
                                      keyboardType: TextInputType.phone,
                                      style: getMediumStyle(color: ColorManager.black),
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: ColorManager.dotGrey.withOpacity(0.2),
                                          border: OutlineInputBorder(
                                          )
                                      ),

                                    ),
                                    h10,
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              unit =1;
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: unit == 1? ColorManager.primary : ColorManager.white,
                                                border: unit !=1 ?Border.all(
                                                    color: ColorManager.black.withOpacity(0.5)
                                                ):null
                                            ),
                                            padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
                                            child: Text('CM',style: getMediumStyle(color:unit ==1 ? ColorManager.white: ColorManager.black,fontSize: 20),),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              unit =2 ;
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: unit == 2? ColorManager.primary : ColorManager.white,
                                                border: unit !=2 ?Border.all(
                                                    color: ColorManager.black.withOpacity(0.5)
                                                ):null
                                            ),
                                            padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
                                            child: Text('FT',style: getMediumStyle(color:unit==2?ColorManager.white: ColorManager.black,fontSize: 20),),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width:MediaQuery.of(context).size.width * 1/ 2 ,
                        padding: EdgeInsets.symmetric(vertical: 24.h),
                        height: MediaQuery.of(context).size.height ,
                        decoration: BoxDecoration(
                            color: ColorManager.primary,
                            border: BorderDirectional(
                              start: BorderSide(
                                color: ColorManager.primaryDark,
                              ),
                              bottom: BorderSide(
                                  color: ColorManager.primaryDark
                              ),

                            )
                        ),
                        child: Container(
                          color: ColorManager.white,
                          child: Stack(
                            children: [

                              Align(
                                alignment: Alignment.bottomLeft,
                                child:  Container(
                                  width: 50,
                                  height: MediaQuery.of(context).size.height*0.8,
                                  decoration: BoxDecoration(
                                      color: ColorManager.primary,
                                      border: Border.all(
                                          color: ColorManager.primaryDark
                                      )
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                      50, // Number of scale divisions
                                          (index) {
                                        double position =  index *0.01;
                                        return Container(
                                          height: 5,
                                          color: Colors.white,
                                          margin: EdgeInsets.only(top: position),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 5.h),
                                  child: Image.asset(selectedOption == 1 ? 'assets/icons/man.png':'assets/icons/woman.png',width: 120.w,height: size,fit: BoxFit.fitHeight,),
                                ),
                              ),
                              Align(
                                alignment: Alignment(0, y),
                                child: Container(
                                  height: 100,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          color: ColorManager.primary,
                                          height: 50,
                                          width: 100,
                                          child: Center(
                                            child: Text(
                                            '${ heightController.text}' ,
                                              style: getRegularStyle(color: ColorManager.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 2,
                                        width: double.infinity,
                                        color: ColorManager.primaryDark,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
