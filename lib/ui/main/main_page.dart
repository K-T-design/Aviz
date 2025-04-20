import 'package:aviz/core/theme/app_colors.dart';
import 'package:aviz/core/utils/extensions/nav_item_index_extension.dart';
import 'package:aviz/ui/add_post/add_post_page.dart';
import 'package:aviz/ui/favorite/favorite_page.dart';
import 'package:aviz/ui/home/home_page.dart';
import 'package:aviz/ui/main/bloc/main_bloc.dart';
import 'package:aviz/ui/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainBloc(),
      child: const MainView(),
    );
  }
}

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final pages = [
    const HomePage(),
    const FavoritePage(),
    const AddPostPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: IndexedStack(
            index: state.navItem.index,
            children: pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.navItem.index,
            onTap: (index) {
              Logger().e(index);
              context.read<MainBloc>().add(
                    ChangeNavItem(navItem: index.navItem),
                  );
            },
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.hint,
            backgroundColor: Colors.white,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/aviz_icon.png',
                  color: state.navItem.index != 0 ? AppColors.hint : null,
                ),
                label: 'آویز آگهی ها',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/archive.svg',
                  colorFilter: ColorFilter.mode(
                    state.navItem.index == 1
                        ? AppColors.primary
                        : AppColors.hint,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'ذخیره شده ها',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/add-circle.png',
                  color: state.navItem.index == 2 ? AppColors.primary : null,
                ),
                label: 'افزودن آویز',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/profile-circle.png',
                  color: state.navItem.index == 3 ? AppColors.primary : null,
                ),
                label: 'آویز من',
              ),
            ],
          ),
        );
      },
    );
  }
}
