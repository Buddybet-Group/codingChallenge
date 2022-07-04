// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../bloc/nationality_predicting_bloc.dart' as _i6;
import '../repository/np_repository.dart' as _i3;
import '../repository/np_repository_impl.dart' as _i4;
import '../usecase/fetch_posible_nationalties_use_case.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.NPRepository>(_i4.NPRepositoryImpl());
  gh.factory<_i5.FetchPossibleNationalitiesUseCase>(
      () => _i5.FetchPossibleNationalitiesUseCase(get<_i3.NPRepository>()));
  gh.factory<_i6.NationalityPredictingBloc>(() => _i6.NationalityPredictingBloc(
      get<_i5.FetchPossibleNationalitiesUseCase>()));
  return get;
}
