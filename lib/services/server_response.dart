import 'package:coding_chal/utils/constents/constants.dart';

class ServerResponse {
  final bool success;
  final dynamic data;
  final Map<String, dynamic> error;

  ServerResponse.success({required this.data})
      : success = true,
        error = const {};

  ServerResponse.failure({required this.error})
      : success = false,
        data = const {};

  ServerResponse.error({String? errorCode, String? errorMsg})
      : success = false,
        error = {
          'error': {
            'code': errorCode ?? 'Unknown',
            'message': errorMsg ?? customError
          }
        },
        data = const {};

  String get errorMsg {
    Object msg = error['error']['message'] ?? customError;
    if (msg is Map<String, dynamic>) {
      return msg.values.map((e) => e.toString()).join(', ');
    }
    return msg.toString();
  }
}
