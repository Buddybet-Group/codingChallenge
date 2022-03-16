import 'package:coding_chal/data/network/country_api.dart';
import 'package:coding_chal/data/network/http_client.dart';
import 'package:coding_chal/data/repository.dart';
import 'package:coding_chal/stores/country/country_store.dart';
import 'package:coding_chal/stores/error/error_store.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // factories:-----------------------------------------------------------------
  getIt.registerFactory(() => ErrorStore());

  // singletons:
  getIt.registerSingleton(HttpClient(http.Client()));

  // api's:---------------------------------------------------------------------
  getIt.registerSingleton(PostApi(getIt<HttpClient>()));

  // repository:----------------------------------------------------------------
  getIt.registerSingleton(Repository(
    getIt<PostApi>(),
  ));

  // stores:
  getIt.registerSingleton(CountryStore(getIt<Repository>()));
}
