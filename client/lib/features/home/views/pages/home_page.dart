import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testing_app_with_mvvm/core/providers/current_user_notifier.dart';
import 'package:testing_app_with_mvvm/core/route_structure/go_navigator.dart';
import 'package:testing_app_with_mvvm/core/theme/font_structures.dart';
import 'package:testing_app_with_mvvm/core/theme/spacing.dart';
import 'package:testing_app_with_mvvm/features/auth/viewmodel/auth_viewmodel.dart';
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
                          leading:  CircleAvatar(
                            backgroundImage: NetworkImage(post.image),
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
                            ],
                          ),
                          subtitle: Text(post.description),
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
