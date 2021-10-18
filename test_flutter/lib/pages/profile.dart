import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:test_flutter/auth/auth_repository.dart';
import 'package:test_flutter/pages/goods_list.dart';
import 'package:test_flutter/pages/welcome_pages.dart';

/// This is the main application widget.
class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyStatefulWidget(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  Widget goodsLists = goodsList();
  Widget welcomePage = WelcomePage();

  static const TextStyle optionStyle =
      TextStyle(fontSize: 25, fontWeight: FontWeight.bold);

  void getUserInfo() {
    /* print(AuthRepository.token);
    final JwtClaim decClaimSet =
        verifyJwtHS256Signature(AuthRepository.token, 's3cr3t');
    // print(decClaimSet);
    print(decClaimSet); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
              future: AuthRepository.getTokens(),
              builder: (_, snapshot) {
                var token;
                JwtClaim decClaimSet;
                String email = '', password = '';
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  String a = jsonEncode(snapshot.data);
                  token = a.replaceFirst('{"token":"', '').split('"');
                  const key = 's3cr3t';
                  decClaimSet = verifyJwtHS256Signature(token[0], key);
                  email = decClaimSet.payload.values.last;
                  password = decClaimSet.payload.values.first;
                }
                return Text(
                  'email: $email\npassword: $password',
                  style: optionStyle,
                );
              }),
        ],
      )),
    );
  }
}
