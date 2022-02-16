import 'package:coding_chal/providers/api/get_nationality_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'nations_api.g.dart';

/// API that responsible for retriving user's nationality
@RestApi()
abstract class NationsApi {
  /// Factory constructor using Retrofit to create service. Uses a Dio instance [dio] for HTTP client.
  ///
  /// [dio] Is required and should not be null. Base URL from [dio] is used by default.
  /// Optionally accepts [baseUrl] to override the base URL of the Dio instance.
  factory NationsApi(Dio dio, {String baseUrl}) = _NationsApi;

  /// Get the nationality from the user name
  @GET("?name={name}")
  Future<GetNationalityResponse> getNationality(@Path() String name);
}
