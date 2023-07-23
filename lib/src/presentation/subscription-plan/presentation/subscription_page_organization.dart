

import 'package:animate_do/animate_do.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';
import 'package:medical_app/src/core/resources/style_manager.dart';
import 'package:medical_app/src/core/utils/shimmer.dart';
import 'package:medical_app/src/presentation/login/presentation/login_page.dart';
import 'package:medical_app/src/presentation/subscription-plan/domain/scheme_service.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/api.dart';
import '../../../core/resources/value_manager.dart';
import '../../common/snackbar.dart';
import '../../register/domain/register_service.dart';
import '../domain/scheme_model.dart';

class SubscriptionPageOrganization extends ConsumerStatefulWidget {
  final Map<String,dynamic> outputValue ;
  final String password;
  SubscriptionPageOrganization({required this.outputValue,required this.password});

  @override
  ConsumerState<SubscriptionPageOrganization> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends ConsumerState<SubscriptionPageOrganization> {



  int selectedDuration = 0;
  int selectSubscription = 0;
  int schemePlanId = 1;
  final dio = Dio();
  SchemeModel? selectedScheme;
  bool isPostingData = false;



  Future<dartz.Either<String, dynamic>> subscriptionPlan({

    required int schemePlanId,
  }) async {
    try {
      final response = await dio.post(
          Api.subscriptionPlan,
          data: {
            "id": 0,
            "userid": '${widget.outputValue['result']['orgId']}',
            "subscriptionID": schemePlanId,
            "fromDate": "${DateFormat('yyyy-MM-dd').format(DateTime.now()).toString()}",
            "toDate": selectSubscription == 7 || selectSubscription == 8
                ? "${DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 15))).toString()}"
                :selectedDuration==0
                ?"${DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 30))).toString()}"
                :"${DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 365))).toString()}",
            "flag": ""
          }
      );

      print(response.data);
      return dartz.Right(response.data);
    } on DioException catch (err) {
      print(err.response);


      throw Exception('Dio error: ${err.message}');
    }}



  Future<dartz.Either<String, dynamic>> userRegisterOrganization() async {
    try {
      print('${widget.password}');
      final response = await dio.post(
          Api.userRegister,
          data: {
            "userID": '${widget.outputValue['result']['orgId']}',
            "typeID": 2,
            "parentID": "0",
            "firstName": '${widget.outputValue['result']['organizationName']}',
            "lastName": "",
            "password": '${widget.password}',
            "contactNo": '${widget.outputValue['result']['contact']}',
            "panNo": widget.outputValue['result']['pan'],
            "natureID": widget.outputValue['result']['natureId'],
            "liscenceNo": 0,
            "email": '${widget.outputValue['result']['email']}',
            "roleID": 2,
            "joinedDate": "${DateFormat('yyyy-MM-dd').format(DateTime.now()).toString()}",
            "isActive": true,
            "genderID": 0,
            "entryDate": "${DateFormat('yyyy-MM-dd').format(DateTime.now()).toString()}",
            "key": "12",
            "flag": "Register"
          }
      );

      print(response.data);
      return dartz.Right(response.data);
    } on DioException catch (err) {
      print(err.response);


      throw Exception('Dio error: ${err.message}');
    }}





  @override
  Widget build(BuildContext context) {

    print('output: ${widget.outputValue}');
    final schemeData = ref.watch(schemeList);
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Stack(
        children: [
          Visibility(
            visible: selectedDuration == 0,
              child: _buildMonthBody(schemeData)
          ),
          Visibility(
              visible: selectedDuration == 1,
              child: _buildYearBody(schemeData)
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 50.h,
                  width: 240.w,
                  decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                      color: ColorManager.black.withOpacity(0.5),
                      width: 0.5
                    )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: (){
                          setState(() {
                            selectedDuration = 0;
                          });
                        },
                        splashColor: Colors.transparent,
                        child: Container(
                          width: 90.w,
                          child: Center(child: Text('Monthly',style: selectedDuration==0? getRegularStyle(color: ColorManager.black,fontSize: 24):getRegularStyle(color: ColorManager.black.withOpacity(0.5)),)),
                        ),
                      ),
                      VerticalDivider(
                        endIndent: 8.h,
                        indent: 8.h,
                        thickness: 0.5,
                        color: ColorManager.black,
                      ),
                      InkWell(
                        onTap: (){
                          setState(() {
                            selectedDuration = 1;
                          });
                        },
                        splashColor: Colors.transparent,
                        child: Container(
                          width: 90.w,
                          child: Center(child: Text('Yearly',style: selectedDuration==1? getRegularStyle(color: ColorManager.black,fontSize: 24):getRegularStyle(color: ColorManager.black.withOpacity(0.5)),)),
                        ),
                      ),
                    ],
                  )
                ),
                h20,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromWidth(300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: ColorManager.primary
                  ),
                    onPressed: isPostingData
                        ? null // Disable the button while posting data
                        : ()async{
                      final scaffoldMessage = ScaffoldMessenger.of(context);
                    if(selectedScheme == null){
                      scaffoldMessage.showSnackBar(
                        SnackbarUtil.showFailureSnackbar(
                            message: 'Please Select a scheme first',
                            duration: const Duration(seconds: 2)
                        ),
                      );
                    } else{
                      setState(() {
                        isPostingData = true; // Show loading spinner
                      });
                      await subscriptionPlan(
                          schemePlanId: selectedScheme?.schemePlanID ?? 0
                      ).then((value) async => await userRegisterOrganization()).then((value) =>Future.delayed(Duration(seconds: 3))).then((value) =>
                          setState(() {
                            isPostingData = false; // Show loading spinner
                          })
                      ).then((value) {
                        scaffoldMessage.showSnackBar(
                          SnackbarUtil.showSuccessSnackbar(
                              message: 'User Registered! Please Login again.',
                              duration: const Duration(seconds: 3)
                          ),
                        );

                      }).then((value) =>  Get.offAll(LoginPage())).catchError((e){
                        scaffoldMessage.showSnackBar(
                          SnackbarUtil.showFailureSnackbar(
                              message: '$e',
                              duration: const Duration(seconds: 2)
                          ),
                        );
                        setState(() {
                          isPostingData = false; // Show loading spinner
                        });
                      });
                    }

                    },
                    child: isPostingData
                        ?SpinKitDualRing(color: ColorManager.white,size: 20,) 
                    :Text('Select',style: getMediumStyle(color: ColorManager.white,fontSize: 24),)
                ),
                h20,
              ],
            ),
          )
        ],

      ),
    );
  }


  Widget _buildMonthBody(AsyncValue<List<SchemeModel>> schemeData) {


    return schemeData.when(
        data: (data){

          final schemeMonth = data.where(
                (item) => item.storageType==1).toList();
          // If selectedScheme is null, set a default selected value (the first item in the list)
          selectedScheme ??= schemeMonth.isNotEmpty ? schemeMonth.first : null;

          return FadeIn(
            duration: Duration(milliseconds: 500),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 24.h),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Select your',style: getRegularStyle(color: ColorManager.textGrey,fontSize: 30),),
                    h10,
                    Text('Subscription\nPlan',style: getBoldStyle(color: ColorManager.textGrey,fontSize: 60),textAlign: TextAlign.start,),
                    h10,
                    Center(
                      child: _buildSubBanner(
                        schemeName: '${selectedScheme?.schemeNames}',
                        schemeDuration: selectedScheme?.storageType == 1 ? 'month' : 'year',
                        schemePrice: int.parse(selectedScheme?.price!.round().toString() ?? '0'),
                        selectSubscription: schemePlanId,
                        gradient: selectedScheme?.schemeNames == 'GOLD'
                            ?ColorManager.goldContainer
                            :selectedScheme?.schemeNames == 'SILVER'
                            ?ColorManager.silverContainer
                            :selectedScheme?.schemeNames == 'PLATINUM'
                            ?ColorManager.blackContainer
                            :ColorManager.primary ,
                      ),
                    ),


                    h20,
                    ListView.builder(

                      shrinkWrap: true,
                      itemCount: schemeMonth.length,
                      itemBuilder: (context, index) {
                        return _buildSubscriptionTile(
                          onTap: () {
                            setState(() {
                              schemePlanId = schemeMonth[index].schemePlanID!;
                              selectedScheme = schemeMonth[index]; // Set the selectedScheme
                            });
                            print(schemePlanId);
                          },
                          schemeName: '${schemeMonth[index].schemeNames}',
                          schemePrice: int.parse(schemeMonth[index].price!.round().toString()),
                          schemeDuration: schemeMonth[index].storageType!,
                          selection: schemeMonth[index].schemePlanID!,
                        );
                      },
                    )

                  ],
                ),
              ),
            ),
          );
        }, 
        error: (error,stack)=>Center(child: Text('error',style: getRegularStyle(color: ColorManager.black),),), 
        loading: ()=>buildShimmerEffect()
    );
      
      
  }


  Widget _buildYearBody(AsyncValue<List<SchemeModel>> schemeData) {


    return schemeData.when(
        data: (data){

          final schemeYear = data.where((item) => item.storageType == 2).toList();

          // If selectedScheme is null, set a default selected value (the first item in the list)
          selectedScheme ??= schemeYear.isNotEmpty ? schemeYear.first : null;


          return FadeIn(
            duration: Duration(milliseconds: 500),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 24.h),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Select your',style: getRegularStyle(color: ColorManager.textGrey,fontSize: 30),),
                    h10,
                    Text('Subscription\nPlan',style: getBoldStyle(color: ColorManager.textGrey,fontSize: 60),textAlign: TextAlign.start,),
                    h10,
                    Visibility(
                      visible: selectedScheme != null && schemePlanId == selectedScheme!.schemePlanID,
                      child: Center(
                        child: _buildSubBanner(
                          schemeName: '${selectedScheme?.schemeNames}',
                          schemeDuration: selectedScheme?.storageType == 1 ? 'month' : 'year',
                          schemePrice: int.parse(selectedScheme?.price!.round().toString() ?? '0'),
                          selectSubscription: schemePlanId,
                          gradient: selectedScheme?.schemeNames == 'GOLD'
                              ?ColorManager.goldContainer
                              :selectedScheme?.schemeNames == 'SILVER'
                              ?ColorManager.silverContainer
                              :selectedScheme?.schemeNames == 'PLATINUM'
                              ?ColorManager.blackContainer
                              :ColorManager.primary ,
                        ),
                      ),
                    ),


                    h20,
                    ListView.builder(

                      shrinkWrap: true,
                      itemCount: schemeYear.length,
                      itemBuilder: (context, index) {
                        return _buildSubscriptionTile(
                          onTap: () {
                            setState(() {
                              schemePlanId = schemeYear[index].schemePlanID!;
                              selectedScheme = schemeYear[index]; // Set the selectedScheme
                            });
                            print(schemePlanId);
                          },
                          schemeName: '${schemeYear[index].schemeNames}',
                          schemePrice: int.parse(schemeYear[index].price!.round().toString()),
                          schemeDuration: schemeYear[index].storageType!,
                          selection: schemeYear[index].schemePlanID!,
                        );
                      },
                    )

                  ],
                ),
              ),
            ),
          );
        },
        error: (error,stack)=>Center(child: Text('error',style: getRegularStyle(color: ColorManager.black),),),
        loading: ()=>buildShimmerEffect()
    );


  }





  Widget _buildSubscriptionTile({
    required VoidCallback onTap,
    required String schemeName,
    required int schemePrice,
    required int schemeDuration,
    required int selection,
}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        elevation: schemePlanId == selection?3:0,
        child: ListTile(
          onTap: onTap,
          tileColor:schemePlanId == selection? ColorManager.primary.withOpacity(0.1):ColorManager.white ,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                  color: schemePlanId == selection?ColorManager.primary:ColorManager.black.withOpacity(0.5),
                  width: schemePlanId == selection?1:0.5
              )
          ),
          leading: Text('$schemeName',style: getMediumStyle(color: selectSubscription == selection?ColorManager.black:ColorManager.black.withOpacity(0.5),fontSize: 20),),
          trailing: Text(schemePrice==0?'Free':'Rs.$schemePrice per ${schemeDuration ==1 ? 'month': 'year'}',style: getRegularStyle(color: selectSubscription == selection?ColorManager.black:ColorManager.black.withOpacity(0.5),fontSize: 18),),
        ),
      ),
    );
  }

  Widget _buildSubBanner({
    required String schemeName,
    required int schemePrice,
    String? schemeDuration,
    required int selectSubscription,
    required Color gradient,

}) {
    return CustomBannerShimmer(
        width: 340,
        height: 200,
        borderRadius: 20,
        gradient: gradient,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            schemeDuration!=null?Text('$schemeName',style: getBoldStyle(color: ColorManager.white,fontSize: 40),):Text('Trial',style: getBoldStyle(color: ColorManager.white,fontSize: 20),),
            h20,
            schemeDuration != null?
                schemePrice != 0?
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Rs. ',style: getMediumStyle(color: ColorManager.white,fontSize: 24),),
                Text('$schemePrice',style: getMediumStyle(color: ColorManager.white,fontSize: 80),),
                w10,
                Text('for a $schemeDuration',style: getMediumStyle(color: ColorManager.white,fontSize: 24),),
              ],
            )
                    :Text('Free for a 15 days',style: getMediumStyle(color: ColorManager.white,fontSize: 24),)
                :Text('$schemeName',style: getMediumStyle(color: ColorManager.white,fontSize: 40),),
            h12,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.check,color: ColorManager.white,size: 12,),
                w10,
                Text('Access to new features',style: getMediumStyle(color: ColorManager.white,fontSize: 18),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.check,color: ColorManager.white,size: 12,),
                w10,
                Text('features 2',style: getMediumStyle(color: ColorManager.white,fontSize: 18),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.check,color: ColorManager.white,size: 12,),
                w10,
                Text('features 3',style: getMediumStyle(color: ColorManager.white,fontSize: 18),),
              ],
            ),


          ],
        )
    );



  }

}



