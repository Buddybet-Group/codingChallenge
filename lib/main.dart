import 'package:coding_chal/screen/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.blueAccent,
          textTheme: const TextTheme(
              button: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w600))),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("BuddyBet Coding Challege"),
        ),
        body: const HomeScreen(),
      )));
}
