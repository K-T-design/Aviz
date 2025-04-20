import 'package:aviz/ui/add_post/widgets/category_view.dart';
import 'package:aviz/ui/add_post/widgets/fill_post_info_view.dart';
import 'package:aviz/ui/add_post/widgets/main_post_info_view.dart';
import 'package:aviz/ui/add_post/widgets/set_map_info_view.dart';
import 'package:aviz/ui/add_post/widgets/sub_category_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../bloc/add_post_bloc.dart';

class AddPostFormsPageView extends HookWidget {
  const AddPostFormsPageView({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (value) {
        context.read<AddPostBloc>().add(ChangeStepEvent(value + 1));
      },
      scrollDirection: Axis.horizontal,
      children: [
        CategoryView(pageController: pageController),
        SubCategoryView(pageController: pageController),
        FillPostInfoView(pageController: pageController),
        SetMapInfoView(pageController: pageController),
        MainPostInfoView(pageController: pageController),
      ],
    );
  }
}
