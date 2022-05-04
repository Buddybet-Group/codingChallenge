import 'dart:io';

class Connection {
  ///method to check if the application is online or not?
  ///returns boolean value
  Future<bool> isOnline() async {
    bool isConnected = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (_) {
      isConnected = false;
    }
    return isConnected;
  }
}
