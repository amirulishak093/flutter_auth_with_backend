import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../repositories/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  late StreamSubscription<AuthStatus> _statusSubscription;

  UserBloc(UserRepository userRepository)
      : _userRepository = userRepository,
        super(const UserState.initial()) {
    on<StatusChanged>((event, emit) async {
      if (event.status == AuthStatus.notLoggedIn) {
        return emit(const UserState.initial());
      }

      final result = await _userRepository.getCurrentUser();

      result.fold((failure) => log("hey"), (user) {
        return emit(UserState.loggedIn(user: user!));
      });
    });

    on<LogoutRequested>((event, emit) {
      _userRepository.logOut();
    });

    _statusSubscription = _userRepository.authStatus
        .listen((status) => add(StatusChanged(status: status)));
  }

  @override
  Future<void> close() {
    _statusSubscription.cancel();
    return super.close();
  }
}
