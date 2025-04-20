import 'package:aviz/core/navigation/args/post_detail_page_args.dart';
import 'package:aviz/core/navigation/routes/app_routes.dart';
import 'package:aviz/core/services/di/di.dart';
import 'package:aviz/core/theme/app_colors.dart';
import 'package:aviz/core/theme/app_sizes.dart';
import 'package:aviz/domain/models/post.dart';
import 'package:aviz/ui/all_posts/bloc/all_posts_bloc.dart';
import 'package:aviz/ui/home/widgets/vertical_info_post_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AllPostsPage extends StatelessWidget {
  const AllPostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllPostsBloc(di())..add(GetAllPostsEvent()),
      child: const AllPostsView(),
    );
  }
}

class AllPostsView extends StatelessWidget {
  const AllPostsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              pinned: true,
              centerTitle: true,
              elevation: 0,
              surfaceTintColor: Colors.white,
              title: Text(
                'همه آویز‌ها',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 18,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            BlocBuilder<AllPostsBloc, AllPostsState>(
              builder: (context, state) {
                final getAllPostsStatus = state.getAllPostsStatus;

                return SliverSkeletonizer(
                  enabled: getAllPostsStatus is! GetAllPostsSuccess,
                  child: SliverList.separated(
                    itemCount: getAllPostsStatus is GetAllPostsSuccess
                        ? getAllPostsStatus.allPosts.length
                        : 5,
                    itemBuilder: (context, index) {
                      final Post post;

                      if (getAllPostsStatus is GetAllPostsSuccess) {
                        post = getAllPostsStatus.allPosts[index];
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
    );
  }
}
