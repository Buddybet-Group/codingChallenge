import 'package:coding_chal/models/national_model.dart';
import 'package:coding_chal/services/api/api_services.dart';
import 'package:coding_chal/services/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class DashBoardViewModel extends BaseViewModel{

 NationalResponse? _nationalResponse;

NationalResponse? get getNationalList => _nationalResponse;

List<Country>? get getCountryList{
  if(getNationalList == null){
    return [];
  }else{
    return getNationalList!.country;
  }
  
}


final _apiService = locator<ApiService>();

TextEditingController controller = new TextEditingController();

 FetchData() async{
   setBusy(true);
   String nameFromEdit = controller.text.trim();
   _nationalResponse = await _apiService.getNationDetails(nameFromEdit);
   setBusy(false);
 }
}