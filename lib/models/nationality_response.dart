import 'country.dart';

class NationalityResposnse {
  String? name;
  List<Country>? country;

  NationalityResposnse({
    this.name,
    this.country,
  });

  NationalityResposnse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['country'] != null) {
      country = <Country>[];
      json['country'].forEach((v) {
        country!.add(Country.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toMap() => {"name": name, "country": country};
}
