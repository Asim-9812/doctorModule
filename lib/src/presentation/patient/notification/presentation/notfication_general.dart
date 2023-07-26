



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';
import 'package:medical_app/src/core/resources/style_manager.dart';

import '../../../../core/resources/value_manager.dart';


class General extends StatelessWidget {
  final List<Map<String,dynamic>> notificationList;
  General({required this.notificationList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
        itemCount: notificationList.length,
        itemBuilder: (context,index){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 18.h),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: ColorManager.black.withOpacity(0.4),
                width: 0.5
              )
            )
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: notificationList[index]['userImg']==null
                  ?AssetImage('assets/icons/user.png')
                  :AssetImage(notificationList[index]['userImg']),
            ),
            title: Text(notificationList[index]['name'],style: getMediumStyle(color: ColorManager.black,fontSize: 20),),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notificationList[index]['notificationDescription'],style: getRegularStyle(color: ColorManager.black.withOpacity(0.7),fontSize: 16),maxLines: 2,),
                h10,
                Text(notificationList[index]['createdDate'],style: getRegularStyle(color: ColorManager.black.withOpacity(0.7),fontSize: 12)),

              ],
            ),
          ),
        );
        }
    );
  }
}
