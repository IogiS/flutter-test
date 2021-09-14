import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/auth/%20login/login_view.dart';
import 'package:test_flutter/auth/auth_repository.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:RepositoryProvider(
        create: (context) =>  AuthRepository(),
        child: LoginView(),
      )
    );
  }
}


