part of 'get_user_posts_cubit.dart';

 class GetUserPostsState {
   final FormzSubmissionStatus status;
   final Failure? failure;
   final List<Post> posts;

   GetUserPostsState({
     this.status = FormzSubmissionStatus.initial,
     this.failure,
     this.posts = const [],
   });

   GetUserPostsState.success(List<Post> posts) : this(status: FormzSubmissionStatus.success, posts: posts);

   GetUserPostsState.failure(Failure failure) : this(status: FormzSubmissionStatus.failure, failure: failure);

   GetUserPostsState copyWith({
     FormzSubmissionStatus? status,
     List<Post>? posts,
     Failure? failure,
   }) {
     return GetUserPostsState(
       status: status ?? this.status,
       posts: posts ?? this.posts,
       failure: failure ?? this.failure,
     );
   }
 }

