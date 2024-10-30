import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testing_app_with_mvvm/core/theme/colors.dart';
import 'package:testing_app_with_mvvm/core/theme/spacing.dart';
import 'package:testing_app_with_mvvm/core/utils/file_picker.dart';
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

  File? image;
  Uint8List? webImage;

  void selectImage() async {
    var res = await pickImage();
    if (res != null) {
      if (kIsWeb) {
        setState(() {
          webImage = res.files.first.bytes;
        });
      } else {
        setState(() {
          image = File(res.files.first.path!);
        });
      }
    }
  }

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
          : SafeArea(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: selectImage,
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(),
                              image: image != null
                                  ? DecorationImage(
                                      image: FileImage(image!),
                                      fit: BoxFit.cover,
                                    )
                                  : webImage != null
                                      ? DecorationImage(
                                          image: MemoryImage(webImage!),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                            ),
                            child: image != null
                                ? null
                                : Icon(
                                    Icons.add,
                                    size: 40,
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
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
                            if (_formKey.currentState!.validate() &&
                                    image != null ||
                                webImage != null) {
                              await ref
                                  .read(postViewModelProvider.notifier)
                                  .addPost(
                                    title: _titleController.text,
                                    image: image,
                                    webImage: webImage,
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
            ),
    );
  }
}
