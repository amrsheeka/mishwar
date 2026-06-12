import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  /// Call this once in main()
  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://192.168.1.4:8000/api/',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  /// GET request
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    Options? options,
  }) async {
    return await dio.get(
      url,
      queryParameters: query,
      options: options,
    );
  }

  /// POST request
  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    Options? options,
  }) async {
    return await dio.post(
      url,
      data: data,
      queryParameters: query,
      options: options,
    );
  }

  /// PUT request
  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    return await dio.put(url, data: data);
  }

  /// DELETE request
  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    return await dio.delete(url, data: data);
  }
}