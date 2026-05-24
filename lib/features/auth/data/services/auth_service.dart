import 'package:dio/dio.dart';
import 'package:mishwar/core/utils/services.dart';

class AuthService {
  AuthService({ApiService? apiService})
    : _apiService = apiService ?? ApiService.instance;

  final ApiService _apiService;

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        'login',
        data: {'email': email, 'password': password},
      );

      return _decodeResponse(response);
    } on DioException catch (error) {
      throw AuthException.fromDio(error);
    }
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        'register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );

      return _decodeResponse(response);
    } on DioException catch (error) {
      throw AuthException.fromDio(error);
    }
  }

  Future<Map<String, dynamic>> confirmEmail({
    required String email,
    required String code,
  }) async {
    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        'verify-email-otp',
        data: {'email': email, 'otp': code},
      );

      return _decodeResponse(response);
    } on DioException catch (error) {
      throw AuthException.fromDio(error);
    }
  }

  Future<void> logout() async {
    try {
      await _apiService.post('logout');
    } on DioException catch (error) {
      throw AuthException.fromDio(error);
    }
  }

  Map<String, dynamic> _decodeResponse(Response<dynamic> response) {
    if (response.data is Map<String, dynamic>) {
      return response.data as Map<String, dynamic>;
    }

    return {'statusCode': response.statusCode, 'data': response.data};
  }
}

class AuthException implements Exception {
  AuthException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() =>
      'AuthException(statusCode: $statusCode, message: $message)';

  factory AuthException.fromDio(DioException error) {
    final response = error.response;
    final statusCode = response?.statusCode;
    final message = _extractMessage(error, response);

    return AuthException(message, statusCode: statusCode);
  }

  static String _extractMessage(
    DioException error,
    Response<dynamic>? response,
  ) {
    if (response?.data is Map<String, dynamic>) {
      final data = response?.data as Map<String, dynamic>;

      if (data.containsKey('message')) {
        return data['message'].toString();
      }
    }

    return error.message ?? 'An unknown authentication error occurred.';
  }
}
