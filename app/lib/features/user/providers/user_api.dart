import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_auth/core/error/exceptions.dart';
import 'package:injectable/injectable.dart';

import '../models/user.dart';

const USER_API = '/users';

@lazySingleton
class UserApi {
  final Dio _client;

  UserApi({required Dio client}) : _client = client;

  Future<User?> geCurrentUser({required String token}) async {
    final response = await _client.get('$USER_API/me',
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    if (response.statusCode == 200) {
      return User.fromJson(response.data);
    }
    return null;
  }

  Future<User?> getUserById({required String id}) async {
    final response = await _client.get('$USER_API/$id');

    if (response.statusCode == 200) {
      return User.fromJson(response.data);
    }
    return null;
  }

  Future<String?> login(
      {required String username, required String password}) async {
    try {
      final response = await _client.post('$USER_API/login',
          data: {'username': username, 'password': password});

      if (response.statusCode == 200) {
        return response.data['accessToken'];
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.badResponse) {
        throw UnauthorizedException();
      }
    }

    return null;
  }
}
