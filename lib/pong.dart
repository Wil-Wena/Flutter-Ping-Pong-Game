import 'package:flutter/cupertino.dart';
import 'package:ping_pong/components/ball.dart';
import 'package:ping_pong/components/bat.dart';

//For Directions
enum Direction { up, down, left, right }

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
Direction vDir = Direction.down;
Direction hDir = Direction.right;
double increment = 5;

class _PongState extends State<Pong> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    posX = 0;
    posY = 0;
    //Duration and animation of the ball
    controller = AnimationController(
        vsync: this, duration: const Duration(minutes: 10000));
    animation = Tween<double>(begin: 0, end: 100).animate(controller!);
    animation?.addListener(() {
      setState(() {
        (hDir == Direction.right) ? posX += increment : posX -= increment;
        (vDir == Direction.down) ? posY += increment : posY -= increment;
      });
      checkBorders();
    });
    controller?.forward(); //Starts the animation when the value changes
    super.initState();
  }

  void checkBorders() {
    if (posX <= 0 && hDir == Direction.left) {
      hDir = Direction.right;
    }
    if (posX >= width! - 50 && hDir == Direction.right) {
      hDir = Direction.left;
    }
    if (posY >= height! - 50 && vDir == Direction.down) {
      vDir = Direction.up;
    }
    if (posY <= 0 && vDir == Direction.up) {
      vDir = Direction.down;
    }
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
