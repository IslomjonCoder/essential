import 'package:essential/core/constants/images.dart';
import 'package:essential/features/auth/presentation/pages/login_screen.dart';
import 'package:essential/features/auth/presentation/pages/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImages.welcomeBackground), fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black12, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(flex: 3),
                  Text('Welcome to App',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center),
                  const Spacer(flex: 3),
                  FilledButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                    },
                    child: const Text('Login'),
                  ),
                  const Gap(12),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
                    },
                    child: const Text('Register'),
                  ),
                  const Spacer(flex: 1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
