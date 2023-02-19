import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_auth/features/start/presentation/start_screen.dart';
import 'package:flutter_auth/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter_auth/features/user/presentation/bloc/user_state.dart';
import 'package:flutter_auth/features/user/repositories/user_repository.dart';
import 'package:flutter_auth/injection/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'core/router_notifier.dart';
import 'features/home/presentation/home_screen.dart';
import 'features/login/presentation/login_screen.dart';
import 'features/signup/presentation/signup_screen.dart';

final userBloc = getIt<UserBloc>();

final GoRouter appRouter = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
          name: 'start',
          path: '/start',
          builder: (context, state) => const StartScreen()),
      GoRoute(
          name: 'logIn',
          path: '/logIn',
          builder: (context, state) => const LoginScreen()),
      GoRoute(
        name: 'home',
        path: '/',
        builder: (context, state) => const HomeScreen(),
      )
    ],
    redirect: (context, state) {
      final bool loggedIn = userBloc.state.authStatus == AuthStatus.loggedIn;
      final bool isPathLogIn = state.subloc == '/logIn';

      log(loggedIn.toString());

      if (!loggedIn) {
        return '/start';
      }

      if (isPathLogIn) {
        return '/';
      }

      return null;
    },
    refreshListenable: RouterNotifier(userBloc.stream));
