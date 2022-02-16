import 'package:coding_chal/core/values/assets.dart';
import 'package:coding_chal/providers/api/country.dart';
import 'package:coding_chal/providers/api/get_nationality_response.dart';
import 'package:coding_chal/providers/api/nations_api.dart';
import 'package:get/instance_manager.dart';
import 'package:logger/logger.dart';

/// Repository to access nations api
class NationsRepository {
  /// New instance of [NationsRepository]
  NationsRepository({NationsApi? nationsApi, Logger? logger})
      : _nationsApi = nationsApi ?? Get.find<NationsApi>(),
        _logger = logger ?? Get.find<Logger>();

  NationsApi _nationsApi;
  Logger _logger;

  /// Get the high probabile nationality from the name
  Future<Country> getNationality(String name) async {
    _logger.d("...requesting nationality for $name");
    GetNationalityResponse response = await _nationsApi.getNationality(name);

    /// PROCESS
    return response.country[0];
  }
}
