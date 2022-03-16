import 'package:coding_chal/data/repository.dart';
import 'package:coding_chal/models/nationality_response.dart';
import 'package:coding_chal/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';

part 'country_store.g.dart';

class CountryStore = _CountryStore with _$CountryStore;

abstract class _CountryStore with Store {
  // repository instance
  late final Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _CountryStore(Repository repository) : _repository = repository;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<NationalityResposnse?> emptyCountryResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<NationalityResposnse?> fetchCountryFuture =
      ObservableFuture<NationalityResposnse?>(emptyCountryResponse);

  @observable
  NationalityResposnse? countryList;

  @observable
  bool success = false;

  @computed
  bool get loading => fetchCountryFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getCountryList({required String searchKey}) async {
    final future = _repository.getCountryList(searchKey: searchKey);
    fetchCountryFuture = ObservableFuture(future);

    future.then((countryList) {
      this.countryList = countryList;
    }).catchError((error) {
      errorStore.errorMessage = error;
    });
  }
}