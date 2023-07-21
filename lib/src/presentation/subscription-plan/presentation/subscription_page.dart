

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';
import 'package:medical_app/src/core/resources/style_manager.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/resources/value_manager.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  int selectedDuration = 0;
  int selectSubscription = 0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Stack(
        children: [
          Visibility(
            visible: selectedDuration == 0,
              child: _buildMonthBody()
          ),
          Visibility(
              visible: selectedDuration == 1,
              child: _buildYearBody()
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
                    onPressed: (){},
                    child: Text('Select',style: getMediumStyle(color: ColorManager.white,fontSize: 24),)
                ),
                h20,
              ],
            ),
          )
        ],

      ),
    );
  }


  Widget _buildMonthBody(){
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
                  schemeName: 'Gold',
                  schemeDuration: 'month',
                  schemePrice: 100,
                  selectSubscription: 1
                ),
              ),
              h20,
              _buildSubscriptionTile(
                  onTap: (){
                    setState(() {
                      selectSubscription = 0;
                    });
                  },
                  schemeName: 'Gold',
                  schemePrice: 200,
                  schemeDuration: 1,
                  selection: 0
              ),
              h10,
              _buildSubscriptionTile(
                  onTap: (){
                    setState(() {
                      selectSubscription = 1;
                    });
                  },
                  schemeName: 'Silver',
                  schemePrice: 500,
                  schemeDuration: 1,
                  selection: 1
              ),
              h10,
              _buildSubscriptionTile(
                  onTap: (){
                    setState(() {
                      selectSubscription = 2;
                    });
                  },
                  schemeName: 'Premium',
                  schemePrice: 2000,
                  schemeDuration: 1,
                  selection: 2
              ),
              h10,
              _buildSubscriptionTile(
                  onTap: (){
                    setState(() {
                      selectSubscription = 3;
                    });
                  },
                  schemeName: 'Trial for 15 days',
                  schemePrice: 0,
                  schemeDuration: 1,
                  selection: 3
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildYearBody(){
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
                  schemeName: 'Gold',
                  schemeDuration: 'year',
                  schemePrice: 1000,
                  selectSubscription: 1
                ),
              ),
              h20,
              _buildSubscriptionTile(
                  onTap: (){
                    setState(() {
                      selectSubscription = 0;
                    });
                  },
                  schemeName: 'Gold',
                  schemePrice: 500,
                  schemeDuration: 2,
                  selection: 0
              ),
              h10,
              _buildSubscriptionTile(
                  onTap: (){
                    setState(() {
                      selectSubscription = 1;
                    });
                  },
                  schemeName: 'Silver',
                  schemePrice: 1000,
                  schemeDuration: 2,
                  selection: 1
              ),
              h10,
              _buildSubscriptionTile(
                  onTap: (){
                    setState(() {
                      selectSubscription = 2;
                    });
                  },
                  schemeName: 'Premium',
                  schemePrice: 5000,
                  schemeDuration: 2,
                  selection: 2
              ),
              h10,
              _buildSubscriptionTile(
                  onTap: (){
                    setState(() {
                      selectSubscription = 3;
                    });
                  },
                  schemeName: 'Trial for 15 days',
                  schemePrice: 0,
                  schemeDuration: 2,
                  selection: 3
              )
            ],
          ),
        ),
      ),
    );
  }



  Widget _buildSubscriptionTile({
    required VoidCallback onTap,
    required String schemeName,
    required int schemePrice,
    required int schemeDuration,
    required int selection,
}) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      elevation: selectSubscription == selection?3:0,
      child: ListTile(
        onTap: onTap,
        tileColor:selectSubscription == selection? ColorManager.primary.withOpacity(0.1):ColorManager.white ,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
                color: selectSubscription == selection?ColorManager.primary:ColorManager.black.withOpacity(0.5),
                width: selectSubscription == selection?1:0.5
            )
        ),
        leading: Text('$schemeName',style: getMediumStyle(color: selectSubscription == selection?ColorManager.black:ColorManager.black.withOpacity(0.5),fontSize: 20),),
        trailing: Text(schemePrice==0?'Free':'Rs.$schemePrice per ${schemeDuration ==1 ? 'month': 'year'}',style: getRegularStyle(color: selectSubscription == selection?ColorManager.black:ColorManager.black.withOpacity(0.5),fontSize: 18),),
      ),
    );
  }

  Widget _buildSubBanner({
    required String schemeName,
    required int schemePrice,
    required String schemeDuration,
    required int selectSubscription

}) {
    return CustomBannerShimmer(
        width: 340,
        height: 200,
        borderRadius: 20,
        gradient: selectSubscription ==0
            ? ColorManager.goldContainer
            : selectSubscription ==1
            ? ColorManager.silverContainer
            : selectSubscription ==2
            ? ColorManager.premiumContainer
            : selectSubscription ==3
            ? ColorManager.blackContainer
            : ColorManager.goldContainer,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$schemeName',style: getBoldStyle(color: ColorManager.white,fontSize: 40),),
            h20,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Rs. ',style: getMediumStyle(color: ColorManager.white,fontSize: 24),),
                Text('$schemePrice',style: getMediumStyle(color: ColorManager.white,fontSize: 80),),
                w10,
                Text('for a $schemeDuration',style: getMediumStyle(color: ColorManager.white,fontSize: 24),),
              ],
            ),
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
