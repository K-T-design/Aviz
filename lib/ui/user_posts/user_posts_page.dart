import 'package:aviz/core/navigation/args/post_detail_page_args.dart';
import 'package:aviz/core/navigation/routes/app_routes.dart';
import 'package:aviz/core/services/di/di.dart';
import 'package:aviz/core/theme/app_colors.dart';
import 'package:aviz/domain/models/post.dart';
import 'package:aviz/ui/home/widgets/vertical_info_post_item.dart';
import 'package:aviz/ui/user_posts/bloc/user_posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../core/theme/app_sizes.dart' show AppSizes;

class UserPostsPage extends StatelessWidget {
  const UserPostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserPostsBloc(di())..add(GetUserPostsEvent()),
      child: const UserPostView(),
    );
  }
}

class UserPostView extends StatelessWidget {
  const UserPostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () async {
            context.read<UserPostsBloc>().add(GetUserPostsEvent());
          },
          child: CustomScrollView(
            slivers: [
              const SliverAppBar(
                pinned: true,
                elevation: 0,
                centerTitle: true,
                surfaceTintColor: Colors.white,
                title: Text(
                  'آگهی‌های من',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 18,
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              BlocBuilder<UserPostsBloc, UserPostsState>(
                builder: (context, state) {
                  final getUserPostsStatus = state.getUserPostsStatus;

                  if (getUserPostsStatus is GetUserPostsSuccess) {
                    if (getUserPostsStatus.userPosts.isEmpty) {
                      return const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Text(
                            'موردی وجود ندارد',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }
                  }

                  return SliverSkeletonizer(
                    enabled: getUserPostsStatus is! GetUserPostsSuccess,
                    child: SliverList.separated(
                      itemCount: getUserPostsStatus is GetUserPostsSuccess
                          ? getUserPostsStatus.userPosts.length
                          : 5,
                      itemBuilder: (context, index) {
                        final Post post;

                        if (getUserPostsStatus is GetUserPostsSuccess) {
                          post = getUserPostsStatus.userPosts[index];
                        } else {
                          post = Post(
                            title: BoneMock.title,
                            description: BoneMock.chars(40, '*'),
                          );
                        }
                        return VerticalInfoPostItem(
                          post: post,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.postDetail,
                              arguments: PostDetailPageArgs(post: post),
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                    ),
                  );
                },
              ),
              const SliverToBoxAdapter(
                  child: SizedBox(height: AppSizes.pageEndSpace)),
            ],
          ),
        ),
      ),
    );
  }
}
