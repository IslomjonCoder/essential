import 'package:essential/core/failure/failure.dart';
import 'package:essential/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository repository;

  RegisterCubit(this.repository) : super(const RegisterState());
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void changeVisibility() => emit(state.copyWith(isObscure: !state.isObscure));

  void register() async {
    if (!formKey.currentState!.validate()) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    final result = await repository.register(emailController.text, passwordController.text);
    result.fold(
      (failure) => emit(RegisterState.failure(failure)),
      (_) => emit(RegisterState.success()),
    );
  }
}
