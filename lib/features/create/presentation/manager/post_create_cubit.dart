import 'package:essential/core/failure/failure.dart';
import 'package:essential/features/home/data/models/post_model.dart';
import 'package:essential/features/home/data/repositories/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'post_create_state.dart';

class PostCreateCubit extends Cubit<PostCreateState> {
  final PostRepository postRepository;
  final titleController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  PostCreateCubit(this.postRepository) : super(PostCreateState());

  void pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(state.copyWith(image: image, status: FormzSubmissionStatus.initial));
    }
  }

  void createPost() async {
    if (state.image == null) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, failure: Failure(message: 'No image selected.')));
      return;
    }

    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    final result = await postRepository.addPost(Post(title: titleController.text.trim()), state.image!);
    result.fold(
      (failure) => emit(state.copyWith(status: FormzSubmissionStatus.failure, failure: failure)),
      (response) => emit(PostCreateState.success(response)),
    );
  }
}
