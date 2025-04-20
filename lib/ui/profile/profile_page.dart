import 'package:aviz/core/blocs/auth_bloc/auth_bloc.dart';
import 'package:aviz/core/blocs/logout_bloc/logout_bloc.dart';
import 'package:aviz/core/constants/texts/app_texts.dart';
import 'package:aviz/core/navigation/routes/app_routes.dart';
import 'package:aviz/core/theme/app_sizes.dart';
import 'package:aviz/core/widgets/main_button.dart';
import 'package:aviz/core/widgets/popup/show_app_popup.dart';
import 'package:aviz/core/widgets/snack_bar/app_snack_bar.dart';
import 'package:aviz/ui/profile/widgets/profile_section_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileView();
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: BlocListener<LogoutBloc, LogoutState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.login,
              (route) => false,
            );
          }
        },
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: SvgPicture.asset('assets/icons/my-aviz.svg'),
                centerTitle: true,
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.pageHorizontal),
                  child: Row(
                    spacing: 8,
                    children: [
                      SvgPicture.asset('assets/icons/profile.svg'),
                      const Text(
                        'حساب کاربری',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final authState = (state as Authenticated);

                    return AspectRatio(
                      aspectRatio: 343 / 95,
                      child: Container(
                        width: size.width,
                        margin: const EdgeInsets.symmetric(
                            horizontal: AppSizes.pageHorizontal),
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSizes.pageHorizontal,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.3,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 64,
                              height: 64,
                              child: Image.asset(
                                'assets/icons/user.png',
                                fit: BoxFit.cover,
                              ),
                              // NetImage(
                              //   imageUrl:
                              //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJwCF4mWxY0aREKg1Ja0cZo7Qf7uFm-ikbbw&s',
                              //   radius: 10,
                              // ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 16,
                              children: [
                                Text(authState.user.fullName),
                                Row(
                                  spacing: 8,
                                  children: [
                                    Text(
                                      authState.user.phoneNumber ?? '',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    MainButton(
                                      text:
                                          authState.user.phoneConfirmed ?? false
                                              ? 'تایید شده'
                                              : 'تایید نشده',
                                      textSize: 13,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      height: size.height * .04,
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset('assets/icons/edit.svg'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 50)),
              SliverToBoxAdapter(
                child: ProfileSectionItem(
                  text: 'آگهی های من',
                  iconName: 'note',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.userPosts);
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: ProfileSectionItem(
                  text: 'پرداخت های من',
                  iconName: 'card',
                  onTap: () {},
                ),
              ),
              SliverToBoxAdapter(
                // TODO: implement feature
                child: Visibility(
                  visible: false,
                  child: ProfileSectionItem(
                    text: 'بازدید های اخیر',
                    iconName: 'eye',
                    onTap: () {},
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: ProfileSectionItem(
                  text: 'ذخیره شده ها',
                  iconName: 'save',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.favoritePosts);
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: ProfileSectionItem(
                  text: 'تنظیمات',
                  iconName: 'setting',
                  onTap: () {},
                ),
              ),
              SliverToBoxAdapter(
                child: ProfileSectionItem(
                  text: 'پشتیبانی و قوانین',
                  iconName: 'message-question',
                  onTap: () {
                    showAppPopup(
                      context,
                      title: 'قوانین',
                      content: const Text(AppTexts.rules),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: ProfileSectionItem(
                  text: 'درباره آویز',
                  iconName: 'info-circle',
                  onTap: () {
                    showAppPopup(
                      context,
                      title: 'درباره آویز',
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            AppTexts.about,
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: IconButton(
                              iconSize: 40,
                              tooltip: 'مشاهده در گیت‌هاب',
                              icon: SvgPicture.asset(
                                'assets/icons/github-mark.svg',
                                width: 40,
                                height: 40,
                              ),
                              onPressed: () async {
                                final uri = Uri.parse(
                                    'https://github.com/Hiwa-Shaloudegi');
                                if (!await launchUrl(uri)) {
                                  AppSnackBar.showError(
                                      'نمی‌توان لینک را باز کرد.');
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: ProfileSectionItem(
                  text: 'خروج',
                  iconName: 'logout',
                  onTap: () {
                    context.read<LogoutBloc>().add(LogoutEvent());
                  },
                ),
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
