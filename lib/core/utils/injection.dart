import 'package:coding_chal/core/utils/utils.dart';
import 'package:coding_chal/modules/home/home_controller.dart';
import 'package:coding_chal/providers/api/nations_api.dart';
import 'package:coding_chal/providers/repository/nations_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../configurations/configuration.dart';
import '../values/environment.dart';
import '../values/string_manager.dart';

/// Sets up Dependency Injection (DI).
/// Injects the provided classes along with the other classes/services/repositories necessary to run the application.
void setupInjection({
  required Configuration configuration,
  required StringManager stringManager,
  required Environment environment,
}) {
  Get
    ..put(configuration, permanent: true)
    ..put(stringManager, permanent: true)
    ..put(_utils(), permanent: true)
    ..put(environment, permanent: true)
    ..put(_logger, permanent: true)
    ..put(_dio, permanent: true)
    ..lazyPut(() => _homeController)
    ..lazyPut(() => _nationsApi)
    ..lazyPut(() => _nationsRepository);
}

///Utilities
Logger get _logger => Logger();

Utils _utils() {
  Utils utils = Utils();
  utils.loadJsonIntoMemory();
  return utils;
}

Dio get _dio => setupDioRestClient(configuration: Get.find<Configuration>());

NationsApi get _nationsApi => NationsApi(Get.find<Dio>());

NationsRepository get _nationsRepository => NationsRepository();

/// Controllers
HomeController _homeController = HomeController();

/// Setup function to set up The Dio Based Rest Client Used for API services to make remote API calls
/// To be used in injection logic only
Dio setupDioRestClient({
  required Configuration configuration,
}) {
  final options = BaseOptions(
    baseUrl: configuration.baseUrl,
    connectTimeout: configuration.restClientConnectTimeout,
    receiveTimeout: configuration.restClientReceiveTimeout,
  );
  final dio = Dio(options);
  return dio;
}
