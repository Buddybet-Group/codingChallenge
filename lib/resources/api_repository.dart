
import 'package:coding_chal/data/models/predict_model.dart';

import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<Prediction> fetchItemList(Map<String, dynamic> params) {
    return _provider.fetchItemList( params);
  }
}

class NetworkError extends Error {}
