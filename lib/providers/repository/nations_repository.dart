import 'package:coding_chal/core/utils/utils.dart';
import 'package:coding_chal/providers/api/country.dart';
import 'package:coding_chal/providers/api/get_nationality_response.dart';
import 'package:coding_chal/providers/api/nations_api.dart';
import 'package:get/instance_manager.dart';
import 'package:logger/logger.dart';

/// Repository to access nations api
class NationsRepository {
  /// New instance of [NationsRepository]
  NationsRepository({
    NationsApi? nationsApi,
    Logger? logger,
    Utils? utils,
  })  : _nationsApi = nationsApi ?? Get.find<NationsApi>(),
        _logger = logger ?? Get.find<Logger>(),
        _utils = utils ?? Get.find<Utils>();

  final NationsApi _nationsApi;
  final Logger _logger;
  final Utils _utils;

  /// Get the high probabile nationality from the name
  Future<Country?> getNationality(String name) async {
    _logger.d("...requesting nationality for $name");

    /// Sort out the country name
    GetNationalityResponse response = await _nationsApi.getNationality(name);
    if (response.countries.isEmpty) {
      return null;
    }

    Country highProbableCountry = _utils.getHighProbablity(response.countries);
    highProbableCountry.countryName = _utils.getCountryName(highProbableCountry.countryId);
    return highProbableCountry;
  }
}
