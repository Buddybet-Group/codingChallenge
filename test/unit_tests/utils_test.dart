import 'package:coding_chal/core/utils/utils.dart';
import 'package:coding_chal/providers/api/country.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  List<Country> countries = [];
  test('test sorting', () async {
    countries.add(Country(countryId: "AU", probability: .6));
    countries.add(Country(countryId: "EN", probability: .5));
    countries.add(Country(countryId: "US", probability: .8));
    countries.add(Country(countryId: "MA", probability: .2));

    Country country = Utils().getHighProbablity(countries);

    expect(country.countryId, "US");
  });
}
