abstract class BaseApiService {

  String apiBaseUrl = 'https://api.nationalize.io/';

  Future<dynamic> getResponse(String url);
}