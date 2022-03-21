import 'package:coding_chal/service/api_service.dart';

class NationalityRepository{


  Future<dynamic> getNationalities(String endPointParams) async {



    return await ApiService.get(endPointParams: "name="+endPointParams);

  }
}