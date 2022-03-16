// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CountryStore on _CountryStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_CountryStore.loading'))
      .value;

  final _$fetchCountryFutureAtom =
      Atom(name: '_CountryStore.fetchCountryFuture');

  @override
  ObservableFuture<NationalityResposnse?> get fetchCountryFuture {
    _$fetchCountryFutureAtom.reportRead();
    return super.fetchCountryFuture;
  }

  @override
  set fetchCountryFuture(ObservableFuture<NationalityResposnse?> value) {
    _$fetchCountryFutureAtom.reportWrite(value, super.fetchCountryFuture, () {
      super.fetchCountryFuture = value;
    });
  }

  final _$countryListAtom = Atom(name: '_CountryStore.countryList');

  @override
  NationalityResposnse? get countryList {
    _$countryListAtom.reportRead();
    return super.countryList;
  }

  @override
  set countryList(NationalityResposnse? value) {
    _$countryListAtom.reportWrite(value, super.countryList, () {
      super.countryList = value;
    });
  }

  final _$successAtom = Atom(name: '_CountryStore.success');

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  final _$getCountryListAsyncAction =
      AsyncAction('_CountryStore.getCountryList');

  @override
  Future<dynamic> getCountryList({required String searchKey}) {
    return _$getCountryListAsyncAction
        .run(() => super.getCountryList(searchKey: searchKey));
  }

  @override
  String toString() {
    return '''
fetchCountryFuture: ${fetchCountryFuture},
countryList: ${countryList},
success: ${success},
loading: ${loading}
    ''';
  }
}
