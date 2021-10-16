import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/auth/login/login_view.dart';
import 'package:test_flutter/auth/auth_repository.dart';
import 'package:test_flutter/pages/goods_list.dart';
import 'package:test_flutter/pages/main_content.dart';
import 'package:test_flutter/pages/welcome_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => RepositoryProvider(
              create: (context) => AuthRepository(),
              child: LoginView(),
            ),
        '/welcomePage': (context) => WelcomePage(),
        '/goodsList': (context) => goodsList(),
        '/mainContent': (context) => MainContent(),
      },
    );
  }
}
