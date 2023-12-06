import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Diceroll extends StatefulWidget {
  const Diceroll({Key? key}) : super(key: key);

  @override
  State<Diceroll> createState() => _DicerollState();
}

class _DicerollState extends State<Diceroll>
    with SingleTickerProviderStateMixin {
  Random random = Random();
  final player = AudioPlayer();
  late AnimationController _controller;
  late Animation<double> _animation;
  int dicenum = 1;
  int dicenum2 = 1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 360).animate(_controller);
  }

  @override
  void dispose() {
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
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double imageHeight = screenHeight * 0.5;
    double imageWidth = screenWidth * 0.4;
    double btnHeight = screenHeight * 0.05;
    double btnWidth = screenWidth * 0.2;
    double fontSize = screenWidth * 0.05;

    return Column(
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
    );
  }
}
