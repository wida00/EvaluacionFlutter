import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/typedef.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String username, required String password});

  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    try {
      final url = Uri.parse(
        '${AppConstants.baseUrl}${AppConstants.apiPath}${AppConstants.authPath}',
      );

      final response = await _client.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'username': username, 'password': password},
      );

      if (response.statusCode == 200) {
        final DataMap responseData = json.decode(response.body);

        final userModel = UserModel(
          id: username,
          username: username,
          email: '$username@example.com',
          token: responseData['access_token'],
        );

        return userModel;
      } else {
        throw ServerException('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException('Network error during login: $e');
    }
  }

  @override
  Future<void> logout() async {
    // For this API, logout is handled locally by clearing the token
    // No remote logout endpoint needed
    return;
  }
}
