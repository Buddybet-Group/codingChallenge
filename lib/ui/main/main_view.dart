import 'package:coding_chal/ui/shared/cardwidget.dart';
import 'package:coding_chal/ui/shared/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'main_viewmodel.dart';

class MainView extends StatefulWidget
{
  const MainView ({Key? key}) : super(key: key);
  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView>
{
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => MainViewModel(),
        builder: (__, MainViewModel viewModel, _)=> GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            appBar: AppBar(
              title: Text("BuddyBet Coding Challege",
              style: fontFamilyPoppinsRegular.size18),
              backgroundColor: appColor009FDF,
            ),
            body: SingleChildScrollView(
              padding: padding20,
              child: Form(
                key: _formKey,
                //width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpacing20,
                     Text("Enter the name to predict the nationality",
                    style: fontFamilyPoppinsRegular.size16.black),
                    verticalSpacing20,
                    TextFormField(
                      controller: viewModel.nameController,
                      validator: (val) => val == null || val.isEmpty ? "Name is required" : null,
                    ),
                    verticalSpacing60,
                    Container(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: appColor009FDF
                        ),
                        onPressed: (){
                          if(_formKey.currentState?.validate() ?? false)
                          {
                            viewModel.getInfo();
                          }
                        },
                        child: Text("Search",
                        style: fontFamilyPoppinsRegular.size16.white,),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        verticalSpacing20,
                        viewModel.isBusy
                            ? const Center(child: CircularProgressIndicator())
                            :ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: viewModel.getReleventCountryInfo!.length,
                            itemBuilder: (context, index) => CardWidget
                              (
                              countryvalue: viewModel.getReleventCountryInfo![index].countryId.toString(),
                              probabiltyvalue: viewModel.getReleventCountryInfo![index].probability.toString(),
                            )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}