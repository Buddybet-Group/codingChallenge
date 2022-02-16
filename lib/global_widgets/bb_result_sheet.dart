import 'package:coding_chal/core/values/string_manager.dart';
import 'package:coding_chal/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

SliverChildListDelegate bbResultSheet(context) {
  const vSpacing = SizedBox(height: 20);
  final textTheme = Theme.of(context).textTheme;
  final controller = Get.find<HomeController>();
  final stringManager = Get.find<StringManager>();

  return SliverChildListDelegate(
    <Widget>[
      vSpacing,
      Text(
        "Hey ${controller.textController.text},",
        textAlign: TextAlign.center,
        style: textTheme.titleLarge,
      ),
      vSpacing,
      Text(
        stringManager.yourNationalityText,
        textAlign: TextAlign.center,
        style: textTheme.bodyLarge,
      ),
      vSpacing,
      Text(
        controller.country.value.countryName ?? "",
        textAlign: TextAlign.center,
        style: textTheme.bodyLarge!.copyWith(fontSize: 28, color: Colors.deepOrange),
      ),
      vSpacing,
      SizedBox(
        height: 100,
        child: Image.network(controller.country.value.flagUrl),
      ),
      vSpacing,
      Text(
        "Matches : ${getProbablity(controller.country.value.probability)} %",
        textAlign: TextAlign.center,
        style: textTheme.titleLarge,
      ),
    ],
  );
}

String getProbablity(double probability) {
  if (probability == 1) return "100";
  return probability.toStringAsFixed(2);
}
