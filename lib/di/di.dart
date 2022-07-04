
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';
final GetIt _getIt = GetIt.instance;

@InjectableInit(
    initializerName: r'$initGetIt'
)
Future configureInjection() async {
  $initGetIt(_getIt);
}