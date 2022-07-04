import 'package:coding_chal/presentation/splash.dart';
import 'package:coding_chal/util/app_navigator_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'di/di.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.instance.allowReassignment = true;
  await configureInjection();
  Bloc.observer = SimpleBlocObserver();
  runApp(const  MaterialApp(
          home:  Scaffold(
            body: SplashScreen(),
          ),
        ),
  );

}

