import 'country.dart';

class NationalityResponse {
  String? name;
  List<Country>? country;

  NationalityResponse({this.name, this.country});

  NationalityResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['country'] != null) {
      country = <Country>[];
      json['country'].forEach((v) {
        country!.add(Country.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (country != null) {
      data['country'] = country!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


