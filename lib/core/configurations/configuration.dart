import '../values/environment.dart';

/// A class containing the base configuration of the app.
abstract class Configuration {
  /// Constructs a new base Configuration object.
  const Configuration();

  /// The name of the configuration environment
  Environment get environment => Environment.dev;

  /// The Nationalize API base url
  String get baseUrl {
    return "https://api.nationalize.io/";
  }

  /// The string name of the environment.
  String get environmentName {
    return environment.name;
  }

  /// Rest client timeout in milliseconds for opening url.
  int get restClientConnectTimeout => 8000;

  /// Rest client timeout in milliseconds for receiving data.
  int get restClientReceiveTimeout => 8000;
}
