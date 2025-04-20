import 'package:aviz/core/services/di/di.dart';
import 'package:aviz/core/theme/app_colors.dart';
import 'package:aviz/ui/add_post/bloc/add_post_bloc.dart';
import 'package:aviz/ui/add_post/widgets/add_post_forms_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

class AddPostPage extends StatelessWidget {
  const AddPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPostBloc(di())..add(GetInitialCategoriesEvent()),
      child: const AddPostView(),
    );
  }
}

class AddPostView extends HookWidget {
  const AddPostView({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: SvgPicture.asset('assets/icons/aviz_txt_logo.svg'),
        actions: [
          IconButton(
            onPressed: () {
              pageController.jumpToPage(0);
              context.read<AddPostBloc>().add(SetInitialStateEvent());
            },
            icon: SvgPicture.asset('assets/icons/close-square.svg'),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            pageController.previousPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          },
          icon: SvgPicture.asset('assets/icons/arrow-right.svg'),
        ),
      ),
      body: BlocBuilder<AddPostBloc, AddPostState>(
        builder: (context, state) {
          return Column(
            children: [
              LinearPercentIndicator(
                isRTL: true,
                percent: (state.step) / 5,
                padding: EdgeInsets.zero,
                backgroundColor: Colors.transparent,
                progressColor: AppColors.primary,
                animation: true,
                animateToInitialPercent: true,
                animateFromLastPercent: true,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: AddPostFormsPageView(pageController: pageController),
              ),
            ],
          );
        },
      ),
    );
  }
}
