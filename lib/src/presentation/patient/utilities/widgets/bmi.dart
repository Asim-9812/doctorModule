import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:medical_app/src/core/resources/style_manager.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/value_manager.dart';




class BMICalculatorScreen extends StatefulWidget {
  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  double? bmiResult;
  String? bmiCategory;


  void calculateBMI() {
    double height = double.tryParse(heightController.text) ?? 0.0;
    double weight = double.tryParse(weightController.text) ?? 0.0;

    if (height > 0 && weight > 0) {
      double bmi = weight / ((height / 100) * (height / 100));
      setState(() {
        bmiResult = bmi;
        if (bmi < 18.5) {
          bmiCategory = "Underweight";
        } else if (bmi >= 18.5 && bmi < 24.9) {
          bmiCategory = "Normal Weight";
        } else if (bmi >= 25 && bmi < 29.9) {
          bmiCategory = "Overweight";
        } else {
          bmiCategory = "Obese";
        }
      });
    } else {
      setState(() {
        bmiResult = null;
        bmiCategory = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('BMI Calculator',style: getMediumStyle(color: Colors.black),),
          backgroundColor: ColorManager.white,
          elevation: 1,
          leading: IconButton(
            onPressed: ()=>Get.back(),
            icon: FaIcon(Icons.chevron_left,color: ColorManager.black,),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            h20,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Height (in cm) :',style: getRegularStyle(color: Colors.black)),
                w16,
                Container(
                  // color: Colors.red,
                  width: 50.w,
                  height: 40.h,
                  child: TextField(
                    controller: heightController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal:12.w,vertical: 0),
                        border: UnderlineInputBorder(),
                        hintText: 'cm'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Weight (in kg) :',style: getRegularStyle(color: Colors.black)),
                w16,
                Container(
                  // color: Colors.red,
                  width: 50.w,
                  height: 40.h,
                  child: TextField(
                    controller: weightController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal:12.w,vertical: 0),
                        border: UnderlineInputBorder(),
                        hintText: 'kg'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: calculateBMI,
              child: Text('Calculate BMI'),
            ),
            SizedBox(height: 16),
            if (bmiResult != null)
              Text(
                'BMI: ${bmiResult!.toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            if (bmiCategory != null)
              Text(
                'Category: $bmiCategory',
                style: TextStyle(fontSize: 18),
              ),

          ],
        ),
      ),
    );
  }
}
