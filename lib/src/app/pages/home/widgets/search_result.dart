import 'package:coding_chal/src/app/pages/home/home_model.dart';
import 'package:flutter/material.dart';
import '../../../../utils/app_tools.dart';

class SearchResultWidget extends StatelessWidget {
  final HomeResponse data;
  const SearchResultWidget(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: data.country!.length,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (context, index) {
        var listData = data.country![index];

        return Card(
          margin: EdgeInsets.zero,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 30 / 100,
                  child: const Text(
                    "Country Name :",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Expanded(
                  child: Text(
                    countryName(listData.countryId).localizedName ?? "",
                    overflow: TextOverflow.clip,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 10),
    );
  }
}
