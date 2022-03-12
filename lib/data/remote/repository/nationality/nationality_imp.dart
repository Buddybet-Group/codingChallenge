import 'package:coding_chal/data/model/nationality_response.dart';
import 'package:coding_chal/data/remote/api/api_service.dart';
import 'package:coding_chal/data/remote/api/base_api.dart';
import 'package:http/http.dart';

import 'nationality.dart';

class NationalityImpl implements NationalityRepo {
  final Client _client;
  late BaseApiService _apiService;

  NationalityImpl(this._client) {
    _apiService = ApiService(_client);
  }

  @override
  Future<NationalityResponse?> getNationality(String name) async {
    try {
      dynamic response = await _apiService.getResponse('?name=$name');
      final jsonData = NationalityResponse.fromJson(response);
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }
}
