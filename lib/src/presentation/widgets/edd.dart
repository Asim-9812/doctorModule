



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';
import 'package:medical_app/src/core/resources/style_manager.dart';

import '../../core/resources/value_manager.dart';

class EDD extends StatefulWidget {
  const EDD({super.key});

  @override
  State<EDD> createState() => _EDDState();
}

class _EDDState extends State<EDD> {
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? calculatedEDD;

  // Function to calculate EDD
  String calculateEDD() {
    int day = int.tryParse(_dayController.text) ?? 1;
    int month = int.tryParse(_monthController.text) ?? 1;
    int year = int.tryParse(_yearController.text) ?? DateTime.now().year;

    DateTime lastPeriodDate = DateTime(year, month, day);
    DateTime edd = lastPeriodDate.add(Duration(days: 280)); // Adding 280 days for EDD

    return DateFormat('MMMM dd, yyyy').format(edd); // Format EDD date
  }

  bool invalid = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          elevation: 3,
          backgroundColor: ColorManager.primary,
          title: Text('EDD Calculator'),
          centerTitle: true,
          titleTextStyle: getMediumStyle(color: ColorManager.white),
          
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                h20,
                Text(
                  'When was the first day of your last period?',
                  style: getMediumStyle(color: ColorManager.black, fontSize: 20.sp),
                ),
                h20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Day', style: getRegularStyle(color: ColorManager.black)),
                        h10,
                        Container(
                          decoration:BoxDecoration(
                            border: Border.all(
                              color: ColorManager.black.withOpacity(0.5)
                            ),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: DropdownButton<int>(
                            menuMaxHeight: 400,
                            value: _dayController.text.isNotEmpty ? int.tryParse(_dayController.text) : null,
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  _dayController.text = value.toString();
                                });
                              }
                            },
                            items: List.generate(32, (index) => index + 1)
                                .map<DropdownMenuItem<int>>(
                                  (value) => DropdownMenuItem<int>(
                                value: value,
                                child: Text(value.toString()),
                              ),
                            )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Month', style: getRegularStyle(color: ColorManager.black)),
                        h10,
                        Container(
                          decoration:BoxDecoration(
                              border: Border.all(
                                  color: ColorManager.black.withOpacity(0.5)
                              ),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: DropdownButton<int>(

                            menuMaxHeight: 400,
                            value: _monthController.text.isNotEmpty ? int.tryParse(_monthController.text) : null,
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  _monthController.text = value.toString();
                                });
                              }
                            },
                            items: List.generate(12, (index) => index + 1)
                                .map<DropdownMenuItem<int>>(
                                  (value) => DropdownMenuItem<int>(
                                value: value,
                                child: Text(DateFormat('MMMM').format(DateTime(2000, value))),
                              ),
                            )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Year',style: getRegularStyle(color: ColorManager.black),),
                        h10,
                        SizedBox(
                          width: 75,
                          child: TextFormField(
                            controller: _yearController,
                            keyboardType: TextInputType.phone,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Year';
                              }else if(DateTime(2023).isBefore(DateTime(int.parse(value)))||DateTime(2022).isAfter(DateTime(int.parse(value)))){
                                return 'Valid Year';
                              }else{
                                return null;
                              }
                            },
                            style: getRegularStyle(color: ColorManager.black,fontSize: 20),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 14.w),
                                border: OutlineInputBorder()
                            ),
                            inputFormatters: [LengthLimitingTextInputFormatter(4)],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                h20,
                h20,
                Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.primaryDark
                          ),
                            onPressed: (){
                            
                            final DateTime date = DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(int.parse(_yearController.text),int.parse(_monthController.text),int.parse(_dayController.text))));
                            final now = DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
                            
                            if(date.isAfter(now)){
                              setState(() {
                                invalid = true;
                                calculatedEDD = null;
                              });
                            }
                              else {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  invalid = false;
                                  calculatedEDD = calculateEDD();
                                });
                              }
                            }
                            },
                            child: Text('Calculate')
                        ),
                        w10,
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: ColorManager.dotGrey
                          ),
                            onPressed: (){
                              setState(() {
                                _dayController.clear();
                                _monthController.clear();
                                _yearController.clear();
                                calculatedEDD = null;
                                invalid=false;
                              });
                            },
                            child: Text('Clear',style: getRegularStyle(color: ColorManager.black),)
                        ),
                      ],
                    )
                ),
                h10,
                if(invalid)
                  Center(child: Text('Date cannot be after current date',style: getRegularStyle(color: ColorManager.red),)),
                h20,
                if (calculatedEDD != null)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Estimated Due Date :',
                            style: getMediumStyle(color: ColorManager.black, fontSize: 18),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            '$calculatedEDD',
                            style: getMediumStyle(color: ColorManager.primaryDark, fontSize: 18),
                          ),
                          SizedBox(height: 30.h),
                          Text(calculateEDDRange(),style: getRegularStyle(color: ColorManager.black,fontSize: 16),),
                          SizedBox(height: 10.h),
                          Text(
                            'Please note that due dates are estimates and can vary for each individual. Factors such as menstrual cycle length, ovulation, and other medical considerations can influence the actual delivery date. Consult with a healthcare professional for personalized guidance.',
                            style: getRegularStyle(color: ColorManager.black, fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to calculate EDD range
  String calculateEDDRange() {
    DateTime edd = DateFormat('MMMM dd, yyyy').parse(calculatedEDD!); // Parse calculated EDD
    DateTime eddMinus7 = edd.subtract(Duration(days: 7)); // Subtract 7 days
    DateTime eddPlus7 = edd.add(Duration(days: 7)); // Add 7 days

    return DateFormat('MMMM dd, yyyy').format(eddMinus7) + ' to ' + DateFormat('MMMM dd, yyyy').format(eddPlus7);
  }
}
