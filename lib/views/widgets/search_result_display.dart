import 'package:coding_chal/core/domain/entities/country.dart';
import 'package:flutter/material.dart';

class SearchResultDisplay extends StatelessWidget {
  const SearchResultDisplay({Key? key, required this.countries})
      : super(key: key);

  /// List of the Countries
  final List<Country> countries;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: countries.length,
      itemBuilder: countries.isEmpty
          ? (context, index) => const Text("No result found")
          : (context, index) => ListTile(
                title: Text(
                  countries[index].countryId,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                trailing: Text((num.parse(countries[index].probability) * 100)
                        .roundToDouble()
                        .toString() +
                    " %"),
              ),
    );
  }
}
