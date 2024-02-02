import 'package:flutter/material.dart';
import 'pages/intro.dart';
import 'pages/signup.dart';
import 'pages/api.dart';

//import 'pages/login.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroPage(),

      routes: {
        '/intro': (context) => IntroPage(),
        //'/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/api': (context) => TournoiPage(),
      }
    );
  }
}