/// Banner Shimmer animation.....

class CustomBannerShimmer extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Color gradient;
  final Widget child;

  const CustomBannerShimmer({
    Key? key,
    required this.width,
    required this.height,
    this.borderRadius = 0.0,
    required this.gradient,
    required this.child
  }) : super(key: key);

  @override
  CustomBannerShimmerState createState() => CustomBannerShimmerState();
}

class CustomBannerShimmerState extends State<CustomBannerShimmer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _gradientPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(

      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    _gradientPosition = Tween<double>(begin: -2.0, end:2.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Card(
        color: Colors.transparent,
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius)
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              colors: [
                widget.gradient,
                ColorManager.white,
                widget.gradient,
              ],
              stops: const [0.0, 0.5, 0.8],
              begin: FractionalOffset(_gradientPosition.value, 0.0),
              end: FractionalOffset(2.0 + _gradientPosition.value, 2.0 + _gradientPosition.value),
            ),
          ),
          child: Container(
            height: widget.height,
            width: widget.width,
            padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 12.w),
            decoration: BoxDecoration(
              color: widget.gradient.withOpacity(0.6),
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double gradientTranslation(double begin, double end) {
    return (begin + (end - begin) * _gradientPosition.value + 1.0) / 3.0 * widget.width;
  }
}
