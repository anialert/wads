import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wads/auth/choosing.dart';
import 'package:wads/auth/registration.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState () {
    super.initState();
    Timer(Duration(seconds:3),
    (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegistrationScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/samplelogo.png'))
            ),
          ),
        ),
      ),
    );
  }
}