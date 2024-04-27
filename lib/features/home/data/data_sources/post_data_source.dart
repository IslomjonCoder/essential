import 'dart:io';

import 'package:essential/features/home/data/models/post_model.dart';
import 'package:essential/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class PostDataSource {
  Future<List<PostModel>> getPosts();

  Future<List<PostModel>> getPostsByUser();

  Future<PostModel> addPost(Post post, XFile image);
}

class PostDataSourceImpl implements PostDataSource {
  @override
  Future<PostModel> addPost(Post post, XFile image) async {
    try {
      final imageExtension = image.name
          .split('.')
          .last;
      final imagePath = 'images/${supabase.auth.currentUser!.id}/${image.name}';
      await supabase.storage.from('posts').upload(
        imagePath,
        File(image.path),
        fileOptions: FileOptions(upsert: true, contentType: 'image/$imageExtension'),
      );
      final imageUrl = supabase.storage.from('posts').getPublicUrl(imagePath);

      final response = await supabase.from('posts').insert(post.copyWith(image: imageUrl).toJson()).select().single();
    return PostModel.fromJson(response);
    } catch (e) {
    rethrow;
    }
  }

  @override
  Future<List<PostModel>> getPosts() async {
    try {
      final response = await supabase.from('posts').select('*').order('created_at', ascending: false);
      return response.map((post) => PostModel.fromJson(post)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PostModel>> getPostsByUser() {
    try {
      return supabase
          .from('posts')
          .select('*')
          .eq('user', supabase.auth.currentUser!.id)
          .order('created_at', ascending: false)
          .then((value) => value.map((post) => PostModel.fromJson(post)).toList());
    } catch (e) {
      rethrow;
    }
  }
}
