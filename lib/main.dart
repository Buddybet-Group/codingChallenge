import 'package:coding_chal/widget/nationality_checker_widget.dart';
import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      home: Scaffold(
    appBar: AppBar(
      title: const Text("BuddyBet Coding Challege"),
    ),
    body: const NationalityCheckerWidget(),
  )));
}
