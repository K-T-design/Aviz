import 'package:aviz/core/blocs/add_favorite_bloc/toggle_favorite_bloc.dart';
import 'package:aviz/core/navigation/args/post_detail_page_args.dart';
import 'package:aviz/core/theme/app_colors.dart';
import 'package:aviz/core/theme/app_sizes.dart';
import 'package:aviz/core/utils/hooks/use_page_args.dart';
import 'package:aviz/core/widgets/snack_bar/app_snack_bar.dart';
import 'package:aviz/core/widgets/main_button.dart';
import 'package:aviz/core/widgets/net_image.dart';
import 'package:aviz/ui/post_detail/widgets/attribute_tab_view.dart';
import 'package:aviz/ui/post_detail/widgets/desc_tab_view.dart';
import 'package:aviz/ui/post_detail/widgets/facilities_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';

import 'widgets/price_tab_view.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PostDetailView();
  }
}

class PostDetailView extends HookWidget {
  const PostDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final args = usePageArgs<PostDetailPageArgs>();
    final tabController =
        useTabController(initialLength: 4, animationDuration: Duration.zero);

    useEffect(() {
      context.read<ToggleFavoriteBloc>().add(SetInitialFavoriteEvent());
      return null;
    }, []);

    return Scaffold(
      body: BlocListener<ToggleFavoriteBloc, ToggleFavoriteState>(
        listener: (context, state) {
          final toggleFavoriteStatus = state.toggleFavoriteStatus;

          if (toggleFavoriteStatus is ToggleFavoriteSuccess) {
            if (toggleFavoriteStatus.isFavorite) {
              AppSnackBar.showSuccess('آویز ذخیره شد');
            } else {
              AppSnackBar.showSuccess('از ذخیره‌ها پاک شد');
            }
          } else if (toggleFavoriteStatus is ToggleFavoriteError) {
            AppSnackBar.showError('خطایی در ذخیره آویز رخ داد');
          }
        },
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  pinned: true,
                  surfaceTintColor: Colors.white,
                  backgroundColor: Colors.white,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: SvgPicture.asset('assets/icons/arrow-right.svg'),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset('assets/icons/information.svg'),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset('assets/icons/share.svg'),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<ToggleFavoriteBloc>().add(
                            TogglePostFavoriteEvent(postId: args.post.id!));
                      },
                      icon:
                          BlocBuilder<ToggleFavoriteBloc, ToggleFavoriteState>(
                        builder: (context, state) {
                          final toggleFavoriteStatus =
                              state.toggleFavoriteStatus;

                          Logger()
                              .w(toggleFavoriteStatus is ToggleFavoriteSuccess);

                          if (toggleFavoriteStatus is ToggleFavoriteSuccess) {
                            Logger().w(
                                "isFaved: ${toggleFavoriteStatus.isFavorite}");
                          }

                          return SvgPicture.asset(
                            'assets/icons/archive.svg',
                            colorFilter: ColorFilter.mode(
                              toggleFavoriteStatus is ToggleFavoriteSuccess &&
                                      toggleFavoriteStatus.isFavorite
                                  ? AppColors.primary
                                  : Colors.black,
                              BlendMode.srcIn,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 32)),
                SliverToBoxAdapter(
                  child: AspectRatio(
                    aspectRatio: 343 / 160,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: NetImage(
                        imageUrl: args.post.imageUrl,
                        radius: 12,
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 32)),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.pageHorizontal),
                    child: Text(
                      args.post.title ?? '',
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 50)),
                SliverToBoxAdapter(
                  child: Container(
                    width: size.width,
                    margin: const EdgeInsets.symmetric(
                        horizontal: AppSizes.pageHorizontal),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.3,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'هشدارهای قبل از معامله!',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        RotatedBox(
                          quarterTurns: 2,
                          child: SvgPicture.asset(
                            'assets/icons/arrow-right.svg',
                            colorFilter: const ColorFilter.mode(
                              Colors.grey,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 32)),
                // Tab Bars
                PinnedHeaderSliver(
                  child: Container(
                    color: Colors.white,
                    child: TabBar(
                      controller: tabController,
                      tabAlignment: TabAlignment.start,
                      labelColor: Colors.white,
                      unselectedLabelColor: AppColors.primary,
                      indicatorColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.tab,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      indicatorPadding: const EdgeInsets.symmetric(vertical: 5),
                      dividerHeight: 0,
                      dividerColor: Colors.transparent,
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      indicator: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      isScrollable: true,
                      tabs: const [
                        Tab(text: 'مشخصات'),
                        Tab(text: 'قیمت'),
                        Tab(text: 'ویژگی ها و امکانات'),
                        Tab(text: 'توضیحات'),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: tabController,
              children: [
                AttributeTabView(args: args),
                PriceTabView(args: args),
                FacilitiesTabView(args: args),
                DescTabView(args: args),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        margin: const EdgeInsets.only(
          left: AppSizes.pageHorizontal,
          right: AppSizes.pageHorizontal,
          bottom: AppSizes.pageHorizontal,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 16,
          children: [
            args.post.chatAvailable ?? false
                ? Expanded(
                    child: MainButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 8,
                        children: [
                          SvgPicture.asset('assets/icons/message.svg'),
                          const Text(
                            'گفتگو',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  )
                : const SizedBox.shrink(),
            args.post.callAvailable ?? false
                ? Expanded(
                    child: MainButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 8,
                        children: [
                          SvgPicture.asset('assets/icons/call.svg'),
                          const Text(
                            'اطلاعات تماس',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
