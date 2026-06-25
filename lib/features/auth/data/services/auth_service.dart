import 'package:dio/dio.dart';
import 'package:mishwar/core/utils/cach_helper.dart';
import 'package:mishwar/core/utils/dio_helper.dart';
import 'package:mishwar/features/auth/data/models/auth_response_model.dart';

class AuthService {
  static Future<void> logout() async {
  try {
    await DioHelper.postData(url: 'logout');

    await CacheHelper.removeData(key: 'token');
  } on DioException catch (e) {
    throw e.response?.data['message'] ?? 'Failed to logout';
  }
}

  static Future<AuthResponseModel> confirmEmail({
    required String email,
    required String code,
  }) async {
    final response = await DioHelper.postData(
      url: 'verify-email',
      data: {'email': email, 'otp': code},
    );

    return AuthResponseModel.fromJson(response.data);
  }

  static Future<String?> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await DioHelper.postData(
        url: 'register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );

      if (response.statusCode == 201) {
        return 'Account created. Confirm your email';
      }

      return null;
    } on DioException catch (e) {
      print('Error: ${e.response?.data['message']}');
      return e.response?.data['message'] ?? 'This email is already used';
    } catch (e) {
      print('Error: $e');
      return 'Something went wrong';
    }
  }

  static Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await DioHelper.postData(
        url: 'login',
        data: {'email': email, 'password': password},
      );
      return AuthResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      final data = e.response?.data;

      throw Exception(data['message'] ?? 'Login failed');
    } catch (e) {
      throw Exception('Something went wrong');
    }
  }
}
