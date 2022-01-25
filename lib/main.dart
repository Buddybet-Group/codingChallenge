import 'package:flutter/material.dart';

import 'body_widget.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("BuddyBet Coding Challege"),
        ),
        body: const BodyWidget(),
      ),
    ),
  );
}
