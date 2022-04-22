import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:coding_chal/model/Prediction.dart';
import 'package:coding_chal/service/PredictionService.dart';

part 'prediction_state.dart';

class PredictionCubit extends Cubit<PredictionState> {
  PredictionService service;
  PredictionCubit(
    this.service,
  ) : super(PredictionInitial(status: PredictionStatus.initial));

  getPrediction(String name) async {
    emit(PredictionLoading(status: PredictionStatus.loading));

    Prediction prediction = await service.getPrediction(name);
    if (prediction.name == 'Error') {
      emit(PredictionError(status: PredictionStatus.error));
    } else {
      emit(PredictionLoaded(
          status: PredictionStatus.loading, prediction: prediction));
    }
  }

  clear() {
    emit(PredictionInitial(status: PredictionStatus.initial));
  }
}
