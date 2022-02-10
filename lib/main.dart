import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/dependencies.dart';
import 'app/routes.dart';

void main() {
  runApp(
    GetMaterialApp(
      getPages: Routes.routes,
      initialBinding: Dependencies(),
    ),
  );
}
