import 'package:coding_chal/model/Prediction.dart';
import 'package:http/http.dart' as http;

class PredictionService {
  getPredictionUrl(String name) {
    var queryParam = {'name': name};
    var uri = Uri.http("api.nationalize.io", "", queryParam);
    print('Prediction  url $uri');
    return uri;
  }

  Future<Prediction> getPrediction(String name) async {
    Prediction prediction;
    try {
      final response = await http.get(getPredictionUrl(name));
      prediction = Prediction.fromJson(response.body);
      print('-----------------');

      print(prediction);
    } catch (e) {
      print(e);
      prediction = const Prediction(name: 'Error', countryList: []);
    }

    return prediction;
  }
}
