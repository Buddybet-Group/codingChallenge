import 'package:coding_chal/data/models/result_model.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class ApiRespository {
  /// Fetches all the search result from the repository.
  Future<SearchResultModel> fetchResults();
}
