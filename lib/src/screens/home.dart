import 'package:flutter/material.dart';
import '../widgets/cat.dart';
import 'dart:math';

class Home extends StatefulWidget{
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin{
  Animation<double> catAnimation;
  AnimationController catController;
  Animation<double> boxAnimation;
  AnimationController boxController;

  //Constructor generico de las clases State en Flutter.
  initState(){
    super.initState();  //To override.

    boxController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    boxAnimation = Tween(begin: 0.0, end: 3.14)
    .animate(
      CurvedAnimation(
        parent: boxController,
        curve: Curves.linear,
      )
    );

    catController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    catAnimation = Tween(begin: -35.0, end: -80.0)
      .animate(
        CurvedAnimation(
          parent: catController,
          curve: Curves.easeIn
        ),
      );

      //catController.forward(); //Start playing animation when the app loads.
  }

  onTap(){
    if(catController.status == AnimationStatus.completed){
      catController.reverse();
    } else if(catController.status == AnimationStatus.dismissed){
      catController.forward(); //Play animation on tap.
    }
  }

  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: GestureDetector(  //User taps on GestureDetector
        child: Center(
          child: Stack(
            overflow: Overflow.visible,
            children: [
              buildCatAnimation(),
              buildBox(),
              buildLeftFlap(),
            ],
          ),
        ),
        
        onTap: onTap,
      ),
    );
  }
  
  Widget buildCatAnimation(){
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child){ 
        //Child, para no repetir la animacion infinitmnte.
        //Container es el q se crea una y otra vez. Un elemento no muy pesado.
        return Positioned(
          child:  child,
          top: catAnimation.value,
          right: 0.0,
          left: 0.0,
        );
      },
      child: Cat(),
    );
  }

  Widget buildBox() {
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown,
    );
  }

  Widget buildLeftFlap(){
    return Positioned(
      left: 3.0,
      child:
        Transform.rotate(
          child: Container(
            height: 10.0,
            width: 125.0,
            color: Colors.brown,
          ),
          angle: pi * 0.6,
          alignment: Alignment.topLeft,
      )
    );
  }
}