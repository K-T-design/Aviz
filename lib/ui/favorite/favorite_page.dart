import 'package:aviz/core/navigation/args/post_detail_page_args.dart';
import 'package:aviz/core/navigation/routes/app_routes.dart';
import 'package:aviz/core/services/di/di.dart';
import 'package:aviz/core/theme/app_colors.dart';
import 'package:aviz/core/theme/app_sizes.dart';
import 'package:aviz/domain/models/post.dart';
import 'package:aviz/ui/favorite/bloc/favorite_bloc.dart';
import 'package:aviz/ui/home/widgets/vertical_info_post_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteBloc(di())
        ..add(WatchFavoritePosts())
        ..add(GetFavoritePostsEvent()),
      child: const FavoriteView(),
    );
  }
}

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () async {
            context.read<FavoriteBloc>().add(GetFavoritePostsEvent());
          },
          child: CustomScrollView(
            slivers: [
              const SliverAppBar(
                pinned: true,
                elevation: 0,
                centerTitle: true,
                surfaceTintColor: Colors.white,
                title: Text(
                  'ذخیره شده‌ها',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 18,
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              BlocBuilder<FavoriteBloc, FavoriteState>(
                builder: (context, state) {
                  final getFavoritePostsStatus = state.getFavoritePostsStatus;

                  if (getFavoritePostsStatus is GetFavoritePostsSuccess) {
                    if (getFavoritePostsStatus.favoritePosts.isEmpty) {
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
                    enabled: getFavoritePostsStatus is! GetFavoritePostsSuccess,
                    child: SliverList.separated(
                      itemCount:
                          getFavoritePostsStatus is GetFavoritePostsSuccess
                              ? getFavoritePostsStatus.favoritePosts.length
                              : 5,
                      itemBuilder: (context, index) {
                        final Post post;

                        if (getFavoritePostsStatus is GetFavoritePostsSuccess) {
                          post = getFavoritePostsStatus.favoritePosts[index];
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
