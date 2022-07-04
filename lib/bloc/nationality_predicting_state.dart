

import 'package:coding_chal/model/nationality_model.dart';

abstract class NationalityPredictingState {}

class InitialNationalityPredictingState extends NationalityPredictingState {}

class InProgressNationalityPredictingState extends NationalityPredictingState {}

class SuccessNationalityPredictingState extends NationalityPredictingState {
  final NationalityMOdel nationalityMOdel;
  SuccessNationalityPredictingState(this.nationalityMOdel);
}

class ErrorNationalityPredictingState extends NationalityPredictingState {}
