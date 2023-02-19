import 'package:flutter/material.dart';
import 'package:flutter_auth/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'features/login/presentation/bloc/login_bloc.dart';
import 'features/signup/presentation/bloc/signup_bloc.dart';
import 'injection/injection.dart';
import 'router.dart';

void main() {
  configureDependencies(Environment.dev);
  runApp(MultiBlocProvider(providers: [
    BlocProvider<UserBloc>(
      create: (context) => getIt<UserBloc>(),
    ),
  ], child: const App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
    );
  }
}
