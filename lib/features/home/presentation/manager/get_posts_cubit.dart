import 'package:essential/core/failure/failure.dart';
import 'package:essential/features/home/data/models/post_model.dart';
import 'package:essential/features/home/data/repositories/post_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'get_posts_state.dart';

class GetPostsCubit extends Cubit<GetPostsState> {
  final PostRepository postRepository;

  GetPostsCubit(this.postRepository) : super(GetPostsState()) {
    getPosts();
  }

  void getPosts() async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    final result = await postRepository.getPosts();
    result.fold(
      (failure) => emit(GetPostsState.failure(failure)),
      (posts) => emit(GetPostsState.success(posts)),
    );
  }

  updatePosts(PostModel post) {
    final newPosts = List<PostModel>.from(state.posts);
    newPosts.insert(0, post);
    emit(state.copyWith(posts: newPosts));
  }
}
