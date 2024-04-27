part of 'login_cubit.dart';

class LoginState {
  final FormzSubmissionStatus status;
  final Failure? failure;
  final bool isObscure;

  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.failure,
    this.isObscure = true,
  });

  LoginState.success() : this(status: FormzSubmissionStatus.success);

  LoginState.failure(Failure failure) : this(status: FormzSubmissionStatus.failure, failure: failure);

  LoginState copyWith({
    FormzSubmissionStatus? status,
    Failure? failure,
    bool? isObscure,
  }) {
    return LoginState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      isObscure: isObscure ?? this.isObscure,
    );
  }
}
