import 'dart:convert';
import 'dart:math' as math;
import 'package:coding_chal/bloc/nationality_predicting_bloc.dart';
import 'package:coding_chal/bloc/nationality_predicting_event.dart';
import 'package:coding_chal/bloc/nationality_predicting_state.dart';
import 'package:coding_chal/model/nationality_model.dart';
import 'package:coding_chal/presentation/common/common_error_ui.dart';
import 'package:coding_chal/presentation/common/common_widgets.dart';
import 'package:countries_world_map/world/simple_world/src/simple_world_colors.dart';
import 'package:countries_world_map/world/simple_world/src/simple_world_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldMap extends StatefulWidget {
  final String name;

  const WorldMap({Key? key, required this.name}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WorldMapState();
}

class _WorldMapState extends State<WorldMap> {
  final NationalityPredictingBloc _nationalityPredictingBloc =
      GetIt.instance.get<NationalityPredictingBloc>();

  _WorldMapState();

  @override
  void dispose() {
    _nationalityPredictingBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Country> _countryList = [];
    BlocProvider(create: (BuildContext context) => _nationalityPredictingBloc);
    _nationalityPredictingBloc.add(FetchNationalityPredictingEvent(name: widget.name));
    return BlocBuilder(
        bloc: _nationalityPredictingBloc,
        builder: (context, state) {
          if (state is InitialNationalityPredictingState) {
            return _initState();
          } else if (state is InProgressNationalityPredictingState) {
            return _initState();
          } else if (state is SuccessNationalityPredictingState) {
            _countryList.addAll(state.nationalityMOdel.country);
            return _showWorldMap(context, widget.name, _countryList);
          } else if (state is ErrorNationalityPredictingState) {
            return _errorState();
          } else {
            return _errorState();
          }
        });
  }

  Widget _showWorldMap(
      BuildContext context, String name, List<Country> popularList) {
    ChartType? _chartType = ChartType.ring;
    bool _showCenterText = true;
    double? _chartLegendSpacing = 32;

    bool _showLegendsInRow = false;
    bool _showLegends = true;

    int key = 0;
    if (popularList.isNotEmpty) {
      return FutureBuilder(
          future: DefaultAssetBundle.of(context)
              .loadString('data/country_codes.json'),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            Map<String, double> dataMap = {};

            List countryName = json.decode(snapshot.data.toString());
            for (var cCode in popularList) {
              Map<String, double> map = {
                countryName.firstWhere((element) =>
                        element["code"] == cCode.countryId)["name"]:
                    cCode.probability
              };
              dataMap.addAll(map);
            }

            final chart = PieChart(
                key: ValueKey(key),
                dataMap: dataMap,
                animationDuration: const Duration(milliseconds: 800),
                chartLegendSpacing: _chartLegendSpacing,
                chartRadius:
                    math.min(MediaQuery.of(context).size.width / 2.2, 600),
                initialAngleInDegree: 0,
                chartType: _chartType,
                centerText: _showCenterText ? "Name\nProbability" : null,
                legendOptions: LegendOptions(
                  showLegendsInRow: _showLegendsInRow,
                  legendPosition: LegendPosition.bottom,
                  showLegends: _showLegends,
                  legendShape: BoxShape.circle,
                  legendTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ));

            return LayoutBuilder(
              builder: (_, constraints) {
                if (constraints.maxWidth >= 600) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 3,
                        fit: FlexFit.tight,
                        child: chart,
                      )
                    ],
                  );
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 32,
                          ),
                          child: chart,
                        )
                      ],
                    ),
                  );
                }
              },
            );

            ///Tried to implement the probability nationality display
            ///on a world map Component
            // SimpleWorldMap(
            //   defaultCountryColor: Colors.grey,
            //
            //   countryColors: SimpleWorldCountryColors(
            //     jP: Colors.green,
            //     nL: Colors.green,
            //     uS: Colors.green,
            //   ),
            // ),

          });
    }
    else {
      return const ErrorUI();
    }
  }

  Widget _initState() {
    return const CommonProgressBar();
  }

  Widget _errorState() {
    return const ErrorUI();
  }
}

enum LegendShape { circle, rectangle }
