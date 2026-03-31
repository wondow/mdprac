import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  // NOTE: If using an Android Emulator, use 10.0.2.2.
  // If using a physical phone, use your computer's IPv4 address (e.g., 192.168.1.X)
  // If building for Windows Desktop, use 127.0.0.1
  static const String baseUrl = 'http://192.168.100.4/blush/api/';

  ApiService() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
  }

  Future<Response> post(String endpoint, Map<String, dynamic> data) async {
    try {
      return await _dio.post(endpoint, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> get(String endpoint) async {
    try {
      return await _dio.get(endpoint);
    } catch (e) {
      rethrow;
    }
  }
}
