







import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';
import 'package:medical_app/src/core/resources/style_manager.dart';
import 'package:medical_app/src/dummy_datas/dummy_datas.dart';
import 'package:medical_app/src/test/test.dart';

import '../../../../core/resources/value_manager.dart';

class OrgPatientReports extends StatefulWidget {
  const OrgPatientReports({super.key});

  @override
  State<OrgPatientReports> createState() => _OrgPatientReportsState();
}

class _OrgPatientReportsState extends State<OrgPatientReports> {

  List<String> columnName=['S.N.','Name','Gender','Age','Contact No.','E-mail','Address','Consultant','Consult Date','Entry Date','Actions'];

  double getColumnWidth(String columnName) {
    if (columnName == 'S.N.') {
      return 75;
    } else if (columnName == 'Name' || columnName == 'Consultant' || columnName == 'E-mail') {
      return 250;
    } else if (columnName == 'Contact No.' || columnName == 'Actions') {
      return 175;
    } else if (columnName == 'Address' || columnName == 'Consult Date' || columnName == 'Entry Date') {
      return 200;
    } else {
      return 100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('patient report page'),
          h20,
          Container(
            height: 500,
            child: ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
                children:[
                  Container(
                    width: 2010,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          tileColor: Colors.blue,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for(String n in columnName)
                                Container(

                                  height: MediaQuery.of(context).size.height*0.05,
                                  width: n == 'S.N.'
                                      ? 75
                                      : n == 'Name' || n == 'Consultant' || n == 'E-mail'
                                      ?250
                                      : n == 'Contact No.' || n == 'Actions'
                                      ? 175
                                      : n== 'Address' || n == 'Consult Date' || n == 'Entry Date'
                                      ? 200
                                      : 100,
                                  decoration: BoxDecoration(
                                    // color: ColorManager.red,
                                      border: Border(
                                      right: BorderSide(
                                        color: ColorManager.white
                                      )
                                    )
                                  ),
                                  child: Center(child: Text('$n',style: getMediumStyle(color: ColorManager.white,fontSize: 18),)),
                                ),
                            ],
                          ),
                        ),
                        ListTile(
                          shape: Border(
                            bottom: BorderSide(
                              color: Colors.black
                            )
                          ),
                          tileColor: Colors.white,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (int i = 0; i < columnName.length; i++)
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.05,
                                  width: getColumnWidth(columnName[i]),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                        color: ColorManager.black,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${patient1[i]}',
                                      style: getRegularStyle(color: ColorManager.black, fontSize: 18),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        ListTile(
                          shape: Border(
                              bottom: BorderSide(
                                  color: Colors.black
                              )
                          ),
                          tileColor: Colors.white,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (int i = 0; i < columnName.length; i++)
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.05,
                                  width: getColumnWidth(columnName[i]),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                        color: ColorManager.black,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${patient2[i]}',
                                      style: getRegularStyle(color: ColorManager.black, fontSize: 18),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        ListTile(
                          shape: Border(
                              bottom: BorderSide(
                                  color: Colors.black
                              )
                          ),
                          tileColor: Colors.white,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (int i = 0; i < columnName.length; i++)
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.05,
                                  width: getColumnWidth(columnName[i]),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                        color: ColorManager.black,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${patient3[i]}',
                                      style: getRegularStyle(color: ColorManager.black, fontSize: 18),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        ListTile(
                          shape: Border(
                              bottom: BorderSide(
                                  color: Colors.black
                              )
                          ),
                          tileColor: Colors.white,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (int i = 0; i < columnName.length; i++)
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.05,
                                  width: getColumnWidth(columnName[i]),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                        color: ColorManager.black,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${patient4[i]}',
                                      style: getRegularStyle(color: ColorManager.black, fontSize: 18),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),




                      ],
                    )
                  )
                ]
            ),
          ),
        ],
      ),
    );
  }
}
