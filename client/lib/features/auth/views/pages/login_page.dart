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
import 'package:testing_app_with_mvvm/features/home/views/pages/home_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
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
            Go.route(
              context,
              const HomePage(),
            );
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
                            "Login",
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
                                  .loginUser(
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
          ),
    );
  }
}
