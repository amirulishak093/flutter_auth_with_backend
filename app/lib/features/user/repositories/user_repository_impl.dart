import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_auth/core/error/exceptions.dart';
import 'package:flutter_auth/features/user/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/error/failures.dart';
import '../models/user.dart';
import '../presentation/bloc/user_state.dart';
import '../providers/user_api.dart';
import '../providers/user_local_storage.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserApi _api;
  final UserLocalStorage _storage;
  final BehaviorSubject<AuthStatus> _controller =
      BehaviorSubject.seeded(AuthStatus.notLoggedIn);

  UserRepositoryImpl({required UserApi api, required UserLocalStorage storage})
      : _api = api,
        _storage = storage;

  @override
  ValueStream<AuthStatus> get authStatus => _controller.stream;

  @override
  Future<Either<Failure, void>> logIn(
      {required String username, required String password}) async {
    try {
      final token = await _api.login(username: username, password: password);

      await _storage.saveToken(token: token!);

      _controller.add(AuthStatus.loggedIn);
      return const Right(null);
    } on UnauthorizedException {
      return left(
          const ClientFailure(message: "Incorrect username or password"));
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    final token = await _storage.getToken();

    if (token == null) {
      return const Left(ClientFailure(message: 'Not authenticated'));
    }

    final user = await _api.geCurrentUser(token: token);

    if (user != null) {
      await _storage.saveUser(user: user);
      return Right(user);
    }

    return const Right(null);
  }

  @override
  void logOut() {
    _controller.add(AuthStatus.notLoggedIn);
  }

  @override
  @disposeMethod
  void dispose() => _controller.close();
}
