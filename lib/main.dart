import 'package:flutter/material.dart';


import 'Mainscreen.dart';

Future<void> main() async {

  runApp (MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Roll the dice",
      debugShowCheckedModeBanner: false,
      initialRoute: Mainscreen.routename,
      routes: {
        Mainscreen.routename : (context)=>Mainscreen(),
      },
    );

  }




}