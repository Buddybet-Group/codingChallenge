import 'package:coding_chal/models/nationalize_model.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';
part 'main_apiservices.g.dart';

@RestApi(baseUrl : "https://api.nationalize.io")

abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  static ApiService init() {
    final dio = Dio()
      ..interceptors.add(PrettyDioLogger(requestBody: true));
    return ApiService(dio);
  }

  @GET("https://api.nationalize.io/?name={name}")
  Future<NationalizeResponse> getNationalizeInfo(@Path("name") String name);
}