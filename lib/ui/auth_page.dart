import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_banking/blocs/auth/auth_bloc.dart';
import 'package:online_banking/blocs/auth/auth_state.dart';
import 'package:online_banking/ui/home_screen.dart';
import 'package:online_banking/ui/login_screen.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthInitial || state is AuthLoading) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is AuthAuthenticated) {
          return HomeScreen();
        } else if (state is AuthUnauthenticated || state is AuthFailure) {
          return LoginPage();
        } else {
          return Container();
        }
      },
    );
  }
}
