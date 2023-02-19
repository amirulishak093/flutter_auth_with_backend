import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../models/user.dart';

const CACHED_USER = 'CACHED_USER';
const ACCESS_TOKEN = 'ACCESS_TOKEN';

@lazySingleton
class UserLocalStorage {
  final FlutterSecureStorage _storage;

  UserLocalStorage({required FlutterSecureStorage storage})
      : _storage = storage;

  Future<void> deleteUser() async {
    await _storage.delete(key: CACHED_USER);
  }

  Future<User?> getUser() async {
    final jsonUser = await _storage.read(key: CACHED_USER);

    if (jsonUser != null) {
      return User.fromJson(jsonDecode(jsonUser));
    }
    return null;
  }

  Future<void> saveUser({required User user}) async {
    await _storage.write(key: CACHED_USER, value: jsonEncode(user.toJson()));
  }

  Future<void> saveToken({required String token}) async {
    await _storage.write(key: ACCESS_TOKEN, value: token);
  }

  Future<String?> getToken() async {
    final token = await _storage.read(key: ACCESS_TOKEN);
    if (token != null) {
      return token;
    }
    return null;
  }
}
