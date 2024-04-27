import 'dart:io';

import 'package:essential/features/create/presentation/manager/post_create_cubit.dart';
import 'package:essential/features/home/data/repositories/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  BuildContext? dialogContext;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostCreateCubit(PostRepositoryImpl()),
      child: BlocListener<PostCreateCubit, PostCreateState>(
        listener: (context, state) async {
          if (state.status.isInProgress) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) {
                dialogContext = ctx;
                return Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: const CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                );
              },
            );
          }
          if (state.status.isSuccess) {
            if (Navigator.canPop(dialogContext!)) Navigator.pop(dialogContext!);
            Navigator.pop(context, state.posts);
          }
          if (state.status.isFailure) {
            if (dialogContext != null) {
              if (Navigator.canPop(dialogContext!)) Navigator.pop(dialogContext!);
            }
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.failure?.message ?? 'Failure to create post'),
              ),
            );
          }
        },
        child: BlocBuilder<PostCreateCubit, PostCreateState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.grey.shade100,
              appBar: AppBar(
                title: const Text('Create'),
                actions: [
                  IconButton(
                    onPressed: () async {
                      context.read<PostCreateCubit>().createPost();
                    },
                    icon: const Icon(Icons.check),
                  )
                ],
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: GestureDetector(
                        onTap: () async => context.read<PostCreateCubit>().pickImage(),
                        child: AspectRatio(
                          aspectRatio: 9 / 16,
                          child: state.image == null
                              ? Container(
                                  decoration:
                                      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                                  child: const Icon(Icons.add),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    File(state.image!.path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: context.read<PostCreateCubit>().formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: TextFormField(
                        maxLines: 5,
                        controller: context.read<PostCreateCubit>().titleController,
                        textCapitalization: TextCapitalization.sentences,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                        decoration: const InputDecoration(
                          hintText: 'Post title',
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
