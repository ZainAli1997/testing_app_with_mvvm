import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testing_app_with_mvvm/core/theme/colors.dart';
import 'package:testing_app_with_mvvm/core/theme/spacing.dart';
import 'package:testing_app_with_mvvm/core/utils/validation_utils.dart';
import 'package:testing_app_with_mvvm/core/widgets/custom_button.dart';
import 'package:testing_app_with_mvvm/core/widgets/custom_text_field.dart';
import 'package:testing_app_with_mvvm/core/widgets/snackbar.dart';
import 'package:testing_app_with_mvvm/features/post/viewmodel/post_viewmodel.dart';

class AddPostPage extends ConsumerStatefulWidget {
  const AddPostPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddPostPageState();
}

class _AddPostPageState extends ConsumerState<AddPostPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref
        .watch(postViewModelProvider.select((val) => val?.isLoading == true));
    ref.listen(
      postViewModelProvider,
      (_, next) {
        next?.when(
          data: (data) {
            showSnackBar(
              context,
              'Post Uploaded Successfully!',
            );
            Navigator.pop(context);
          },
          error: (error, stackTrace) {
            showSnackBar(context, error.toString());
          },
          loading: () {},
        );
      },
    );
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _titleController,
                        validator: validateField,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        hintText: "Enter Title",
                        hintTextStyle: const TextStyle(
                          fontSize: 30,
                        ),
                        cursorTextStyle: const TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      20.kH,
                      CustomTextField(
                        controller: _descriptionController,
                        validator: validateField,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        hintText: "Enter Description",
                        hintTextStyle: const TextStyle(
                          fontSize: 30,
                        ),
                        cursorTextStyle: const TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      40.kH,
                      CustomButton(
                        height: 60,
                        buttoncolor: themewhitecolor,
                        borderRadius: BorderRadius.circular(30),
                        child: const Text(
                          "Add Post",
                          style: TextStyle(
                            color: themeblackcolor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await ref
                                .read(postViewModelProvider.notifier)
                                .addPost(
                                  title: _titleController.text,
                                  description: _descriptionController.text,
                                );
                          } else {
                            showSnackBar(context, 'Missing fields!');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
