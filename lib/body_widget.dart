import 'package:coding_chal/country_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BodyWidget extends StatefulWidget {
  const BodyWidget({Key? key}) : super(key: key);

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  final TextEditingController _controller = TextEditingController();
  final List<CountryModel> countries = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                ),
              ),
              const SizedBox(width: 24),
              ElevatedButton(
                onPressed: getNationality,
                child: const Text('Search'),
              )
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              itemBuilder: (_, index) => Text(
                '${countries[index].countryId}, ${countries[index].probability}',
              ),
              separatorBuilder: (_, index) => const SizedBox(height: 12),
              itemCount: countries.length,
            ),
          ),
        ],
      ),
    );
  }

  void getNationality() async {
    String name = _controller.text.trim();
    if (name.isNotEmpty) {
      try {
        var response =
            await Dio().get('https://api.nationalize.io', queryParameters: {
          'name': name,
        });
        Map<String, dynamic> data = response.data;
        countries.clear();
        for (var country in data['country']) {
          countries.add(CountryModel.fromJson(country));
        }
        setState(() {});
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }
}
