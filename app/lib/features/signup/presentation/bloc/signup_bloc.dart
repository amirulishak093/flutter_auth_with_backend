import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

import '../../../user/repositories/user_repository.dart';
import '../models/password.dart';
import '../models/username.dart';
import 'signup_event.dart';
import 'signup_state.dart';

@injectable
class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final UserRepository _userRepository;

  SignupBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const SignupState()) {
    on<UsernameChanged>((event, emit) {
      final username = Username.dirty(event.username);
      emit(
        state.copyWith(
          username: username,
          status: Formz.validate([state.password, username]),
        ),
      );
    });

    on<PasswordChanged>((event, emit) {
      final password = Password.dirty(event.password);
      emit(
        state.copyWith(
          password: password,
          status: Formz.validate([password, state.username]),
        ),
      );
    });
    on<SignupSubmitted>((event, emit) async {
      if (state.status.isValidated) {
        emit(state.copyWith(status: FormzStatus.submissionInProgress));

        final result = await _userRepository.logIn(
          username: state.username.value,
          password: state.password.value,
        );

        result.fold((failure) {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        }, (_) {
          emit(state.copyWith(status: FormzStatus.submissionSuccess));
        });
      }
    });
  }
}
