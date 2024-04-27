import 'package:cached_network_image/cached_network_image.dart';
import 'package:essential/features/create/presentation/pages/create_screen.dart';
import 'package:essential/features/home/data/models/post_model.dart';
import 'package:essential/features/home/presentation/manager/get_posts_cubit.dart';
import 'package:essential/features/navigation/manager/navigation_cubit.dart';
import 'package:essential/features/profile/presentation/manager/get_user_posts_cubit.dart';
import 'package:essential/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(onPressed: () => supabase.auth.signOut(), icon: const Icon(Icons.logout)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final createScreen =
              await Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateScreen()));

          if (!context.mounted) return;

          try {
            final post = createScreen as PostModel;
            context.read<GetPostsCubit>().updatePosts(post);
          } catch (e) {
            context.read<GetPostsCubit>().getPosts();
          }
          context.read<NavigationCubit>().setIndex(0);
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<GetUserPostsCubit, GetUserPostsState>(
        builder: (context, state) {
          if (state.status.isInProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status.isFailure) {
            return Center(child: Text(state.failure?.message ?? 'Unknown error'));
          }
          if (state.posts.isEmpty) {
            return const Center(child: Text('No posts yet'));
          }
          return GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImage(imageUrl: post.image, fit: BoxFit.cover),
                );
              });
        },
      ),
    );
  }
}
