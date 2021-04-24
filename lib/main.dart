import 'package:flutter/material.dart';
import 'package:saloon_booking/Login.dart';
import 'package:saloon_booking/signup.dart';
import 'package:saloon_booking/splash_screen.dart';
//import 'package:saloon_booking/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
      routes: <String, WidgetBuilder>{
        "Login": (BuildContext context) => Login(),
        //"SignUp":(BuildContext context)=>SignUp(),
        // "start":(BuildContext context)=>Start(),
      },
    );
  }
}
