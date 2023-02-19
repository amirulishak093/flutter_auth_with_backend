import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  FlutterSecureStorage get storage => const FlutterSecureStorage();

  @lazySingleton
  Dio get client => Dio(BaseOptions(
      baseUrl: 'http://localhost:8000/api/v1',
      contentType: 'application/json; charset=UTF-8'));
}
