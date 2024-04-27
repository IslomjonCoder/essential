import 'package:essential/features/auth/presentation/pages/welcome_screen.dart';
import 'package:essential/features/navigation/pages/navigation.dart';
import 'package:essential/main.dart';
import 'package:flutter/material.dart';

class Redirect extends StatelessWidget {
  const Redirect({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data?.session != null) {
            return const NavigationScreen();
          }
          // Navigator.pop(context);
          return const WelcomeScreen();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
