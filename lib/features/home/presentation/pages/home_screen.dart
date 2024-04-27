import 'package:blurhash_dart/blurhash_dart.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:essential/features/home/presentation/manager/get_posts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetPostsCubit, GetPostsState>(
        builder: (context, state) {
          if (state.status.isInProgress) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status.isFailure) {
            return Center(
              child: Text(state.failure?.message ?? 'Unknown error'),
            );
          }
          return PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              final post = state.posts[index];

              return Stack(
                fit: StackFit.expand,
                children: [
                  //     (post.blurhash != null)
                  //                       ? flutter_blurhash.BlurHash(
                  //                           hash: post.blurhash!,
                  //                           image: post.image,
                  //                           imageFit: BoxFit.cover,
                  //                         )
                  //                       :
                  CachedNetworkImage(imageUrl: post.image, fit: BoxFit.cover),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black],
                        stops: [0.75, 1.0],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Text(
                      post.title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

Future<String?> generateBlurHash(String? imageUrl) async {
  if (imageUrl == null) return null;
  // Load image data

  final response = await http.get(Uri.parse(imageUrl));

  // Decode image data to pixel data
  final image = img.decodeJpg(response.bodyBytes);

  if (image == null) return null;
  // Create BlurHash
  final blurHash = BlurHash.encode(image, numCompX: 4, numCompY: 3);

  return blurHash.hash;
}
