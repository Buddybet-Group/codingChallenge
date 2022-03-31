
import 'package:coding_chal/blocs/predict_bloc.dart';
import 'package:coding_chal/data/models/predict_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Home extends StatefulWidget {
  final String title;
  const Home({Key? key, required this.title}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController _textEditingController;
  final PredictBloc _predictionBloc = PredictBloc();

  @override
  void initState() {
    super.initState();

    _textEditingController = TextEditingController();

    //_addBloc(categories.first);

  }

  void _addBloc(String name) {
    Map<String, dynamic> params = <String, dynamic>{};
    params["name"] = name;
    _predictionBloc.add(GetItemList(params: params));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        title: Text(widget.title)
        //backgroundColor: Colors.black,
      ),
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: Theme.of(context).textTheme.bodyText1,
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                    maxLines: 1,
                  ),
                ),
                SizedBox(width: 16,),
                ElevatedButton(
                  onPressed: () {
                    _addBloc(_textEditingController.text);
                  }, 
                  child: const Text("Show"),
                )
              ],
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: BlocProvider(
                create: (_) => _predictionBloc,
                child: BlocListener<PredictBloc, PredictBlocState>(
                  listener: (context, state) {
                    if (state is StateError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message!),
                        ),
                      );
                    }
                  },
                  child: Expanded(
                    child: BlocBuilder<PredictBloc, PredictBlocState>(
                      builder: (context, state) {
                        if (state is StateInitial) {
                          return Container();
                        } else if (state is StateLoading) {
                          return _buildLoading();
                        } else if (state is StateLoaded) {
                          return _buildList(context, state.model);
                        } else if (state is StateError) {
                          return _buildErrorWidget();
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildErrorWidget() => const Center(
  child: Text(
    'Something went Wrong..!!',
    style: TextStyle(
      color: Colors.red,
      fontSize: 36,
      fontWeight: FontWeight.bold,
    ),
  ),
);

Widget _buildLoading() {
  return const Center(
      child: CircularProgressIndicator(
        color: Colors.black,
      )
  );
}

Widget _buildList(BuildContext context, Prediction model) {

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    height: double.infinity,
    color: Theme.of(context).backgroundColor,
    child: ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) => const Divider(
        thickness: 1,
      ),
      itemCount: model.countries.length,
      itemBuilder: (context, index) {

        Country country = model.countries[index];
        String countryCode = country.countryId;
        String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
                (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
        double probability = country.probability * 100;

        return ListTile(
          trailing: Text(flag, style: Theme.of(context).textTheme.bodyText1),
          leading: Text(countryCode, style: Theme.of(context).textTheme.bodyText1),
          title: Row(
            children: [
              Expanded(
                child: LinearPercentIndicator(
                  animation: true,
                  lineHeight: 30.0,
                  animationDuration: 1000,
                  percent: probability /100.0,
                  center: Text("Prabability (" + probability.toStringAsFixed(2) + "%)", style: Theme.of(context).textTheme.bodyText2,),
                  barRadius: Radius.circular(5),
                  progressColor: Colors.greenAccent,
                  backgroundColor: Colors.blueGrey,
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
