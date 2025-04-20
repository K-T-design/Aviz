import 'package:aviz/core/navigation/routes/app_routes.dart';
import 'package:aviz/core/theme/app_colors.dart';
import 'package:aviz/core/widgets/main_button.dart';
import 'package:aviz/ui/intro/landing/bloc/intro_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class IntroPage extends HookWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    useEffect(() {
      context.read<IntroBloc>().add(IntroPageSeen());
      return null;
    }, []);

    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: size.height * 0.45,
                  child: Image.asset(
                    'assets/images/signup_logo.png',
                    scale: 0.9,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "اینجا محل",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Image.asset('assets/images/aviz_txt_logo.png'),
                    const SizedBox(width: 8),
                    const Text(
                      "آگهی شماست",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: size.height * 0.03)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * .05),
                  child: const Text(
                    "در آویز ملک خود را برای فروش،اجاره و رهن آگهی کنید و یا اگر دنبال ملک با مشخصات دلخواه خود هستید آویز ها را ببینید",
                    style: TextStyle(
                      wordSpacing: 0,
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    maxLines: 3,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * .06,
                    horizontal: size.width * .05,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: MainButton(
                              text: 'ثبت نام',
                              onPressed: () {
                                Navigator.pushNamed(context, AppRoutes.signup);
                              },
                            ), // SizedBox(
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: MainButton(
                              text: 'ورود',
                              onPressed: () {
                                Navigator.pushNamed(context, AppRoutes.login);
                              },
                              height: size.height * .055,
                              backgroundColor: Colors.white,
                              foregroundColor: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
