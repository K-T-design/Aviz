import 'package:aviz/core/navigation/args/post_detail_page_args.dart';
import 'package:aviz/core/navigation/routes/app_routes.dart';
import 'package:aviz/core/services/di/di.dart';
import 'package:aviz/core/theme/app_colors.dart';
import 'package:aviz/core/widgets/snack_bar/app_snack_bar.dart';
import 'package:aviz/domain/models/post.dart';
import 'package:aviz/ui/home/bloc/home_bloc.dart';
import 'package:aviz/ui/home/widgets/info_post_item.dart';
import 'package:aviz/ui/home/widgets/vertical_info_post_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(di())..add(GetHomeDataEvent()),
      child: const HomeView(),
    );
  }
}

class HomeView extends HookWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    useEffect(() {
      AppSnackBar.init(context);
      return null;
    }, []);

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.99),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () async {
            context.read<HomeBloc>().add(GetHomeDataEvent(refresh: true));
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                snap: true,
                centerTitle: true,
                elevation: 0,
                shadowColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/aviz_icon.png',
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'آویز',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),

              // Hottest Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'آویزهای داغ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.allPosts);
                        },
                        child: const Text(
                          'مشاهده همه',
                          style: TextStyle(
                            color: AppColors.hint,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // Hottest List
              SliverToBoxAdapter(
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    final getHomeDataStatus = state.getHomeDataStatus;

                    return SizedBox(
                      height: size.height * 0.4,
                      child: Skeletonizer(
                        enabled: getHomeDataStatus is! GetHomeDataSuccess,
                        enableSwitchAnimation: true,
                        justifyMultiLineText: true,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: getHomeDataStatus is GetHomeDataSuccess
                              ? getHomeDataStatus.hottestPosts.length
                              : 5,
                          itemBuilder: (context, index) {
                            final Post post;

                            if (getHomeDataStatus is GetHomeDataSuccess) {
                              post = getHomeDataStatus.hottestPosts[index];
                            } else {
                              post = Post(
                                title: BoneMock.title,
                                description: BoneMock.chars(40, '*'),
                              );
                            }
                            return InfoPostItem(
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
                              const SizedBox(width: 16),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),

              // Latest Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'آویزهای اخیر',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.allPosts);
                        },
                        child: const Text(
                          'مشاهده همه',
                          style: TextStyle(
                            color: AppColors.hint,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // Latest List
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  final getHomeDataStatus = state.getHomeDataStatus;

                  return SliverSkeletonizer(
                    enabled: getHomeDataStatus is! GetHomeDataSuccess,
                    child: SliverList.separated(
                      itemCount: getHomeDataStatus is GetHomeDataSuccess
                          ? getHomeDataStatus.latestPosts.length
                          : 5,
                      itemBuilder: (context, index) {
                        final Post post;

                        if (getHomeDataStatus is GetHomeDataSuccess) {
                          post = getHomeDataStatus.latestPosts[index];
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

              const SliverToBoxAdapter(child: SizedBox(height: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
