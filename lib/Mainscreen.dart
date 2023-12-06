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

class _MainscreenState extends State<Mainscreen> {
  Random random = Random();
  final player = AudioPlayer();
  int dicenum = 1;
  int dicenum2 = 1;
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
      extendBodyBehindAppBar: true, // Allow body to extend behind the AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Set background color to transparent
        elevation: 0, // Remove AppBar elevation
        centerTitle: true, // Center align the title
        title: Text(
          "Roll the Dice",
          style: TextStyle(
            fontSize: 40.0, // Adjust font size if needed
            fontWeight: FontWeight.bold, // Adjust font weight if needed
            color: Colors.white, // Set text color to white
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
              colors: [Colors.blue, Colors.lightBlueAccent, Colors.white]),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 4,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/images/dice-${dicenum}.png'),
                    height: imageHeight,
                    width: imageWidth,
                  ),
                  Image(
                    image: AssetImage('assets/images/dice-${dicenum2}.png'),
                    height: imageHeight,
                    width: imageWidth,
                  )
                ],
              ),
              Spacer(flex: 3,),
              ElevatedButton(
                  onPressed: () {
                    dicenum = random.nextInt(6) + 1;
                    dicenum2 = random.nextInt(6) + 1;
                    int total = dicenum + dicenum2;

                    setState(() {
                      player.play(AssetSource('sounds/${total}.wav'));
                    });
                  },
                  child: Container(
                    height: btnHeight,
                    width: btnWidth,
                    child: Center(
                      child: Text("Roll me",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: fontSize, shadows: [
                            Shadow(
                                offset: Offset(2, 2),
                                color: Colors.black,
                                blurRadius: 8)
                          ])),
                    ),
                  )),

            Spacer(flex: 2,)],

          ),
        ),
      ),
    );
  }
}
