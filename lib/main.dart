import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wads/admin/adminhomescreen.dart';

import 'package:wads/admin/officershome.dart';
import 'package:wads/admin/profile.dart';
import 'package:wads/auth/choosing.dart';
import 'package:wads/auth/loginpage.dart';
import 'package:wads/auth/registration.dart';
import 'package:wads/splashscreen.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        useMaterial3: true,
      ),
      home:SplashScreen(),
    );
  }
}





