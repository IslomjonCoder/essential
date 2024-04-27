import 'package:essential/core/constants/colors.dart';
import 'package:essential/core/constants/images.dart';
import 'package:essential/core/constants/text_styles.dart';
import 'package:essential/features/auth/data/repositories/auth_repository.dart';
import 'package:essential/features/auth/presentation/manager/login_cubit.dart';
import 'package:essential/features/auth/presentation/pages/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => LoginCubit(AuthRepositoryImpl()),
        child: BlocListener<LoginCubit, LoginState>(
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
          child: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              final cubit = context.read<LoginCubit>();
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
                              'Welcome back! Glad to see you, Again!',
                              style: AppTextStyles.authTitle,
                            ),
                            const Gap(58 / 2),
                            TextFormField(
                              controller: cubit.emailController,
                              decoration: const InputDecoration(hintText: "Email"),
                            ),
                            const Gap(16),
                            TextFormField(
                              controller: cubit.passwordController,
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
                              onPressed: cubit.login,
                              child: const Text('Login'),
                            ),
                            const Gap(16),
                            Column(
                              children: [
                                const Row(
                                  children: [
                                    Expanded(child: Divider(endIndent: 12)),
                                    Text('Or Login with', style: AppTextStyles.orLoginWith),
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
                      const Text('Don’t have an account?', style: AppTextStyles.dontHaveAccount),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
                        },
                        child: const Text('Register Now'),
                      ),
                    ],
                  ),
                  const Gap(8),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
