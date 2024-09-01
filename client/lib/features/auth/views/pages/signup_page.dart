import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testing_app_with_mvvm/core/route_structure/go_navigator.dart';
import 'package:testing_app_with_mvvm/core/theme/colors.dart';
import 'package:testing_app_with_mvvm/core/theme/spacing.dart';
import 'package:testing_app_with_mvvm/core/utils/validation_utils.dart';
import 'package:testing_app_with_mvvm/core/widgets/custom_button.dart';
import 'package:testing_app_with_mvvm/core/widgets/custom_text_field.dart';
import 'package:testing_app_with_mvvm/core/widgets/snackbar.dart';
import 'package:testing_app_with_mvvm/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:testing_app_with_mvvm/features/auth/views/pages/login_page.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
              'Account created successfully! Please login.',
            );
            Go.route(
              context,
              const LoginPage(),
            );
          },
          error: (error, st) {
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
                      20.kH,
                      CustomTextField(
                        controller: _emailController,
                        validator: validateEmail,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        hintText: "Enter Email",
                        hintTextStyle: const TextStyle(
                          fontSize: 30,
                        ),
                        cursorTextStyle: const TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      20.kH,
                      CustomTextField(
                        controller: _passwordController,
                        validator: validatePassword,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        hintText: "Enter Password",
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
                          "Sign Up",
                          style: TextStyle(
                            color: themeblackcolor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await ref
                                .read(authViewModelProvider.notifier)
                                .signUpUser(
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
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
