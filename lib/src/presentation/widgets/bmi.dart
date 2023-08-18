import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';
import 'package:medical_app/src/test/test2.dart';

import '../../core/resources/style_manager.dart';
import '../../core/resources/value_manager.dart';
import 'list_of_bmi_category/bmi_list.dart';


class BMI extends StatefulWidget {
  @override
  BMIState createState() => BMIState();
}

class BMIState extends State<BMI> {
  double _linePositionY = 200.0;
  double y = 0.4; // Initial Y position of the line
  int selectedOption = 1;
  final TextEditingController weightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  // final TextEditingController feetController = TextEditingController();
  // final TextEditingController inchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  double result = 0.0;
  List bmiList = bmiCategories;
  int category = 0;
  int unit =1;

  double _calculateHeight(double y){
    double res = 10 - (y * 10).toPrecision(1);
    return res;
  }

  double _convertCM(double y){
    double res = 11.75*y+55.75 ;
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
    _getCategory();
  }


  void _getCategory() {
    final screenSize = MediaQuery.of(context).size;

    // Check if width is greater than height
    bool isWideScreen = screenSize.width > 500;
    bool isNarrowScreen = screenSize.width < 420;

    if(result >= 0.0 && result < 16){
      _showDialog(0, isWideScreen, isNarrowScreen);

    } else if(result >=16 && result < 17){
      _showDialog(1, isWideScreen, isNarrowScreen);
    } else if(result >=17 && result < 18.5){
      _showDialog(2, isWideScreen, isNarrowScreen);
    } else if(result >=18.5 && result < 25){
      _showDialog(3, isWideScreen, isNarrowScreen);
    } else if(result >=25 && result < 30){
      _showDialog(4, isWideScreen, isNarrowScreen);
    } else if(result >=30 && result < 35){
      _showDialog(5, isWideScreen, isNarrowScreen);
    } else if(result >=35 && result < 40){
      _showDialog(6, isWideScreen, isNarrowScreen);
    } else{
      _showDialog(7, isWideScreen, isNarrowScreen);
    }



  }
  String _convertCmToFeetAndInches(double cm) {
    final int totalInches = (cm * 0.393701).round();
    final int feet = totalInches ~/ 12;
    final int inches = totalInches % 12;

    return '$feet\'$inches"';
  }



