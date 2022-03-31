import 'package:coding_chal/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'BuddyBet Coding Challege',
      theme: ThemeData(
          //fontFamily: "RobotoSlab",
          //primarySwatch: primarySwatch,
          backgroundColor: const Color(0xffffffff),
          textTheme: const TextTheme (

            bodyText1: TextStyle(fontSize: 20, color: Color(0xff000000), fontWeight: FontWeight.normal),
            bodyText2: TextStyle(fontSize: 14, color: Color(0xff000000), fontWeight: FontWeight.normal, height: 1.5),

          )
      ),
      home: const Home(title: 'BuddyBet Coding Challege'),
    );
  }
}