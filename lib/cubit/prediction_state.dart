part of 'prediction_cubit.dart';

enum PredictionStatus {
  initial,
  loading,
  loaded,
  error,
}

class PredictionState {
  Prediction prediction;
  PredictionStatus status;
  PredictionState({
    this.prediction = const Prediction(name: '', countryList: []),
    required this.status,
  });
}

class PredictionInitial extends PredictionState {
  PredictionStatus status;
  PredictionInitial({
    required this.status,
  }) : super(status: status);
}

class PredictionLoading extends PredictionState {
  PredictionStatus status;
  PredictionLoading({
    required this.status,
  }) : super(status: status);
}

class PredictionError extends PredictionState {
  PredictionStatus status;
  PredictionError({
    required this.status,
  }) : super(status: status);
}

class PredictionLoaded extends PredictionState {
  PredictionStatus status;
  Prediction prediction;
  PredictionLoaded({required this.status, required this.prediction})
      : super(status: status, prediction: prediction);
}
