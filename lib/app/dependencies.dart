import 'package:get/get.dart';

import '../core/domain/repository/api_respository.dart';
import '../data/services/api_service.dart';

class Dependencies extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiRespository>(() => ApiService());
  }
}
