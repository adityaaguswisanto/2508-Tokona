import 'package:tokona/packages/packages.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GetCurrentLogin getCurrentLogin;

  LoginBloc(this.getCurrentLogin) : super(const LoginState()) {
    on<LoginSubmitted>((event, emit) async {
      emit(
        state.copyWith(
          status: LoginResponse.loading,
        ),
      );
      final result = await getCurrentLogin.post(
        event.username,
        event.password,
      );
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              status: LoginResponse.failure,
              message: failure.message,
              statusCode: failure.statusCode,
            ),
          );
        },
        (login) {
          emit(
            state.copyWith(
              status: LoginResponse.success,
              login: login,
            ),
          );
        },
      );
    });
  }
}
