import 'package:coding_chal/service/repository/nationality_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/nationality_bloc.dart';
import 'ui/home.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("BuddyBet Coding Challege"),


      ),
      body: RepositoryProvider(
        create: (context) => NationalityRepository(),
        child: BlocProvider<NationalityBloc>(
          create: (context) =>NationalityBloc(RepositoryProvider.of<NationalityRepository>(context)),
          child: Nationality(),
        ),
    )
  )));
}




