import 'package:equatable/equatable.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:formz/formz.dart';

import '../models/password.dart';
import '../models/username.dart';

class LoginState extends Equatable {
  final FormzStatus status;
  final Username username;
  final Password password;
  final Failure? failure;

  const LoginState(
      {this.status = FormzStatus.pure,
      this.username = const Username.pure(),
      this.password = const Password.pure(),
      this.failure});

  LoginState copyWith({
    FormzStatus? status,
    Username? username,
    Password? password,
    Failure? failure,
  }) {
    return LoginState(
        status: status ?? this.status,
        username: username ?? this.username,
        password: password ?? this.password,
        failure: failure ?? this.failure);
  }

  @override
  List<Object?> get props => [status, username, password, failure];
}
