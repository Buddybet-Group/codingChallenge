import 'package:coding_chal/model/nationality_model.dart';
import 'package:coding_chal/repository/np_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: NPRepository)
class NPRepositoryImpl extends NPRepository {

  @override
  Future<NationalityMOdel>getNationality(String name) async {
    var _dio = Dio();
    String url = "https://api.nationalize.io/";
    Map<String, String> qParams = {
      'name': '$name',
    };
    var res = await _dio.get(url, queryParameters: qParams);
    switch (res.statusCode) {
      case 200:
        print('SUCESSS');
        // print('${nationalityMOdelFromJson(res.data)}');
        return NationalityMOdel.fromJson(res.data);
      case 401:
        print('UNATHORIZED');
        return NationalityMOdel.fromJson(res.data);
        break;
      case 422:
        print('NAME PARAMETER IS MISSING');
        return NationalityMOdel.fromJson(res.data);
        break;
      default:
        print('ISSUE');
        return NationalityMOdel.fromJson(res.data);
        break;
    }
  }

}