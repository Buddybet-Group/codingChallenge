
import 'package:coding_chal/data/models/predict_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../resources/api_repository.dart';

part 'predict_bloc_event.dart';
part 'predict_bloc_state.dart';


class PredictBloc extends Bloc<PredictBlocEvent, PredictBlocState> {
  PredictBloc() : super(StateInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetItemList>((event, emit) async {
      try {
        emit(StateLoading());
        final mList = await _apiRepository.fetchItemList(event.params);
        emit(StateLoaded(mList));
        if (mList.error != null) {
          emit(StateError(mList.error));
        }
      } on NetworkError {
        emit(const StateError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
