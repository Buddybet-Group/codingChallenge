import 'package:coding_chal/provider/nationality_model.dart';
import 'package:coding_chal/theme/string_resources.dart';
import 'package:coding_chal/widgets/progress_widget.dart';
import 'package:flutter/material.dart';
import '../model/country.dart';
import 'package:provider/provider.dart';

class ResultWidget extends StatelessWidget {
  final List<Country> _country;

  const ResultWidget(this._country, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_country.isNotEmpty)
          Text(
            StringResources.nationalityPrediction,
            style: TextStyle(fontSize: 22.0, color: Colors.grey.withOpacity(0.8)),
          ),
        ListView.builder(
            itemCount: _country.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (BuildContext context, int index) {
              var _countryName =
                  context.read<NationalityModel>().getNationality(_country[index].countryId);
              return Padding(
                  padding: const EdgeInsets.only(bottom: 24.0, left: 32.0),
                  child: Row(children: [
                    ProgressWidget(_country[index].probability),
                    const SizedBox(width: 18.0),
                    Text(_countryName,
                        style: const TextStyle(
                            color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600))
                  ]));
            })
      ],
    );
  }
}
