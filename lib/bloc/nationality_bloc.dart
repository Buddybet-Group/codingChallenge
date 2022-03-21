import 'dart:async';

import 'package:coding_chal/model/country.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../service/repository/nationality_repository.dart';

enum Status{initial,loading,success,noCountry,error}
class NationalityUserInputEvent extends Equatable{
  final String userInput;


  const NationalityUserInputEvent(this.userInput);

  @override
  // TODO: implement props
  List<Object?> get props =>[userInput];


}

class NationalityUserInputState extends Equatable{
  final List<Country>? results;
  final Status status;


  const NationalityUserInputState(this.results,this.status);

  @override
  // TODO: implement props
  List<Object?> get props =>[status];


}

class NationalityBloc extends Bloc<NationalityUserInputEvent,NationalityUserInputState>{

  final NationalityRepository _repository;
  final TextEditingController nameCtrl = TextEditingController();
  NationalityBloc(this._repository) : super(const NationalityUserInputState(null,Status.initial)){
    nameCtrl.addListener(handleValueChange);
  on<NationalityUserInputEvent>(_loginTypeButtonClickEvent, transformer: (events, mapper) {
    return events.debounceTime(const Duration(milliseconds: 1000)).asyncExpand(mapper);
  },);



}

handleValueChange(){
  add(NationalityUserInputEvent(nameCtrl.text.trim()));
}

  void _loginTypeButtonClickEvent(NationalityUserInputEvent event, Emitter<NationalityUserInputState> emit) async {

if (kDebugMode) {
  print("user typed: "+event.userInput);
}
if(event.userInput.length>2){
  emit(const NationalityUserInputState([],Status.loading));
 dynamic result =  await _repository.getNationalities(event.userInput);
 if(result is  Map<String, dynamic>?){
 final countryList =  (result!['country'] as List<dynamic>).map((e) => Country.fromJson(
       e as Map<String, dynamic>))
       .toList();
 if(countryList != null && countryList.length>1){
   emit( NationalityUserInputState(countryList,Status.success));
 }else{
   emit( const NationalityUserInputState([],Status.noCountry));
 }

 }else{
   emit( const NationalityUserInputState([],Status.error));
 }
}else {
emit(const NationalityUserInputState([],Status.initial));

}


  }

  @override
  Future<void> close() async {
    //cancel streams
    nameCtrl.removeListener(handleValueChange);
    super.close();
  }

}