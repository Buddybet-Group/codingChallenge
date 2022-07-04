import 'package:coding_chal/model/nationality_model.dart';
import 'package:coding_chal/repository/np_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class FetchPossibleNationalitiesUseCase {
  final NPRepository repository;

  FetchPossibleNationalitiesUseCase(this.repository);

  Future<NationalityMOdel> getPossibleNationalities({required String name}) {
    return repository.getNationality(name);
  }
}
