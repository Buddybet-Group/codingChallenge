import 'dart:developer';
import 'package:coding_chal/models/country_model.dart';
import 'package:coding_chal/services/network_call.dart';
import 'package:coding_chal/services/server_response.dart';
import 'package:coding_chal/utils/constents/constants.dart';
import 'package:get/state_manager.dart';

class HomeController extends GetxController {
  final _api = NetworkCall();

  /// when we call api [isLoading] would be true otherwise false
  RxBool isLoading = false.obs;

  RxList<Country> countryList = <Country>[].obs;

  Future<void> fetchPredictionData(String name) async {
    try {
      isLoading.value = true;
      String queryParameter = '?name=$name';
      ServerResponse response = await _api.get(queryParameter);
      if (response.success) {
        countryList.clear();
        CountryModel countryModel = CountryModel.fromJson(response.data);
        if (countryModel.country != null && countryModel.country!.isNotEmpty) {
          countryList.assignAll(countryModel.country!.toList());
        }
      } else {
        throw customError;
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }
}
