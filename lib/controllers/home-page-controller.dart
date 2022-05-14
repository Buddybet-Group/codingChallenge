import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import '../core/domain/entities/country.dart';
import '../core/domain/repository/api_respository.dart';
import '../data/models/result-model.dart';

class HomeController extends GetxController {
  final _apiRepository = Get.find<ApiRespository>();

  /// Check the state is busy or not.
  final RxBool _isBusy = RxBool(false);

  /// Returns whether the state is busy or not.
  bool get isBusy => _isBusy.value;

  /// The observable list of data.
  RxList<Country> _countries = RxList();

  /// List of countries.
  List<Country> get countries => _countries;

  void fetchResult(String name) async {
    try {
      _isBusy.value = true;

      final SearchResultModel? results =
          await _apiRepository.fetchResults(name);

      _isBusy.value = false;

      if (results != null) {
        _countries = RxList.from(
          results.countries.map((e) =>
              Country(countryId: e.countryId, probability: e.probability)),
        );
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
