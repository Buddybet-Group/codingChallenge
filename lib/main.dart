import 'package:coding_chal/cubit/prediction_cubit.dart';
import 'package:coding_chal/model/Country.dart';
import 'package:coding_chal/model/Prediction.dart';
import 'package:coding_chal/service/PredictionService.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

void main() {
  PredictionService service = PredictionService();
  runApp(BlocProvider(
    create: (context) => PredictionCubit(service),
    child: MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("BuddyBet Coding Challege"),
            ),
            body: MyApp())),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  String name = '';
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Center(
          child: Container(
            decoration: boxDecoration(),
            height: MediaQuery.of(context).size.height * 0.50,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Enter Name :',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    nameTextField()
                  ],
                ),
                submitIcon(),
                predictionCard()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget nameTextField() {
    return Expanded(
        child: InputDecorator(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              isDense: true,
              contentPadding: EdgeInsets.only(bottom: 0),
            ),
            child: TextFormField(
              controller: textEditingController,
              decoration: InputDecoration(
                  hintText: 'Enter Name',
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    onPressed: () {
                      textEditingController.clear();
                      context.read<PredictionCubit>().clear();
                    },
                    icon: Icon(Icons.clear),
                  )),
              keyboardType: TextInputType.name,
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
            )));
  }

  Widget predictionCard() {
    return BlocBuilder<PredictionCubit, PredictionState>(
      builder: (context, state) {
        if (state is PredictionLoaded) {
          return Container(
            decoration: boxDecoration(),
            height: MediaQuery.of(context).size.height * 0.30,
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              Text(state.prediction.name),
              if (state.prediction.countryList.isNotEmpty)
                countryList(state.prediction.countryList)
              else
                const Text('Could not predict your country')
            ]),
          );
        } else if (state is PredictionError) {
          return const Text('Some Internal Error Try after some time');
        } else if (state is PredictionLoading) {
          return buildProgressIndicator();
        } else {
          return const Text('');
        }
      },
    );
  }

  Widget countryList(List<Country> countryList) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.20,
      child: ListView.builder(
          itemCount: countryList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Text(countryList[index].countryId),
              title: Text(
                  ((countryList[index].probability * 100).round()).toString() +
                      '%'),
            );
          }),
    );
  }

  Widget submitIcon() {
    return ElevatedButton(
        onPressed: () {
          if (name.isNotEmpty) {
            context.read<PredictionCubit>().getPrediction(name);
          } else {
            Snackbar('Kindly fill your name ');
          }
        },
        child: const Text('Submit'));
  }

  Widget buildProgressIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Snackbar(String error) {
    return ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(error),
        ),
      );
  }

  boxDecoration() {
    return const BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30)),
    );
  }
}
