import 'package:equatable/equatable.dart';

import '../../models/user.dart';

enum AuthStatus { notLoggedIn, loggedIn }

class UserState extends Equatable {
  final AuthStatus authStatus;
  final User? user;

  const UserState._({
    this.authStatus = AuthStatus.notLoggedIn,
    this.user,
  });

  const UserState.initial() : this._();

  const UserState.loggedIn({required User user})
      : this._(authStatus: AuthStatus.loggedIn, user: user);

  @override
  List<Object?> get props => [authStatus, user];
}
