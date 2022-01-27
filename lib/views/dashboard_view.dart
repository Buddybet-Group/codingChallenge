import 'package:coding_chal/viewmodels/dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DashBoardView extends StatelessWidget {
  const DashBoardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => DashBoardViewModel(),
        builder: (_, DashBoardViewModel viewModel, __) {
          return Scaffold(
            appBar: AppBar(
              title: Text("BuddyBet Coding Challege"),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: viewModel.controller,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          viewModel.FetchData();
                        },
                        child: const Text("Search")),
                    const SizedBox(
                      height: 10,
                    ),
                    viewModel.isBusy
                        ? const CircularProgressIndicator()
                        : viewModel.getCountryList == null
                            ? Container()
                            : viewModel.getCountryList!.isEmpty
                                ? const Center(
                                    child: Text("Not Results"),
                                  )
                                : ListView.builder(
                                  shrinkWrap: true,
                                    itemCount: viewModel.getCountryList!.length,
                                    itemBuilder: (context, index) => Card(
                                      child: ListTile(
                                        title: Text(viewModel
                                            .getCountryList![index].countryId
                                            .toString()),
                                        trailing: Text(
                                          viewModel
                                            .getCountryList![index].probability
                                            .toString()
                                        ),    
                                      ),
                                    ),
                                  )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
