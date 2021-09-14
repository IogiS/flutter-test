import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/auth/auth_repository.dart';
import 'package:test_flutter/auth/form_submissin_status.dart';
import 'package:test_flutter/auth/%20login/login_event.dart';
import 'package:test_flutter/auth/%20login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState> {
  final AuthRepository authRepository;
  LoginBloc({required this.authRepository}) : super(LoginState());



  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginUsernameChanged) {
      yield state.copyWith(username: event.username);


    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);


    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        await authRepository.login();
        yield state.copyWith(formStatus: SubmissionSuccess());
      }on Exception catch (exception) {
        yield state.copyWith(formStatus: SubmissionFailed(exception));
      }
    }
  }
}