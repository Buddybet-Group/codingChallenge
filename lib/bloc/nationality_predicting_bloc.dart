import 'package:coding_chal/model/nationality_model.dart';
import 'package:coding_chal/usecase/fetch_posible_nationalties_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'nationality_predicting_event.dart';
import 'nationality_predicting_state.dart';

@injectable
class NationalityPredictingBloc extends Bloc<NationalityPredictingEvent, NationalityPredictingState> {
  final FetchPossibleNationalitiesUseCase fetchPossibleNationalitiesUseCase;

  NationalityPredictingBloc(this. fetchPossibleNationalitiesUseCase)
      : super(InitialNationalityPredictingState());

  @override
  Stream<NationalityPredictingState> mapEventToState(NationalityPredictingEvent event) async* {
   if(event is FetchNationalityPredictingEvent){
     yield InProgressNationalityPredictingState();
     try {
       if(event.name.isNotEmpty){
       NationalityMOdel response =
       await fetchPossibleNationalitiesUseCase.getPossibleNationalities(name: event.name);
       yield SuccessNationalityPredictingState(response);}
       else{
         yield ErrorNationalityPredictingState();
       }
     } catch (exception) {
       debugPrint('Error ${exception.toString()}');
       yield ErrorNationalityPredictingState();
     }
   }

  }


  Stream<NationalityPredictingState> _fetchPossibleNationalities(String name, Emitter<NationalityPredictingState> emit) async* {

    yield InProgressNationalityPredictingState();
    try {
      NationalityMOdel response =
      await fetchPossibleNationalitiesUseCase.getPossibleNationalities(name: name);
      yield SuccessNationalityPredictingState(response);
    } catch (exception) {
      debugPrint('Error ${exception.toString()}');
      yield ErrorNationalityPredictingState();
    }
  }

}
