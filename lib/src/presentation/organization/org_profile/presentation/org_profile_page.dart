


import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';
import 'package:medical_app/src/core/resources/style_manager.dart';
import 'package:medical_app/src/data/services/user_services.dart';
import 'package:medical_app/src/presentation/common/shimmers.dart';
import 'package:medical_app/src/presentation/doctor/profile/presentation/widgets/update_profile.dart';
import 'package:medical_app/src/presentation/organization/org_profile/presentation/widgets/update_profile.dart';

import '../../../../core/api.dart';
import '../../../../core/resources/value_manager.dart';
import '../../../login/domain/model/user.dart';

class OrgProfilePage extends ConsumerWidget {

  @override
  Widget build(BuildContext context,ref) {
    final userBox = Hive.box<User>('session').values.toList();
    final user = userBox[0];
    final userInfo = ref.watch(userInfoProvider(user.userID!));

    final screenSize = MediaQuery.of(context).size;

    // Check if width is greater than height
    bool isWideScreen = screenSize.width > 500;
    bool isNarrowScreen = screenSize.width < 380;
    return userInfo.when(
        data: (data){
          return  Scaffold(
              backgroundColor: ColorManager.white.withOpacity(0.99),
              appBar: AppBar(
                elevation: 1,
                backgroundColor: ColorManager.white,
                leading: IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.chevron_left,color: Colors.black,)),
                title: Text('Profile',style: getMediumStyle(color: ColorManager.black,fontSize: isNarrowScreen? 24.sp:28),),
                actions: [
                  IconButton(onPressed: ()=>Get.to(()=>UpdateOrgProfile(isWideScreen, isNarrowScreen,data)), icon: Icon(Icons.edit_note_outlined,color: ColorManager.primary,size: 30,))
                ],

              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeIn(
                      duration: Duration(milliseconds: 500),
                      child: profileBanner(context,data)),
                  Container(
                    height: MediaQuery.of(context).size.height * 3/5,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: FadeInUp(
                        duration: Duration(milliseconds: 700),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            h16,
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text('Details',style: getMediumStyle(color: ColorManager.black,fontSize:isNarrowScreen?24.sp: 24),),
                                      w10,
                                      Container(
                                        width: isNarrowScreen? 220.w: 320.w,
                                        child: Divider(
                                          thickness: 0.5,
                                          color: ColorManager.black,
                                        ),

                                      )
                                    ],
                                  ),
                                  h10,
                                  _profileItems(screenSize: screenSize,title: 'Phone Number', icon: FontAwesomeIcons.phone, onTap: (){},subtitle: '${user.contactNo}'),
                                  _profileItems(screenSize: screenSize,title: 'E-Mail', icon: Icons.email_outlined, onTap: (){},subtitle: '${user.email}'),
                                  _profileItems(screenSize: screenSize,title: 'PAN No.', icon: FontAwesomeIcons.idCard, onTap: (){},subtitle: '${user.panNo}'),
                                ],
                              ),
                            ),
                            h20,

                            h20,
                            h20,
                            h20,




                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )


          );
        },
        error: (error,stack)=>Center(child: Text('$error')),
        loading: ()=>ProfileShimmer()
    );

  }

  /// Profile...

  Widget profileBanner(BuildContext context,User user) {
    final screenSize = MediaQuery.of(context).size;


    ImageProvider<Object>? profileImage;
    if (user.profileImage == null) {
      profileImage = AssetImage('assets/icons/user.png');
    } else {
      profileImage = NetworkImage('${Api.baseUrl}/${user.profileImage}');
    }



    // Check if width is greater than height
    bool isWideScreen = screenSize.width > 500;
    bool isNarrowScreen = screenSize.width < 420;
    return Card(
      elevation: 3,
      shadowColor: ColorManager.textGrey.withOpacity(0.4),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9/4,
        padding: EdgeInsets.symmetric(horizontal: 18.w,vertical:12.h),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 120.h,
                decoration: BoxDecoration(
                    image: DecorationImage(image:AssetImage('assets/images/containers/Tip-Container.png'),fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)
                    )
                ),
              ) ,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    shape: CircleBorder(),
                    elevation: 5,
                    child: CircleAvatar(
                      backgroundColor: ColorManager.white,
                      radius: isNarrowScreen? 50.r:50,
                      child: CircleAvatar(
                        backgroundImage: profileImage,
                        backgroundColor: ColorManager.white,
                        radius: isNarrowScreen? 45.r:45,
                      ),
                    ),
                  ),
                  w10,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${user.firstName} ${user.lastName}',style: getMediumStyle(color: ColorManager.black,fontSize: isNarrowScreen? 32.sp:32),),
                      h10,
                      Text('${user.localAddress}',style: getRegularStyle(color: ColorManager.textGrey,fontSize: isNarrowScreen?16.sp:16),)
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Profile items func & ui ...

  Widget _profileItems({
    VoidCallback? onTap,
    required String title,
    required IconData icon,
    String? subtitle,
    bool? trailing,
    required Size screenSize

  }) {

    // Check if width is greater than height
    bool isWideScreen = screenSize.width > 500;
    bool isNarrowScreen = screenSize.width < 380;
    if(trailing == null){
      trailing = false;
    }
    return ListTile(
      onTap: onTap,
      splashColor: ColorManager.textGrey.withOpacity(0.2),
      leading: FaIcon(icon,size: isNarrowScreen?24.sp:24,),
      title: Text('$title',style:getRegularStyle(color: ColorManager.black,fontSize:isNarrowScreen?20.sp:20 ),),
      subtitle: subtitle != null? Text('$subtitle',style:getRegularStyle(color: ColorManager.subtitleGrey,fontSize:isNarrowScreen?16.sp:16 ),):null,
      trailing: trailing == true? Icon(Icons.chevron_right,color: ColorManager.iconGrey,):null ,
    );
  }

}
