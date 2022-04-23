import 'package:coding_chal/src/apis/api_base_helper.dart';

import 'home_model.dart';

class HomeController {
  Future<HomeResponse> getPridictedCountry(String name) async {
    var response = await ApiBaseHelper().getApiCall("?name=$name");
    return HomeResponse.fromJson(response);
  }
}
