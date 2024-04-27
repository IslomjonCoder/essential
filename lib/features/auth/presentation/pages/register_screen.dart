import 'package:essential/core/constants/colors.dart';
import 'package:essential/core/constants/images.dart';
import 'package:essential/core/constants/text_styles.dart';
import 'package:essential/features/auth/data/repositories/auth_repository.dart';
import 'package:essential/features/auth/presentation/manager/register_cubit.dart';
import 'package:essential/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => RegisterCubit(AuthRepositoryImpl()),
        child: BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state.status.isFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.failure?.message ?? 'Unknown error')),
              );
            }
            if (state.status.isSuccess) {
              Navigator.pop(context);
            }
          },
          child: BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              final cubit = context.read<RegisterCubit>();
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Form(
                        key: cubit.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Gap(57),
                            const Text(
                              'Hello! Register to get started',
                              style: AppTextStyles.authTitle,
                            ),
                            const Gap(58 / 2),
                            TextFormField(
                              controller:  cubit.usernameController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(hintText: "Username"),
                            ),
                            const Gap(16),
                            TextFormField(
                              controller:  cubit.emailController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                final regEx =
                                    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                if (!regEx.hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(hintText: "Email"),
                            ),
                            const Gap(16),
                            TextFormField(
                              controller: cubit.passwordController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "Password",
                                suffixIcon: IconButton(
                                  onPressed: cubit.changeVisibility,
                                  icon: Icon(state.isObscure ? Icons.visibility_off : Icons.visibility),
                                ),
                              ),
                              obscureText: state.isObscure,
                            ),
                            const Gap(16),
                            state.status.isInProgress
                                ? const Center(child: CircularProgressIndicator())
                                : FilledButton(
                                    onPressed: cubit.register,

                                    child: const Text('Register'),
                                  ),
                            const Gap(16),
                            Column(
                              children: [
                                const Row(
                                  children: [
                                    Expanded(child: Divider(endIndent: 12)),
                                    Text('Or Register with', style: AppTextStyles.orLoginWith),
                                    Expanded(child: Divider(indent: 12)),
                                  ],
                                ),
                                const Gap(22),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      borderRadius: BorderRadius.circular(8),
                                      onTap: () {},
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: AppColors.borderColor),
                                          ),
                                          height: 56,
                                          width: 105,
                                          child: Image.asset(AppImages.google)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?', style: AppTextStyles.dontHaveAccount),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                        },
                        child: const Text('Login Now'),
                      ),
                    ],
                  ),
                  const Gap(8)
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
