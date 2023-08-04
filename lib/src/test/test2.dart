import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medical_app/src/core/resources/style_manager.dart';

import '../core/resources/value_manager.dart';

class Test4 extends StatelessWidget {

  final double result;
  Test4(this.result);


  double _getSize() {

    if(result >= 0.0 && result < 16){
      return 0.1;
    } else if(result >=16 && result < 17){
      return 0.2;
    } else if(result >=17 && result < 18.5){
      return 0.25;
    } else if(result >=18.5 && result < 25){
      return 0.42;
    } else if(result >=25 && result < 30){
      return 0.63;
    } else if(result >=30 && result < 35){
      return 0.73;
    } else if(result >=35 && result < 40){
      return 0.83;
    } else{
      return 0.95;
    }

  }

  @override
  Widget build(BuildContext context) {
    double size = _getSize();
    return Center(
        child: Container(
          height: MediaQuery.of(context).size.height*1/3,
          width: MediaQuery.of(context).size.height*2/3,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Calculated BMI',style: getMediumStyle(color: Colors.black),),
              h20,
              Container(
                height: MediaQuery.of(context).size.height*0.1,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      width: double.infinity,
                      height: 50.h,
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width*0.15,
                            color: Colors.red,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.05,
                            color: Colors.redAccent,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.05,
                            color: Colors.yellow,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.3,
                            color: Colors.green,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.1,
                            color: Colors.yellow,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.1,
                            color: Colors.pink,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.1,
                            color: Colors.redAccent,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.15,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*size,
                      child: Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: FaIcon(CupertinoIcons.triangle_fill,color: Colors.black,),

                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
  }
}
