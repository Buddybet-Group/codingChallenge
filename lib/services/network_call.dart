import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'server_response.dart';

abstract class Api {
  static const baseUrl = "https://api.nationalize.io";

  Future<ServerResponse> get(
    String endpoint, {
    Map<String, dynamic>? headers,
  });
}

class NetworkCall extends Api {
  final Dio _dio;
  NetworkCall()
      : _dio = Dio(BaseOptions(
          baseUrl: Api.baseUrl,
          connectTimeout: 30 * 1000,
          receiveTimeout: 30 * 1000,
          sendTimeout: 30 * 1000,
        )) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log('=====> Endpoint: ${options.uri} <=====');
          log('RequestHeaders: ${options.headers}');
          log('RequestBody: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          log('ResponseBody: ${response.data}');
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          log('ApiError: $e');
          return handler.next(e);
        },
      ),
    );
  }

  ServerResponse _onDioError(DioError e) {
    if (e.response?.statusCode == HttpStatus.unauthorized) {
      log('unauthorized user');
    }
    if (e.message.contains('SocketException')) {
      log('----Socket Exception Occurred-----');
      return ServerResponse.error(
          errorMsg:
              'Network Error!\nCheck your internet connection and try again');
    }
    if (e.type == DioErrorType.connectTimeout ||
        e.type == DioErrorType.receiveTimeout ||
        e.type == DioErrorType.sendTimeout) {
      log('----Timeout Exception Occurred-----');
      return ServerResponse.error(
          errorMsg: 'Server not responding. Please try later.');
    }

    if (e.response != null) {
      if (e.response!.data is Map<String, dynamic>) {
        return ServerResponse.failure(error: e.response!.data);
      } else {
        return ServerResponse.error(
            errorCode: e.response!.statusCode.toString(),
            errorMsg: e.response!.statusMessage);
      }
    }
    return ServerResponse.error(errorMsg: e.message);
  }

  @override
  Future<ServerResponse> get(String endpoint,
      {Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.get(endpoint,
          options: Options(
            headers: {
              if (headers != null) ...headers,
            },
          ));
      return ServerResponse.success(data: response.data);

    } on DioError catch (e) {
      return _onDioError(e);
    } catch (e) {
      return ServerResponse.error(errorMsg: e.toString());
    }
  }
}
