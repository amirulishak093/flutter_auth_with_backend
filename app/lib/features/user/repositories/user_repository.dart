import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/error/failures.dart';
import '../models/user.dart';
import '../presentation/bloc/user_state.dart';

abstract class UserRepository {
  ValueStream<AuthStatus> get authStatus;
  Future<Either<Failure, void>> logIn(
      {required String username, required String password});
  Future<Either<Failure, User?>> getCurrentUser();
  void dispose();
  void logOut();
}
