





import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../core/resources/color_manager.dart';



class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage(this.title);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{

  late Animation<double> _animation;
  late AnimationController _animationController;
  bool set = false;

  @override
  void initState(){

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);


    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

        //Init Floating Action Bubble
        floatingActionButton: FloatingActionBubble(
          // Menu items
          items: <Bubble>[


            // Floating action menu item
            Bubble(
              title:"Add Patient",
              iconColor :Colors.white,
              bubbleColor : ColorManager.primary,
              icon:Icons.people,
              titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
              onPress: () {
                _animationController.reverse();
              },
            ),
            //Floating action menu item
            Bubble(
              title:"Chat",
              iconColor :Colors.white,
              bubbleColor : ColorManager.primary,
              icon:CupertinoIcons.bubble_left_bubble_right_fill,
              titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
              onPress: () {
                _animationController.reverse();
              },
            ),
          ],

          // animation controller
          animation: _animation,

          // On pressed change animation state
          onPress: ()
          {
            _animationController.isCompleted
                ? _animationController.reverse()
                : _animationController.forward();
            setState(() {
              set=!set;
            });
          },

          // Floating Action button Icon color
          iconColor: ColorManager.white,

          // Flaoting Action button Icon
          iconData: set? Icons.menu : CupertinoIcons.xmark,
          backGroundColor: ColorManager.primary,
        )
    );
  }

}