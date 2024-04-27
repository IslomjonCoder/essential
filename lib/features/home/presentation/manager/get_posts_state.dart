part of 'get_posts_cubit.dart';

class GetPostsState {
  final FormzSubmissionStatus status;
  final List<PostModel> posts;
  final Failure? failure;

  GetPostsState({
    this.status = FormzSubmissionStatus.initial,
    this.posts = const [],
    this.failure,
  });

  GetPostsState.success(List<PostModel> posts) : this(status: FormzSubmissionStatus.success, posts: posts);

  GetPostsState.failure(Failure failure) : this(status: FormzSubmissionStatus.failure, failure: failure);


  GetPostsState copyWith({
    FormzSubmissionStatus? status,
    List<PostModel>? posts,
    Failure? failure,
  }) {
    return GetPostsState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      failure: failure ?? this.failure,
    );
  }
}
