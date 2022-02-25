import 'package:coding_chal/models/nationalize_model.dart';
import 'package:coding_chal/services/api_service/main_apiservices.dart';
import 'package:coding_chal/services/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class MainViewModel extends BaseViewModel
{
TextEditingController nameController = TextEditingController();

NationalizeResponse? _nationalizeResponse;

NationalizeResponse? get getNationalizeInfo => _nationalizeResponse;

List<Country>? get getReleventCountryInfo{

  if(getNationalizeInfo != null)
    {
      return getNationalizeInfo!.country;
    }
  else
    {
      return [];
    }

}

final _apiService = locator<ApiService>();

getInfo() async
{
  setBusy(true);
  String nameFromInput = nameController.text.trim();
  _nationalizeResponse = await _apiService.getNationalizeInfo(nameFromInput);
  setBusy(false);
}
}