import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_app/src/core/resources/color_manager.dart';
import 'package:medical_app/src/core/resources/style_manager.dart';


class TestPage extends StatefulWidget {
  @override
  _DraggableLinePageState createState() => _DraggableLinePageState();
}

class _DraggableLinePageState extends State<TestPage> {
  double _linePositionY = 200.0;
  double y = 0.4;// Initial Y position of the line

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height*1/2,
            child: GestureDetector(
              onVerticalDragUpdate: (value){
                double yValue = value.delta.dy;
                if(yValue<0){
                  setState(() {
                    y = y-0.005;
                  });
                  print('upward');
                }else{
                  setState(() {
                    y = y+0.005;
                  });
                  print('downward');
                }
              },
              child: Container(
                height: double.infinity,
                color: Colors.blue,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment(0, y),
                      child: Container(
                        height: 100,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                color: Colors.green,
                                height: 50,
                                width: 100,
                                child: Center(child: Text('${(y/0.1).toPrecision(1)}',style: getRegularStyle(color: ColorManager.black,fontSize: 20),)),
                              ),
                            ),
                            Container(
                              height: 2,
                              width: double.infinity,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height*1/2,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}