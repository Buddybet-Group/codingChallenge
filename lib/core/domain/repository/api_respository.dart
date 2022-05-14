import 'package:coding_chal/data/models/result-model.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class ApiRespository {
  /// Fetches all the search List
  Future<SearchResultModel> fetchResults(String name);
}
