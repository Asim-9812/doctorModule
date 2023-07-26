import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:medical_app/src/core/resources/style_manager.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/value_manager.dart';

enum Gender { male, female }

class BMRCalculatorScreen extends StatefulWidget {
  @override
  _BMRCalculatorScreenState createState() => _BMRCalculatorScreenState();
}

class _BMRCalculatorScreenState extends State<BMRCalculatorScreen> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  double? bmrResult;
  Gender selectedGender = Gender.male;

  void calculateBMR() {
    double weight = double.tryParse(weightController.text) ?? 0.0;
    double height = double.tryParse(heightController.text) ?? 0.0;
    int age = int.tryParse(ageController.text) ?? 0;

    if (weight > 0 && height > 0 && age > 0) {
      double bmr = selectedGender == Gender.male
          ? 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age)
          : 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);

      setState(() {
        bmrResult = bmr;
      });
    } else {
      setState(() {
        bmrResult = null;
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
          title: Text(
            'BMR Calculator',
            style: getMediumStyle(color: Colors.black),
          ),
          backgroundColor: ColorManager.white,
          elevation: 1,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: FaIcon(
              Icons.chevron_left,
              color: ColorManager.black,
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              h20,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Gender :', style: getRegularStyle(color: Colors.black)),
                  w16,
                  Radio<Gender>(
                    value: Gender.male,
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value!;
                      });
                    },
                  ),
                  Text('Male', style: getRegularStyle(color: Colors.black)),
                  Radio<Gender>(
                    value: Gender.female,
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value!;
                      });
                    },
                  ),
                  Text('Female', style: getRegularStyle(color: Colors.black)),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Weight (in kg) :',
                      style: getRegularStyle(color: Colors.black)),
                  w16,
                  Container(
                    width: 50.w,
                    height: 40.h,
                    child: TextField(
                      controller: weightController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12.w, vertical: 0),
                        border: UnderlineInputBorder(),
                        hintText: 'kg',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Height (in cm) :',
                      style: getRegularStyle(color: Colors.black)),
                  w16,
                  Container(
                    width: 50.w,
                    height: 40.h,
                    child: TextField(
                      controller: heightController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12.w, vertical: 0),
                        border: UnderlineInputBorder(),
                        hintText: 'cm',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Age :', style: getRegularStyle(color: Colors.black)),
                  w16,
                  Container(
                    width: 50.w,
                    height: 40.h,
                    child: TextField(
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12.w, vertical: 0),
                        border: UnderlineInputBorder(),
                        hintText: 'years',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: calculateBMR,
                child: Text('Calculate BMR'),
              ),
              SizedBox(height: 16),
              // ... previous code ...

              if (bmrResult != null)
                Text(
                  'BMR: ${bmrResult!.toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              if (bmrResult != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Basal Metabolic Rate (BMR) is the number of calories your body needs to maintain its basic functions at rest. It represents the energy required for vital bodily processes such as breathing, circulating blood, and maintaining body temperature.',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Your calculated BMR is ${bmrResult!.toStringAsFixed(2)} calories per day.',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'This means that if you were to rest and do no physical activity for the entire day, your body would burn approximately ${bmrResult!.toStringAsFixed(2)} calories just to support its essential functions.',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'To maintain your current weight, you would need to consume roughly this number of calories per day. If you want to lose weight, you can create a calorie deficit by consuming fewer calories than your BMR, and to gain weight, you can consume more calories than your BMR.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }
}
