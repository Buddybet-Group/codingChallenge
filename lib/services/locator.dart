

import 'package:coding_chal/services/api/api_services.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> SetUpLocator() async {
  locator.registerLazySingleton(() => ApiService.init());
}