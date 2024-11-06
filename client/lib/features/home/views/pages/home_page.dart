import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testing_app_with_mvvm/core/helpers/helpers.dart';
import 'package:testing_app_with_mvvm/core/providers/current_user_notifier.dart';
import 'package:testing_app_with_mvvm/core/route_structure/go_navigator.dart';
import 'package:testing_app_with_mvvm/core/theme/colors.dart';
import 'package:testing_app_with_mvvm/core/theme/font_structures.dart';
import 'package:testing_app_with_mvvm/core/theme/spacing.dart';
import 'package:testing_app_with_mvvm/core/widgets/custom_cached_network_image.dart';
import 'package:testing_app_with_mvvm/core/widgets/snackbar.dart';
import 'package:testing_app_with_mvvm/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:testing_app_with_mvvm/features/auth/views/pages/edit_profile_page.dart';
import 'package:testing_app_with_mvvm/features/auth/views/pages/login_page.dart';
import 'package:testing_app_with_mvvm/features/post/viewmodel/post_viewmodel.dart';
import 'package:testing_app_with_mvvm/features/post/views/pages/add_post_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserNotifierProvider)!;
    ref.listen(
      authViewModelProvider,
      (_, next) {
        next?.when(
          data: (data) {
            if (data.token.isEmpty) {
              Go.route(
                context,
                const LoginPage(),
              );
            }
          },
          error: (error, stackTrace) {
            showSnackBar(context, error.toString());
          },
          loading: () {},
        );
      },
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(user.name),
        actions: [
          GestureDetector(
            onTap: () {
              Go.route(
                context,
                const AddPostPage(),
              );
            },
            child: const CircleAvatar(
              child: Icon(Icons.add),
            ),
          ),
          15.kW,
          GestureDetector(
            onTap: () {
              Go.route(
                context,
                const EditProfilePage(),
              );
            },
            child: const CircleAvatar(
              child: Icon(Icons.edit),
            ),
          ),
          15.kW,
          GestureDetector(
            onTap: () {
              ref.read(authViewModelProvider.notifier).logout();
              Go.route(
                context,
                const LoginPage(),
              );
            },
            child: const CircleAvatar(
              child: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: ref.watch(fetchPostsProvider).when(
            data: (posts) {
              return ListView.separated(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return ref.watch(getUserByIdProvider(post.uid)).when(
                        data: (userData) => ListTile(
                          titleAlignment: ListTileTitleAlignment.top,
                          leading: CustomCachedNetworkImage(
                            imageUrl: userData.profileImage,
                            imageBuilder: (context, imageProvider) {
                              return CircleAvatar(
                                backgroundImage: imageProvider,
                              );
                            },
                            animChild: const CircleAvatar(
                              backgroundColor: themegreycolor,
                            ),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userData.name,
                                style: const TextStyle(
                                  fontSize: mediumfontsize1,
                                  fontWeight: boldfontweight,
                                ),
                              ),
                              Text(post.title),
                              CustomCachedNetworkImage(
                                imageUrl: post.image,
                                imageBuilder: (context, imageProvider) {
                                  return Image(
                                    image: imageProvider,
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  );
                                },
                                animChild: Container(
                                  height: 200,
                                  width: double.infinity,
                                  color: themegreycolor,
                                ),
                              ),
                              5.kH,
                              Text(post.description),
                            ],
                          ),
                          subtitle: Text(
                            Helpers.timeAgo(
                              post.createdAt.millisecondsSinceEpoch,
                            ),
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        error: (error, st) {
                          return Center(
                            child: Text(
                              error.toString(),
                            ),
                          );
                        },
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                },
                separatorBuilder: (context, separator) {
                  return 15.kH;
                },
              );
            },
            error: (error, st) {
              return Center(
                child: Text(
                  error.toString(),
                ),
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),

      // Padding(
      //   padding: const EdgeInsets.all(20.0),
      //   child: Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Text(user.name),
      //         Text(user.token),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
