import 'package:dio/dio.dart';

final dio = Dio();

void configureDio() {
  dio.options.baseUrl = "http://localhost:8080/me";
  dio.options.connectTimeout = const Duration(seconds: 5);
  dio.options.receiveTimeout = const Duration(seconds: 5);
  dio.options.validateStatus = (int) {
    return true;
  };
}
