import 'package:buddybet_assignment/api/apiservice.dart';
import 'package:buddybet_assignment/model/country_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class OverViewController extends GetxController{

  var countrylist = <Country_model>[];
  var isLoading = false.obs;
  Rx<TextEditingController> search = TextEditingController().obs;
  var searchcountrylist = Country_model();
  var isloading2 = false.obs;

  getCountryList()async{
    try{
      isLoading(true);
      countrylist = await ApiController().getCountryList();
    }
    finally{
      isLoading(false);
    }
  }
  searchCountryList(name)async{
    try{
      isloading2(true);
      searchcountrylist = await ApiController().searchCountryList(name);
      search.value.clear();
    }
    finally{
      isloading2(false);
    }
  }

}