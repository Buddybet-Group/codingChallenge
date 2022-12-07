part of 'predict_bloc.dart';

abstract class PredictBlocEvent extends Equatable {}

class GetItemList extends PredictBlocEvent {
  final Map<String, dynamic> params;
  GetItemList({required this.params});

  @override
  List<Object> get props => [];
}
