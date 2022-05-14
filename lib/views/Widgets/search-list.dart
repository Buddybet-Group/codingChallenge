import 'package:flutter/material.dart';
import '../../core/domain/entities/country.dart';

class SearchList extends StatelessWidget {
  const SearchList({Key? key, required this.countries}) : super(key: key);

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
                trailing: Text(
                  (num.parse(countries[index].probability) * 100)
                          .roundToDouble()
                          .toString() +
                      " %",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold,color: Colors.blueAccent),
                ),
              ),
    );
  }
}
