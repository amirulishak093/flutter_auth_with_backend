import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection/injection.dart';
import 'bloc/signup_bloc.dart';
import 'signup_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(runtimeType.toString())),
        body: SafeArea(
          child: BlocProvider(
            create: (context) => getIt<SignupBloc>(),
            child: const SignupForm(),
          ),
        ));
  }
}
