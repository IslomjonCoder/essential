import 'dart:io';

import 'package:essential/core/failure/failure.dart';
import 'package:essential/features/home/data/data_sources/post_data_source.dart';
import 'package:essential/features/home/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class PostRepository {
  final PostDataSource dataSource;

  PostRepository(this.dataSource);

  Future<Either<Failure, List<PostModel>>> getPosts();

  Future<Either<Failure, List<PostModel>>> getPostsByUser();

  Future<Either<Failure, PostModel>> addPost(Post post, XFile image);
}

class PostRepositoryImpl implements PostRepository {
  @override
  Future<Either<Failure, PostModel>> addPost(Post post, XFile image) async {
    try {
      final response = await dataSource.addPost(post, image);
      return right(response);
    // } on StorageException catch (e) {
    //   return left(StorageFailure(message: e.message));
    } on PostgrestException catch (e) {
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
  Future<Either<Failure, List<PostModel>>> getPosts() async {
    try {
      final response = await dataSource.getPosts();
      return right(response);
    } on PostgrestException catch (e) {
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
  Future<Either<Failure, List<PostModel>>> getPostsByUser() async {
    try {
      final response = await dataSource.getPostsByUser();
      return right(response);
    } on PostgrestException catch (e) {
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
  PostDataSource get dataSource => PostDataSourceImpl();
}
