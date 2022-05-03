import '../model/nationality_response.dart';
import 'api_status.dart';

class ApiBaseResponse {
  int? statusCode;
  ApiStatus status = ApiStatus.none;
  String error = '';
  NationalityResponse? data;
}
