import 'package:equatable/equatable.dart';

import 'user_state.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class StatusChanged extends UserEvent {
  final AuthStatus status;

  const StatusChanged({required this.status});

  @override
  List<Object?> get props => [status];
}

class LogoutRequested extends UserEvent {
  const LogoutRequested();

  @override
  List<Object?> get props => [];
}
