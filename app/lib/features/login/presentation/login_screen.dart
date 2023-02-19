import 'package:flutter/material.dart';
import 'package:flutter_auth/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter_auth/injection/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(runtimeType.toString())),
        body: SafeArea(
          child: BlocProvider(
            create: (context) => getIt<LoginBloc>(),
            child: const LoginForm(),
          ),
        ));
  }
}
