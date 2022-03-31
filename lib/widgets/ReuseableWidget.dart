import 'package:flutter/material.dart';
import 'package:get/get.dart';

customText(margin,textname){
  return Container(
    margin:  margin,
    child: Text(textname,
        style: TextStyle(
          fontFamily: 'sans-serif-medium',
          fontSize: Get.pixelRatio * 8,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          letterSpacing: 0,
        )),
  );
}

