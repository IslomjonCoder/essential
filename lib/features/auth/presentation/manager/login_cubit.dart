import 'package:essential/core/failure/failure.dart';
import 'package:essential/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository repository;

  LoginCubit(this.repository) : super(const LoginState());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void changeVisibility() {
    emit(state.copyWith(isObscure: !state.isObscure));
  }

  void login() async {
    if (!formKey.currentState!.validate()) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final result = await repository.login(emailController.text, passwordController.text);
    result.fold(
      (failure) => emit(LoginState.failure(failure)),
      (_) => emit(LoginState.success()),
    );
  }
}
