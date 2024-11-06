import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testing_app_with_mvvm/core/providers/current_user_notifier.dart';
import 'package:testing_app_with_mvvm/core/theme/colors.dart';
import 'package:testing_app_with_mvvm/core/theme/spacing.dart';
import 'package:testing_app_with_mvvm/core/utils/file_picker.dart';
import 'package:testing_app_with_mvvm/core/utils/validation_utils.dart';
import 'package:testing_app_with_mvvm/core/widgets/custom_button.dart';
import 'package:testing_app_with_mvvm/core/widgets/custom_text_field.dart';
import 'package:testing_app_with_mvvm/core/widgets/snackbar.dart';
import 'package:testing_app_with_mvvm/features/auth/viewmodel/auth_viewmodel.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  File? profileImage;
  Uint8List? webProfileImage;

  late String originalName;
  late String originalProfileImage;

  void selectImage() async {
    var res = await pickImage();
    if (res != null) {
      if (kIsWeb) {
        setState(() {
          webProfileImage = res.files.first.bytes;
        });
      } else {
        setState(() {
          profileImage = File(res.files.first.path!);
        });
      }
    }
  }

  @override
  void initState() {
    final user = ref.read(currentUserNotifierProvider)!;
    _nameController.text = user.name;
    originalName = user.name;
    originalProfileImage = user.profileImage;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  bool _hasChanges() {
    return _nameController.text != originalName ||
        (profileImage != null || webProfileImage != null);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref
        .watch(authViewModelProvider.select((val) => val?.isLoading == true));
    ref.listen(
      authViewModelProvider,
      (_, next) {
        next?.when(
          data: (data) {
            showSnackBar(
              context,
              'Profile Updated Successfully!',
            );
            Navigator.pop(context);
          },
          error: (error, st) {
            showSnackBar(context, error.toString());
          },
          loading: () {},
        );
      },
    );
    final user = ref.read(currentUserNotifierProvider)!;
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: selectImage,
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              shape: BoxShape.circle,
                              image: profileImage != null
                                  ? DecorationImage(
                                      image: FileImage(profileImage!),
                                      fit: BoxFit.cover,
                                    )
                                  : webProfileImage != null
                                      ? DecorationImage(
                                          image: MemoryImage(
                                            webProfileImage!,
                                          ),
                                          fit: BoxFit.cover,
                                        )
                                      : user.profileImage != ''
                                          ? DecorationImage(
                                              image: NetworkImage(
                                                user.profileImage,
                                              ),
                                              fit: BoxFit.cover,
                                            )
                                          : null,
                            ),
                            child: profileImage != null ||
                                    webProfileImage != null ||
                                    user.profileImage != ''
                                ? null
                                : Icon(
                                    Icons.add,
                                    size: 40,
                                  ),
                          ),
                        ),
                        CustomTextField(
                          controller: _nameController,
                          validator: validateName,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          hintText: "Enter Name",
                          hintTextStyle: const TextStyle(
                            fontSize: 30,
                          ),
                          cursorTextStyle: const TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        40.kH,
                        if (_hasChanges())
                          CustomButton(
                            height: 60,
                            buttoncolor: themewhitecolor,
                            borderRadius: BorderRadius.circular(30),
                            child: const Text(
                              "Save",
                              style: TextStyle(
                                color: themeblackcolor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () async {
                              await ref
                                  .read(authViewModelProvider.notifier)
                                  .editProfile(
                                    _nameController.text,
                                    profileImage,
                                    webProfileImage,
                                  );
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
