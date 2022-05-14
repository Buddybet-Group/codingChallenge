import 'package:flutter/material.dart';

import '../../core/domain/entities/country.dart';

@immutable
class SearchResultModel {
  /// Constructs a search list from the given [country & name].
  const SearchResultModel({
    required this.name,
    required this.countries,
  });

  /// The name for which result are fetched.
  final String name;

  /// The list of content within the feed.
  final List<Country> countries;

  /// Constructs a feed from the given [json].
  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      name: json['name'],
      countries: json['country'] != null
          ? List.from(json['country']).map((e) => Country.fromJson(e)).toList()
          : const <Country>[],
    );
  }
}


