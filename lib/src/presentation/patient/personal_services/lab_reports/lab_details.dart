


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';
import 'package:medical_app/src/core/resources/style_manager.dart';

import '../../../../core/resources/value_manager.dart';

class LabDetails extends StatefulWidget {
  const LabDetails({super.key});

  @override
  State<LabDetails> createState() => _LabDetailsState();
}

class _LabDetailsState extends State<LabDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        iconTheme: IconThemeData(
          color: ColorManager.black
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              width: double.infinity,
              color: ColorManager.primaryDark,
              padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 12.h),
              child: Center(
                child: Text('Lab Report - NAME',style: getMediumStyle(color: ColorManager.white),),
              ),
            ),
            h20,

            Center(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorManager.black.withOpacity(0.5)
                  )
                ),
                child: DataTable(
                  dataTextStyle: getRegularStyle(color: ColorManager.black,fontSize: 16),
                  headingTextStyle: getRegularStyle(color: ColorManager.black,fontSize: 16),
                    columns: [
                      DataColumn(label: Text('Name:')),
                      DataColumn(label: Text('John Does')),
                    ],
                    rows: [
                      DataRow(
                          cells: [
                            DataCell(Text('Patient ID:')),
                            DataCell(Text('2055')),
                          ]
                      ),
                      DataRow(
                          cells: [
                            DataCell(Text('Date:')),
                            DataCell(Text('2023-08-09')),
                          ]
                      ),
                      DataRow(
                          cells: [
                            DataCell(Text('Age:')),
                            DataCell(Text('55')),
                          ]
                      ),
                      DataRow(
                          cells: [
                            DataCell(Text('Sex:')),
                            DataCell(Text('Male')),
                          ]
                      ),
                    ]
                ),
              ),
            ),
            h20,
            h20,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Text('Result',style: getMediumStyle(color: ColorManager.black),),
            ),
            h20,
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingTextStyle: getMediumStyle(color: ColorManager.white,fontSize: 20),
                  headingRowColor: MaterialStateColor.resolveWith((states) => ColorManager.primary),
                  dataTextStyle: getRegularStyle(color: ColorManager.black,fontSize: 18),
                  columns: [
                    DataColumn(label: Text('Test Name')),
                    DataColumn(label: Text('Result')),
                    DataColumn(label: Text('Normal Range')),
                    DataColumn(label: Text('Units')),
                  ],
                  rows: [
                    DataRow(
                        cells: [
                          DataCell(Text('Hemoglobin')),
                          DataCell(Text('12')),
                          DataCell(Text('11.0-16.0')),
                          DataCell(Text('g/dL')),
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(Text('Hemoglobin')),
                          DataCell(Text('12')),
                          DataCell(Text('11.0-16.0')),
                          DataCell(Text('g/dL')),
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(Text('Hemoglobin')),
                          DataCell(Text('12')),
                          DataCell(Text('11.0-16.0')),
                          DataCell(Text('g/dL')),
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(Text('Hemoglobin')),
                          DataCell(Text('12')),
                          DataCell(Text('11.0-16.0')),
                          DataCell(Text('g/dL')),
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(Text('Hemoglobin')),
                          DataCell(Text('12')),
                          DataCell(Text('11.0-16.0')),
                          DataCell(Text('g/dL')),
                        ]
                    )
                  ],
                ),
              )
            ),
            h20,
            h20,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Digitally signed by',style: getRegularStyle(color: ColorManager.black,fontSize: 20),),
                  h20,
                  Text('Dr. John Doe',style: getMediumStyle(color: ColorManager.black,fontSize: 24),),
                  h10,
                  Text('ID: DOC0005',style: getMediumStyle(color: ColorManager.black,fontSize: 20),),
                ],
              ),
            ),
            h100,
          ],
        ),
      ),
    );
  }
}
