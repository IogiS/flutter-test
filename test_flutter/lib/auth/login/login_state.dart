import 'package:test_flutter/auth/form_submissin_status.dart';

class LoginState {
  final String username;
  bool get isValidUsername => username.length > 3;

  final String password;
  bool get isValidPassword => password.length > 6;

  final FormSubmissionStatus? formStatus;

  LoginState({
    this.username = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  LoginState copyWith({
    String? username,
    String? password,
    required FormSubmissionStatus formStatus,
  }) {
    return LoginState(
      username: username.toString(),
      password: password.toString(),
      formStatus: formStatus,
    );
  }
}
