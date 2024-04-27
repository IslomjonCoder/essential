import 'package:essential/core/failure/failure.dart';
import 'package:essential/features/home/data/models/post_model.dart';
import 'package:essential/features/home/data/repositories/post_repository.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_user_posts_state.dart';

class GetUserPostsCubit extends Cubit<GetUserPostsState> {
  final PostRepository repository;

  GetUserPostsCubit(this.repository) : super(GetUserPostsState()) {
    getPosts();
  }

  void getPosts() async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final result = await repository.getPostsByUser();
    result.fold(
      (failure) => emit(GetUserPostsState.failure(failure)),
      (posts) => emit(GetUserPostsState.success(posts)),
    );
  }
}