  Future<void> _showDialog(int category,bool isWideScreen,bool isNarrowScreen) async {

    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
            ),
            content: Container(
              // height: 450.h,
              width: MediaQuery.of(context).size.height*2/3,
              // color: Colors.red,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Calculated BMI',style: getMediumStyle(color: Colors.black),),
                  h20,
                  Container(
                    height: MediaQuery.of(context).size.height*0.15,
                    // color: Colors.blue,
                    child: Center(
                      child: Container(
                        height: 50.h,
                        // color: Colors.blue,
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width*0.1,
                              color: category==0? ColorManager.red : ColorManager.red.withOpacity(0.1),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.05,
                              color: category==1? ColorManager.red.withOpacity(0.7):ColorManager.red.withOpacity(0.1),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.05,
                              color: category==2? ColorManager.yellowFellow:ColorManager.yellowFellow.withOpacity(0.1),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.19,
                              color: category==3? ColorManager.primary:ColorManager.primary.withOpacity(0.1),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.05,
                              color: category==4? ColorManager.yellowFellow:ColorManager.yellowFellow.withOpacity(0.1),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.05,
                              color: category==5? ColorManager.red.withOpacity(0.5):ColorManager.red.withOpacity(0.1),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.05,
                              color: category==6? ColorManager.red.withOpacity(0.7):ColorManager.red.withOpacity(0.1),
                            ),
                            Container(
                              width: isNarrowScreen? MediaQuery.of(context).size.width*0.11:MediaQuery.of(context).size.width*0.129,
                              color:category==7? ColorManager.red:ColorManager.red.withOpacity(0.1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  h10,
                  Text('${result.toPrecision(1)} kg/m²',style: getMediumStyle(color: ColorManager.black),),
                  h20,
                  Container(
                    width: MediaQuery.of(context).size.height*1.5/3,
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${bmiList[category]['name']} (${bmiList[category]['bmiRange']})',style: getMediumStyle(color: ColorManager.black,fontSize: 20),),
                        h16,
                        Text('${bmiList[category]['description']}',style: getRegularStyle(color: ColorManager.black,fontSize: 16),textAlign: TextAlign.justify,)
                      ],
                    ),
                  ),
                  h20,

                ],
              ),
            ),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size.fromWidth(200.w),
                      backgroundColor: ColorManager.primary
                  ),
                  onPressed: (){
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.pop(context);
                  },
                  child: Text('OK',style: getMediumStyle(color: Colors.white,fontSize: 16),)
              )
            ],
            actionsAlignment: MainAxisAlignment.center,
          );
        }
    );

  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    // Check if width is greater than height
    bool isWideScreen = screenSize.width > 500;
    bool isNarrowScreen = screenSize.width < 420;

    double fontSize = isWideScreen?14: 14.sp;
    double height = _calculateHeight(y);
    double heightCM = _convertCM(height);
    double size = isWideScreen? ((_calculateHeight(y).toPrecision(1) * 25)+40):((_calculateHeight(y).toPrecision(1) * 25)+40).sp;
    print(size);
    // Get the screen size

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 3,
          backgroundColor: ColorManager.primary,
          title: Text('BMI'),
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
                    if ((y > -0.5 && y <= 0.7) || (yValue > 0 && y <= 0.7)) {
                      // Only allow dragging if y is in the range of -0.1 to 0.5
                      setState(() {
                        y += yValue * 0.004;

                        // Limit y within the range of -0.1 to 0.5
                        y = y.clamp(-0.5, 0.7);


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
                              Text('Gender',style: getMediumStyle(color: ColorManager.black,fontSize: 18),),
                              h20,
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [

                                  Container(
                                    height: 100,
                                    width: 90.w,
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
                                              border: Border.all(color: selectedOption == 2 ? ColorManager.primaryDark : ColorManager.dotGrey),
                                              shape: BoxShape.circle,
                                              color: selectedOption == 1 ? ColorManager.primary : Colors.transparent,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                'assets/icons/man.png',
                                                width: 40,
                                                height: 40,
                                              ),
                                            ),
                                          ),
                                          h10,
                                          Text(
                                            'Male',
                                            style: getRegularStyle(color: selectedOption == 1 ? ColorManager.black : ColorManager.textGrey, fontSize: fontSize),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  w05,
                                  Container(
                                    height: 100,
                                    width: 90.w,
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
                                              color: selectedOption ==2 ? ColorManager.primary : Colors.transparent,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                'assets/icons/woman.png',
                                                width: 40,
                                                height: 40,
                                              ),
                                            ),
                                          ),
                                          h10,
                                          Text(
                                            'Female',
                                            style: getRegularStyle(color: selectedOption == 3 ? ColorManager.black : ColorManager.textGrey, fontSize: fontSize),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                              h20,
                              Text('Age',style: getMediumStyle(color: ColorManager.black,fontSize: 18),),
                              h20,
                              Container(
                                color: ColorManager.dotGrey.withOpacity(0.2),
                                padding:EdgeInsets.symmetric(horizontal: 8.w,vertical: 12.h) ,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 50.w,
                                      child: TextFormField(
                                        controller: ageController,
                                        validator: (value){
                                          if(value!.isEmpty){
                                            return 'Field must not be empty';
                                          }
                                          else if(double.parse(value)<10 && double.parse(value)>100 ){
                                            return 'Age must be above 10 and below 100';
                                          }
                                          else{
                                            return null;
                                          }
                                        },
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        style: getRegularStyle(color: ColorManager.black,fontSize: 18),
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(left: 8.w,top: 24.h),
                                            border: UnderlineInputBorder()
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 70.w,
                                      child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Text('yrs old',style: getRegularStyle(color: ColorManager.black,fontSize: 20),)),
                                    ),
                                  ],
                                ),
                              ),
                              h20,
                              h20,
                              h20,
                              Text('Weight',style: getMediumStyle(color: ColorManager.black,fontSize: 18),),
                              h20,
                              Container(
                                color: ColorManager.dotGrey.withOpacity(0.2),
                                padding:EdgeInsets.symmetric(horizontal: 8.w,vertical: 12.h) ,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 50.w,
                                      child: TextFormField(
                                        controller: weightController,
                                        validator: (value){
                                          if(value!.isEmpty){
                                            return 'Field must not be empty';
                                          }
                                          else{
                                            return null;
                                          }
                                        },
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        style: getRegularStyle(color: ColorManager.black,fontSize: 18),
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(left: 8.w,top: 24.h),
                                            border: UnderlineInputBorder()
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 70.w,
                                      child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Text('in KG',style: getRegularStyle(color: ColorManager.black,fontSize: 20),)),
                                    ),
                                  ],
                                ),
                              ),
                              h20,
                              Container(
                                color: ColorManager.dotGrey.withOpacity(0.2),
                                padding:EdgeInsets.symmetric(horizontal: 8.w,vertical: 12.h) ,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          width: 50.w,
                                          child: Radio<int>(
                                            value: 1,
                                            groupValue: unit,
                                            onChanged: (value) {
                                              setState(() {
                                                unit = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        Text('In CM')
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          width: 50.w,
                                          child: Radio<int>(
                                            value: 2,
                                            groupValue: unit,
                                            onChanged: (value) {
                                              setState(() {
                                                unit = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        Text('In ft/inch')
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
                                    color: ColorManager.primaryDark
                                ),
                                bottom: BorderSide(
                                    color: ColorManager.primaryDark
                                )
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
                                              '${unit ==1 ? heightCM.toPrecision(1):_convertCmToFeetAndInches(heightCM)}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 2,
                                        width: double.infinity,
                                        color: Colors.black,
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
              h20,
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primary,
                      fixedSize: Size.fromWidth(250.w)
                  ),
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        isLoading = true;
                      });
                     _calculateBMI(w: double.parse(weightController.text), h: heightCM);


                    }
                  },
                  child:isLoading? SpinKitDualRing(color: ColorManager.white): Text('Submit'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
