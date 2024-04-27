import 'package:essential/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthDataSource {
  Future<void> login(String email, String password);

  Future<void> register(String email, String password);

  Future<void> logout();

  Future<void> googleLogin();
}

class AuthDataSourceImpl implements AuthDataSource {
  @override
  Future<void> login(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(password: password, email: email);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> register(String email, String password) async {
    try {
      await supabase.auth.signUp(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> googleLogin() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    await supabase.auth.signInWithIdToken(provider: OAuthProvider.google, idToken: idToken, accessToken: accessToken);
  }
}
