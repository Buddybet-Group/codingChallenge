part of 'predict_bloc.dart';

abstract class PredictBlocState extends Equatable {
  const PredictBlocState();

  @override
  List<Object?> get props => [];
}

class StateInitial extends PredictBlocState {}

class StateLoading extends PredictBlocState {}

class StateLoaded extends PredictBlocState {
  final Prediction model;
  const StateLoaded(this.model);
}

class StateError extends PredictBlocState {
  final String? message;
  const StateError(this.message);
}
