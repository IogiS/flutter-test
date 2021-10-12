import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/auth/auth_repository.dart';
import 'package:test_flutter/auth/form_submissin_status.dart';
import 'package:test_flutter/auth/login/login_event.dart';
import 'package:test_flutter/auth/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  LoginBloc({required this.authRepository}) : super(LoginState());
  String username = '', password = '';
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginUsernameChanged) {
      username = event.username;
      yield state.copyWith(
          username: event.username, formStatus: InitialFormStatus());
    } else if (event is LoginPasswordChanged) {
      password = event.password;
      yield state.copyWith(
          password: event.password, formStatus: InitialFormStatus());
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        await authRepository.login(username, password);
        yield state.copyWith(formStatus: SubmissionSuccess());
      } on Exception catch (exception) {
        yield state.copyWith(formStatus: SubmissionFailed(exception));
      }
    }
  }
}
