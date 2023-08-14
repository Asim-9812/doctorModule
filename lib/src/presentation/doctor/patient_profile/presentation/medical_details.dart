

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';

import '../../../../core/resources/style_manager.dart';
import '../../../../core/resources/value_manager.dart';
import '../../../../dummy_datas/dummy_datas.dart';
import 'medical_charts.dart';

class PatientMedicalHistory extends StatefulWidget {
  const PatientMedicalHistory({super.key});

  @override
  State<PatientMedicalHistory> createState() => _PatientMedicalHistoryState();
}

class _PatientMedicalHistoryState extends State<PatientMedicalHistory> {

  bool _isExpanded = false;
  bool _isExpanded2= false;
  int currentPage = 0;
  final int itemsPerPage = 5;


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    // Check if width is greater than height
    bool isWideScreen = screenSize.width > 500;
    bool isNarrowScreen = screenSize.width < 380;

    List<Map<String, dynamic>> currentPageData = patientMedications
        .skip(currentPage * itemsPerPage)
        .take(itemsPerPage)
        .toList();

    bool hasPreviousPage = currentPage > 0;
    bool hasNextPage = (currentPage + 1) * itemsPerPage < patientMedications.length;


    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: ColorManager.white,
        leading: IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.chevron_left,color: Colors.black,)),
        title: Text('Medical Records',style: getMediumStyle(color: ColorManager.black,fontSize: isNarrowScreen? 24.sp:28),),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            h20,
            Container(
              decoration: BoxDecoration(
                  color: ColorManager.blue.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: ColorManager.black.withOpacity(0.5)
                  )
              ),
              margin: EdgeInsets.symmetric(horizontal: 18.w),
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: ExpansionPanelList(
                  expandIconColor: ColorManager.primaryDark,
                  elevation: 0,
                  expandedHeaderPadding: EdgeInsets.zero,
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      _isExpanded = !_isExpanded; // Toggle the expansion state
                    });
                  },
                  children: [
                    ExpansionPanel(
                      isExpanded: _isExpanded,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(

                          onTap: () {
                            setState(() {
                              _isExpanded =
                              !_isExpanded; // Toggle the expansion state
                            });
                          },
                          title: Text('Medical Graph', style: getMediumStyle(
                              color: ColorManager.black, fontSize: 20)),
                        ); // Empty header, handled above
                      },
                      body: Container(
                        width: double.infinity,
                        height: 450,
                        child: HealthChart(),
                      ),
                    ),

                  ]


              ),
            ),
            h20,
            Container(
              decoration: BoxDecoration(
                  color: ColorManager.primary.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: ColorManager.black.withOpacity(0.5)
                  )
              ),
              margin: EdgeInsets.symmetric(horizontal: 18.w),
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: ExpansionPanelList(
                  expandIconColor: ColorManager.primaryDark,
                  elevation: 0,
                  expandedHeaderPadding: EdgeInsets.zero,
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      _isExpanded2 = !_isExpanded2; // Toggle the expansion state
                    });
                  },
                  children: [
                    ExpansionPanel(
                      isExpanded: _isExpanded2,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(

                          onTap: () {
                            setState(() {
                              _isExpanded2 =
                              !_isExpanded2; // Toggle the expansion state
                            });
                          },
                          title: Text('Blood Pressure Graph', style: getMediumStyle(
                              color: ColorManager.black, fontSize: 20)),
                        ); // Empty header, handled above
                      },
                      body: Container(
                        width: double.infinity,
                        height: 450,
                        child: BPChart(),
                      ),
                    ),

                  ]


              ),
            ),
            h20,
            h20,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Text('Medication History',style: getMediumStyle(color: ColorManager.black),),
            ),
            h20,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith((states) => ColorManager.blue.withOpacity(0.7)),
                headingTextStyle: getRegularStyle(color: ColorManager.white,fontSize: 18),
                columns: [
                  DataColumn(label: Text('SN')),
                  DataColumn(label: Text('Prescribed Date')),
                  DataColumn(label: Text('Medicine Name')),
                  DataColumn(label: Text('Dosage')),
                  DataColumn(label: Text('Duration')),
                  DataColumn(label: Text('Prescribed By')),
                  DataColumn(label: Text('Action')),
                ],
                rows: List.generate(currentPageData.length, (index) {
                  int sn = currentPage * itemsPerPage + index + 1;
                  return DataRow(cells: [
                    DataCell(Text(sn.toString())),
                    DataCell(Text(currentPageData[index]['prescribed date'])),
                    DataCell(Text(currentPageData[index]['medicine name'])),
                    DataCell(Text(currentPageData[index]['dosage'])),
                    DataCell(Text(currentPageData[index]['duration'])),
                    DataCell(Text(currentPageData[index]['prescribed by'])),
                    DataCell(IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Add your action here
                      },
                    )),
                  ]);
                }),
              ),
            ),
            h20,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0
                    ),
                    onPressed: hasPreviousPage? () {
                      setState(() {
                        currentPage--;
                      });
                    }:(){},
                    child: Icon(Icons.chevron_left,color: ColorManager.black,),
                  ),
                  Text('${currentPage+1}'),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                      elevation: 0
                    ),
                    onPressed: hasNextPage?() {
                      setState(() {
                        currentPage++;
                      });
                    }:(){},
                    child: Icon(Icons.chevron_right,color: ColorManager.black,),
                  ),
              ],
            ),
            h100,
          ],
        ),
      ),
    );
  }
}
