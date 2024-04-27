import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:essential/core/failure/failure.dart';
import 'package:essential/features/auth/data/data_sources/auth_data_source.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  final AuthDataSource dataSource;

  AuthRepository(this.dataSource);

  Future<Either<Failure, Unit>> login(String email, String password);

  Future<Either<Failure, Unit>> register(String email, String password);

  Future<Either<Failure, Unit>> logout();

  Future<Either<Failure, Unit>> googleLogin();
}

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<Failure, Unit>> login(String email, String password) async {
    try {
      await dataSource.login(email, password);
      return right(unit);
    } on AuthException catch (e) {
      return left(PostgrestFailure(message: e.message));
    } on FormatException catch (e) {
      return left(FormatFailure(message: e.message));
    } on SocketException {
      return left(ConnectionFailure(message: 'No internet connection'));
    } on PlatformException catch (e) {
      return left(PlatformFailure(message: e.message ?? "Platform Failure"));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> register(String email, String password) async {
    try {
      await dataSource.register(email, password);
      return right(unit);
    } on AuthException catch (e) {
      return left(PostgrestFailure(message: e.message));
    } on FormatException catch (e) {
      return left(FormatFailure(message: e.message));
    } on SocketException {
      return left(ConnectionFailure(message: 'No internet connection'));
    } on PlatformException catch (e) {
      return left(PlatformFailure(message: e.message ?? "Platform Failure"));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await dataSource.logout();
      return right(unit);
    } on AuthException catch (e) {
      return left(PostgrestFailure(message: e.message));
    } on FormatException catch (e) {
      return left(FormatFailure(message: e.message));
    } on SocketException {
      return left(ConnectionFailure(message: 'No internet connection'));
    } on PlatformException catch (e) {
      return left(PlatformFailure(message: e.message ?? "Platform Failure"));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> googleLogin() async {
    try {
      await dataSource.googleLogin();
      return right(unit);
    } on AuthException catch (e) {
      return left(PostgrestFailure(message: e.message));
    } on FormatException catch (e) {
      return left(FormatFailure(message: e.message));
    } on SocketException {
      return left(ConnectionFailure(message: 'No internet connection'));
    } on PlatformException catch (e) {
      return left(PlatformFailure(message: e.message ?? "Platform Failure"));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  AuthDataSource get dataSource => AuthDataSourceImpl();
}
