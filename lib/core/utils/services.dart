import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  static String _defaultBaseUrl() {
    if (kIsWeb) return 'http://192.168.1.3:8000/api/';

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 'http://192.168.1.3:8000/api/';
      default:
        return 'http://192.168.1.3:8000/api/';
    }
  }

  ApiService._internal([String? baseUrl])
    : dio = Dio(
        BaseOptions(
          baseUrl: baseUrl ?? _defaultBaseUrl(),
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      ) {
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: false,
      ),
    );
    dio.interceptors.add(InterceptorsWrapper(onError: _onError));
  }

  static final ApiService instance = ApiService._internal();

  final Dio dio;

  static void initialize({
    required String baseUrl,
    Map<String, dynamic>? headers,
    Duration? connectTimeout,
    Duration? receiveTimeout,
  }) {
    instance._configure(
      baseUrl: baseUrl,
      headers: headers,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
    );
  }

  void _configure({
    required String baseUrl,
    Map<String, dynamic>? headers,
    Duration? connectTimeout,
    Duration? receiveTimeout,
  }) {
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = connectTimeout ?? const Duration(seconds: 15);
    dio.options.receiveTimeout = receiveTimeout ?? const Duration(seconds: 15);
    if (headers != null) {
      dio.options.headers.addAll(headers);
    }
  }

  void updateHeaders(Map<String, dynamic> headers) {
    dio.options.headers.addAll(headers);
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  dynamic _onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      return handler.next(
        DioException(
          requestOptions: err.requestOptions,
          error: 'Connection timed out',
          type: err.type,
        ),
      );
    }

    if (err.response != null) {
      final statusCode = err.response?.statusCode;
      final message = err.response?.statusMessage ?? err.message;
      return handler.next(
        DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          error: 'HTTP $statusCode: $message',
          type: err.type,
        ),
      );
    }

    return handler.next(err);
  }
}
