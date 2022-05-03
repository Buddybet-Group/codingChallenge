import 'package:connectivity_plus/connectivity_plus.dart';

class Network {
  Network._();
  static Future<bool> checkInternetAvailability() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }
}
