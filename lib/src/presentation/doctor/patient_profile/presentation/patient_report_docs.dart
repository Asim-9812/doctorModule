



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/style_manager.dart';
import '../../../../core/resources/value_manager.dart';

class PatientDocs extends StatefulWidget {
  const PatientDocs({super.key});

  @override
  State<PatientDocs> createState() => _PatientDocsState();
}

class _PatientDocsState extends State<PatientDocs> {



  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    // Check if width is greater than height
    bool isWideScreen = screenSize.width > 500;
    bool isNarrowScreen = screenSize.width < 380;

    return Scaffold(
      backgroundColor: ColorManager.white.withOpacity(0.95),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: ColorManager.white,
        leading: IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.chevron_left,color: Colors.black,)),
        title: Text('Reports',style: getMediumStyle(color: ColorManager.black,fontSize: isNarrowScreen? 20.sp:24),),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              h10,
              TextFormField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Search',
                  hintStyle: getRegularStyle(color: ColorManager.subtitleGrey,fontSize: 16)
                ),
              ),
              h20,
              GridView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isWideScreen? 3: isNarrowScreen?1: 2,
                    crossAxisSpacing: isWideScreen?8:8.w,
                    mainAxisSpacing: isWideScreen?8: 8.h,
                    childAspectRatio: isWideScreen? 14/11:14/10
                ),
                children: [
                  buildFolderBody(context,folderName: 'Reports', fileNumbers: 5, onTap: (){}),
                  buildFolderBody(context,folderName: 'Documents', fileNumbers: 2, onTap: (){}),
                  buildFolderBody(context,folderName: 'Misc', fileNumbers: 6, onTap: (){}),

                ],
              ),
              h20,
              Text('Recent uploads',style: getRegularStyle(color: ColorManager.black,fontSize: 20),),
              h10,
              Divider(
                color: ColorManager.black.withOpacity(0.7),
                thickness: 1,
              ),
              h10,
              ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 12.w),
                tileColor: ColorManager.dotGrey.withOpacity(0.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: ColorManager.black.withOpacity(0.5)
                  )
                ),
                leading: Container(
                  decoration: BoxDecoration(
                    color: ColorManager.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.symmetric(vertical: 18.h,horizontal: 18.w),
                  child: FaIcon(FontAwesomeIcons.fileExcel,color: ColorManager.black,),
                ),
                title: Text('Blood Report 2023-08-14.csv',style: getMediumStyle(color: ColorManager.black,fontSize: 20),),
                subtitle: Text('2023-08-15',style: getRegularStyle(color: ColorManager.subtitleGrey,fontSize: 16),),
              ),
              h10,
              ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 12.w),
                tileColor: ColorManager.dotGrey.withOpacity(0.4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                        color: ColorManager.black.withOpacity(0.5)
                    )
                ),
                leading: Container(
                  decoration: BoxDecoration(
                      color: ColorManager.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.symmetric(vertical: 18.h,horizontal: 18.w),
                  child: FaIcon(FontAwesomeIcons.fileWord,color: ColorManager.black,),
                ),
                title: Text('Medical bill 2023-08-14.doc',style: getMediumStyle(color: ColorManager.black,fontSize: 20),),
                subtitle: Text('2023-08-15',style: getRegularStyle(color: ColorManager.subtitleGrey,fontSize: 16),),
              ),
              h10,
              ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 12.w),
                tileColor: ColorManager.dotGrey.withOpacity(0.4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                        color: ColorManager.black.withOpacity(0.5)
                    )
                ),
                leading: Container(
                  decoration: BoxDecoration(
                      color: ColorManager.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.symmetric(vertical: 18.h,horizontal: 18.w),
                  child: FaIcon(FontAwesomeIcons.fileExcel,color: ColorManager.black,),
                ),
                title: Text('Blood Report 2023-08-14.csv',style: getMediumStyle(color: ColorManager.black,fontSize: 20),),
                subtitle: Text('2023-08-15',style: getRegularStyle(color: ColorManager.subtitleGrey,fontSize: 16),),
              ),
              h10,
              ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 12.w),
                tileColor: ColorManager.dotGrey.withOpacity(0.4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                        color: ColorManager.black.withOpacity(0.5)
                    )
                ),
                leading: Container(
                  decoration: BoxDecoration(
                      color: ColorManager.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.symmetric(vertical: 18.h,horizontal: 18.w),
                  child: FaIcon(FontAwesomeIcons.fileExcel,color: ColorManager.black,),
                ),
                title: Text('Blood Report 2023-08-14.csv',style: getMediumStyle(color: ColorManager.black,fontSize: 20),),
                subtitle: Text('2023-08-15',style: getRegularStyle(color: ColorManager.subtitleGrey,fontSize: 16),),
              ),
              h10,
              ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 12.w),
                tileColor: ColorManager.dotGrey.withOpacity(0.4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                        color: ColorManager.black.withOpacity(0.5)
                    )
                ),
                leading: Container(
                  decoration: BoxDecoration(
                      color: ColorManager.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.symmetric(vertical: 18.h,horizontal: 18.w),
                  child: FaIcon(FontAwesomeIcons.fileExcel,color: ColorManager.black,),
                ),
                title: Text('Blood Report 2023-08-14.csv',style: getMediumStyle(color: ColorManager.black,fontSize: 20),),
                subtitle: Text('2023-08-15',style: getRegularStyle(color: ColorManager.subtitleGrey,fontSize: 16),),
              ),
              h10,
              ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 12.w),
                tileColor: ColorManager.dotGrey.withOpacity(0.4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                        color: ColorManager.black.withOpacity(0.5)
                    )
                ),
                leading: Container(
                  decoration: BoxDecoration(
                      color: ColorManager.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.symmetric(vertical: 18.h,horizontal: 18.w),
                  child: FaIcon(FontAwesomeIcons.fileExcel,color: ColorManager.black,),
                ),
                title: Text('Blood Report 2023-08-14.csv',style: getMediumStyle(color: ColorManager.black,fontSize: 20),),
                subtitle: Text('2023-08-15',style: getRegularStyle(color: ColorManager.subtitleGrey,fontSize: 16),),
              ),
              h100,
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFolderBody(BuildContext context,{
    required String folderName,
    required int fileNumbers,
    required VoidCallback onTap,
    bool? isLocked,
  }) {
    if(isLocked == null){
      isLocked = false;
    }
    return Card(
      elevation: 0,
      color: ColorManager.dotGrey.withOpacity(0.5),
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: ColorManager.black.withOpacity(0.2)
          ),
          borderRadius: BorderRadius.circular(10)
      ),

      child: InkWell(

        onTap: onTap,
        splashColor: ColorManager.blue.withOpacity(0.2),
        splashFactory: InkSplash.splashFactory,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(),
                  InkWell(
                      child: FaIcon(Icons.more_horiz,color: ColorManager.black,size: 18,))
                ],
              ),
              FaIcon(Icons.folder,color: ColorManager.textGrey.withOpacity(0.7),size: 40,),
              SizedBox(
                height: 5,
              ),
              Text('$folderName',style: getRegularStyle(color: ColorManager.textGrey,fontSize: 18),),
              SizedBox(
                height: 5,
              ),
              Text('$fileNumbers files',style: getRegularStyle(color: ColorManager.subtitleGrey,fontSize: 14),),
            ],
          ),
        ),
      ),

    );
  }

  /// folder properties customize...

  Widget _folderCustomize({
    required IconData icon,
    required String name,
    required VoidCallback onTap
  }) {
    return ListTile(
      onTap: onTap,
      leading: FaIcon(icon,color: ColorManager.blue.withOpacity(0.5),),
      title: Text('$name',style: getRegularStyle(color: ColorManager.blueText,fontSize: 16),),
    );
  }



}
