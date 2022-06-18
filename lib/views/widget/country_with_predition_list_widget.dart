import 'package:flutter/material.dart';
import '../../models/country_model.dart';
import '../../utils/constents/constants.dart';

class CountryWithPreditionListWidget extends StatelessWidget {
  List<Country> countryList;
  CountryWithPreditionListWidget({Key? key, required this.countryList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: countryList.length,
        shrinkWrap: true,
        itemBuilder: countryList.isEmpty
            ? (context, i) {
                return const Text("No result found");
              }
            : (context, i) => Card(
                  child: ListTile(
                    title: Text(
                      countryList[i].countryId ?? '',
                    ),
                    trailing: countryList[i].probability != null
                        ? Text(
                            '${(countryList[i].probability! * 100).roundToDouble()} %',
                            style: const TextStyle(color: primaryColor),
                          )
                        : const Text(''),
                  ),
                ),
      ),
    );
  }
}
