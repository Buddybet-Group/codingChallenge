import 'package:get_it/get_it.dart';
import 'api_service/main_apiservices.dart';

final locator = GetIt.instance;

Future<void> SetLocator() async {
  locator.registerLazySingleton(() => ApiService.init());
}