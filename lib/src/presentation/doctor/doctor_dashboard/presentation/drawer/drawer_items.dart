



import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/style_manager.dart';
import '../../../../../core/resources/value_manager.dart';
import '../../../../login/domain/service/login_service.dart';
import '../../../../login/presentation/status_page.dart';

class DrawerItems extends ConsumerWidget {
  final bool isWideScreen;
  final bool isNarrowScreen;
  DrawerItems(this.isWideScreen,this.isNarrowScreen);

  @override
  Widget build(BuildContext context,ref) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          h20,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Account & Settings',style: getMediumStyle(color: ColorManager.black,fontSize: isNarrowScreen?24.sp:isWideScreen?16: 24),),
                h10,
                _profileItems(title: 'Change Password', icon: FontAwesomeIcons.key, onTap: (){},trailing: true),
                _profileItems(title: 'Language', icon: Icons.sort_by_alpha, onTap: (){},trailing: true),
                _profileItems(title: 'Permissions', icon: FontAwesomeIcons.universalAccess, onTap: (){},trailing: true),
              ],
            ),
          ),
          h20,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Help & Support',style: getMediumStyle(color: ColorManager.black,fontSize:isNarrowScreen?24.sp: isWideScreen?16:24),),
                h10,
                _profileItems(title: 'Emergency Support', icon: Icons.warning_amber, onTap: (){},trailing: true),
                _profileItems(title: 'Help Center', icon: Icons.question_mark, onTap: (){},trailing: true),
                _profileItems(title: 'Terms & Policies', icon: FontAwesomeIcons.book, onTap: (){},trailing: true),
                h20,
                h20,
                _profileItems(
                    title: 'Log out',
                    icon: Icons.login_outlined,
                    onTap: () {
                      ref.read(userProvider.notifier).userLogout();
                      print('logout');
                      Get.offAll(() => StatusPage(accountId: 0,));
                    }
                ),
              ],
            ),
          ),

          h20,
          h20,
          h20,
          Container(

            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Version 1.0.0',style: getRegularStyle(color: ColorManager.black,fontSize: 16),),
                h10,
                Text('Developed by Search Technology',style: getRegularStyle(color: ColorManager.black,fontSize: 16),),
                h10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.facebook),
                    w12,
                    FaIcon(FontAwesomeIcons.linkedin),
                    w12,
                    FaIcon(FontAwesomeIcons.twitter),
                  ],
                )
              ],
            ),
          ),
          h100,

        ],
      ),
    );
  }

  Widget _profileItems({
    VoidCallback? onTap,
    required String title,
    required IconData icon,
    String? subtitle,
    bool? trailing,
  }) {
    if (trailing == null) {
      trailing = false;
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        onTap: onTap, // Pass the onTap callback here
        splashColor: ColorManager.textGrey.withOpacity(0.2),
        tileColor: ColorManager.textGrey.withOpacity(0.05),
        leading: FaIcon(icon, size: 20,),
        title: Text('$title', style: getRegularStyle(color: ColorManager.black, fontSize: 18),),
        subtitle: subtitle != null ? Text('$subtitle', style: getRegularStyle(color: ColorManager.subtitleGrey, fontSize: 14),) : null,
        trailing: trailing == true ? Icon(Icons.chevron_right, color: ColorManager.iconGrey,) : null,
      ),
    );
  }


}
