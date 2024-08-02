import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_banking/blocs/auth/auth_bloc.dart';
import 'package:online_banking/blocs/auth/auth_event.dart';
import 'package:online_banking/blocs/card/card_bloc.dart';
import 'package:online_banking/ui/auth_page.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthBloc(firebaseAuth: FirebaseAuth.instance)..add(AppStarted()),
        ),
        BlocProvider(
          create: (context) => CardBloc(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.amber.shade100,
            appBarTheme: AppBarTheme(color: Colors.amber.shade100)),
        debugShowCheckedModeBanner: false,
        home: AuthPage(),
      ),
    );
  }
}
