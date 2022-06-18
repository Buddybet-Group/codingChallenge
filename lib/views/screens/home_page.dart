import 'package:coding_chal/controllers/home_page_controller.dart';
import 'package:coding_chal/views/widget/country_with_predition_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/constents/constants.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomeController _homeController = Get.put(HomeController());
  String? searchValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appBarName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    decoration: _decoration(context),
                    onChanged: (String value) {
                      searchValue = value;
                    },
                    onSubmitted: (String value) async {
                      if (searchValue != null) {
                        await _homeController.fetchPredictionData(searchValue!);
                      }
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (searchValue != null) {
                        await _homeController.fetchPredictionData(searchValue!);
                      }
                    },
                    child: const Text(
                      'Search',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(() {
            return _homeController.isLoading.value
                ? const CircularProgressIndicator()
                : CountryWithPreditionListWidget(
                    countryList: _homeController.countryList,
                  );
          })
        ]),
      ),
    );
  }

  InputDecoration _decoration(BuildContext context) => InputDecoration(
        alignLabelWithHint: true,
        hintText: 'Enter Your Name',
        labelStyle: Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(height: 5, fontSize: 13),
        filled: true,
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
            ),
            borderRadius: _borderRadius),
      );

  BorderRadius get _borderRadius => BorderRadius.circular(8);
}
