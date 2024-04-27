part of 'post_create_cubit.dart';

class PostCreateState {
  final FormzSubmissionStatus status;
  final Failure? failure;
  final XFile? image;
  final PostModel? posts;
  PostCreateState({
    this.status = FormzSubmissionStatus.initial,
    this.failure,
    this.image,
    this.posts,
  });

  PostCreateState.success(PostModel posts) : this(status: FormzSubmissionStatus.success, posts: posts);

  PostCreateState.failure(Failure failure) : this(status: FormzSubmissionStatus.failure, failure: failure);

  PostCreateState copyWith({
    FormzSubmissionStatus? status,
    Failure? failure,
    XFile? image,
    PostModel? posts,
  }) {
    return PostCreateState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      image: image ?? this.image,
      posts: posts ?? this.posts,
    );
  }
}
