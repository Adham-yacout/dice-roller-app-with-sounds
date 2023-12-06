import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Mainscreen extends StatefulWidget {
  static String routename = "Mainsceen";

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen>
    with SingleTickerProviderStateMixin {
  Random random = Random();
  final player = AudioPlayer();
  int dicenum = 1;
  int dicenum2 = 1;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 360).animate(_controller);
  }


  // The dispose method is called when the widget is removed from the widget tree.
  @override
  void dispose() {
    // Dispose of the animation controller to release associated resources.
    _controller.dispose();
    super.dispose();
  }


  void _rollDices() {
    _controller.reset();
    _controller.forward();

    Timer(Duration(seconds: 1), () {
      setState(() {
        dicenum = random.nextInt(6) + 1;
        dicenum2 = random.nextInt(6) + 1;
        int total = dicenum + dicenum2;
        player.play(AssetSource('sounds/${total}.wav'));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double imageHeight = screenHeight * 0.5;
    double imageWidth = screenWidth * 0.4;
    double btnHeight = screenHeight * 0.05;
    double btnWidth = screenWidth * 0.2;
    double fontSize = screenWidth * 0.05;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Roll the Dice",
          style: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                offset: Offset(2, 2),
                color: Colors.black,
                blurRadius: 8,
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.lightBlueAccent, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(
                flex: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _animation.value,
                        child: Image(

                          image: AssetImage('assets/images/dice-$dicenum.png'),
                          height: imageHeight,
                          width: imageWidth,
                        ),
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _animation.value,
                        child: Image(

                          image: AssetImage('assets/images/dice-$dicenum2.png'),
                          height: imageHeight,
                          width: imageWidth,
                        ),
                      );
                    },
                  ),
                ],
              ),
              Spacer(
                flex: 3,
              ),
              ElevatedButton(
                onPressed: _rollDices,
                child: Container(
                  height: btnHeight,
                  width: btnWidth,
                  child: Center(
                    child: Text(
                      "Roll me",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fontSize,
                        shadows: [
                          Shadow(
                            offset: Offset(2, 2),
                            color: Colors.black,
                            blurRadius: 8,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}