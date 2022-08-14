import 'package:flutter/cupertino.dart';
import 'package:ping_pong/components/ball.dart';
import 'package:ping_pong/components/bat.dart';

//For Directions
enum Direction{up,down,left,right}

class Pong extends StatefulWidget {
  const Pong({Key? key}) : super(key: key);

  @override
  State<Pong> createState() => _PongState();
}

double? width;
double? height;
double posX = 0;
double posY = 0;
double batWidth = 0;
double batHeight = 0;
double batPosition = 0;
Animation<double>? animation;
AnimationController? controller;
Direction vDir

class _PongState extends State<Pong> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    posX = 0;
    posY = 0;
    //Duration and animation of the ball
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    animation = Tween<double>(begin: 0, end: 100).animate(controller!);
    animation?.addListener(() {
      setState(() {
        posX++;
        posY++;
      });
    });
    controller?.forward(); //Starts the animation when the value changes
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      //Dimensions set to fit relative screens
      height = constraints.maxHeight;
      width = constraints.maxWidth;
      batHeight = height! / 20;
      batWidth = width! / 5;

      return Stack(
        children: <Widget>[
          Positioned(
            top: posY,
            left: posX,
            child: Ball(),
          ),
          Positioned(
            bottom: 0,
            child: Bat(width: 200, height: 25),
          )
        ],
      );
    });
  }
}
