import 'dart:async';
import 'package:get_it/get_it.dart';
import '../../../core/services/navigation/navigation_service.dart';
import '../../../core/services/navigation/navigation_service_impl.dart';
// import 'package:firebase_core/firebase_core.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator({bool test = false}) async {
  // await Firebase.initializeApp();
  locator
      .registerLazySingleton<NavigationService>(() => NavigationServiceImpl());
}
