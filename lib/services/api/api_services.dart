import 'package:coding_chal/models/national_model.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';

part 'api_services.g.dart';

@RestApi(baseUrl : "https://api.nationalize.io")

abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  static ApiService init() {
    final dio = Dio()
      ..interceptors.addAll(
       [
         PrettyDioLogger(requestBody: true),
       ]
      );
    // dio.interceptors.add(interceptorsWrapper(dio));
    return ApiService(dio);
  }

  
  @GET("/?name={name}")
  Future<NationalResponse> getNationDetails(@Path("name") String name);
}