import 'package:flutter/material.dart';
import 'package:flutter_auth/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter_auth/features/user/presentation/bloc/user_event.dart';
import 'package:flutter_auth/features/user/presentation/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      final user = state.user;

      return Scaffold(
          appBar: AppBar(title: Text(runtimeType.toString())),
          body: SafeArea(
              child: Center(
                  child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: user != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                  Text(user.id),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    user.username,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    user.bio!,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8.0),
                                  ElevatedButton(
                                    onPressed: () {
                                      context
                                          .read<UserBloc>()
                                          .add(const LogoutRequested());
                                    },
                                    child: const Text('Log out'),
                                  )
                                ])
                          : const CircularProgressIndicator()))));
    });
  }
}
