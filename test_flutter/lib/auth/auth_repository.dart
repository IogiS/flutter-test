import 'dart:async';
import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_session/flutter_session.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;

class AuthRepository {
  static final SESSION = FlutterSession();
  Future<void> login(String username, String password) async {
    const baseUrl = 'https://my-json-server.typicode.com/IogiS/FakeRestAPI';

    bool candidate = false;
    try {
      var res = await http.get('$baseUrl/users');

      final user = jsonDecode(res.body);
      user.forEach((val) {
        if (val['email'] == username) {
          candidate = true;
        }
      });
      if (candidate) {
        var token = getToken(username, password);
        setToken(token, "my_refresh_token");
      } else {
        throw Exception();
      }
    } finally {
      // done you can do something here
    }
  }

  String getToken(String username, String password) {
    const key = 's3cr3t';
    final claimSet = JwtClaim(
        subject: 'kleak',
        issuer: 'teja',
        audience: <String>['audience1.example.com', 'audience2.example.com'],
        otherClaims: <String, dynamic>{
          'typ': 'authnresponse',
          'pld': {'username': username, 'password': password}
        },
        maxAge: const Duration(minutes: 5));

    String token = issueJwtHS256(claimSet, key);
    final JwtClaim decClaimSet = verifyJwtHS256Signature(token, key);
    return token;
  }

  /* try {
      final JwtClaim decClaimSet = verifyJwtHS256Signature(token, key);
      // print(decClaimSet);
      print(decClaimSet);
      decClaimSet.validate(issuer: 'teja', audience: 'audience1.example.com');

      if (claimSet.jwtId != null) {
        print(claimSet.jwtId);
      }
      if (claimSet.containsKey('typ')) {
        final v = claimSet['typ'];
        if (v is String) {
          print(v);
        } else {}
      }
    } on JwtException {} */
  static setToken(String token, String refreshToken) async {
    _AuthData data = _AuthData(token, refreshToken);
    await SESSION.set('tokens', data);
  }

  static Future getTokens() async => await SESSION.get('tokens');

  static removeToken() async {
    await SESSION.prefs.clear();
  }
}

class _AuthData {
  String token, refreshToken;
  _AuthData(this.token, this.refreshToken);

  // toJson
  // required by Session lib
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['token'] = token;
    data['refreshToken'] = refreshToken;
    return data;
  }
}
