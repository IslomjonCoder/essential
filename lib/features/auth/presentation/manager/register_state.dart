part of 'register_cubit.dart';

class RegisterState {
  final FormzSubmissionStatus status;
  final Failure? failure;
  final bool isObscure;

  const RegisterState({
    this.status = FormzSubmissionStatus.initial,
    this.failure,
    this.isObscure = true,
  });

  RegisterState.success() : this(status: FormzSubmissionStatus.success);

  RegisterState.failure(Failure failure) : this(status: FormzSubmissionStatus.failure, failure: failure);

  RegisterState copyWith({
    FormzSubmissionStatus? status,
    Failure? failure,
    bool? isObscure,
  }) {
    return RegisterState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      isObscure: isObscure ?? this.isObscure,
    );
  }
}
