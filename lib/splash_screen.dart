import 'package:flutter/material.dart';
import 'dart:async';
import 'package:anivohayvanses/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 2),
            () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    var sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Center(
        child: Image.asset(
          'assets/splash_screen.png',
          width: sizeScreen.width * 0.7,
          height: sizeScreen.height * 0.7,
        ),
      ),
    );
  }
}
