import 'package:aviz/core/theme/app_colors.dart';
import 'package:aviz/core/theme/app_sizes.dart';
import 'package:aviz/core/widgets/loading_in_button.dart';
import 'package:aviz/core/widgets/try_again_widget.dart';
import 'package:aviz/ui/add_post/bloc/add_post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPostBloc, AddPostState>(
      builder: (context, state) {
        final getCategoriesStatus = state.getInitialCategoriesStatus;

        if (getCategoriesStatus is GetInitialCategoriesLoading) {
          return const Center(
            child: LoadingInButton(
              color: AppColors.primary,
            ),
          );
        } else if (getCategoriesStatus is GetInitialCategoriesError) {
          return TryAgainWidget(
            onPressed: () {
              context.read<AddPostBloc>().add(GetInitialCategoriesEvent());
            },
          );
        } else if (getCategoriesStatus is GetInitialCategoriesSuccess) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSizes.pageHorizontal),
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: getCategoriesStatus.categories.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final category = getCategoriesStatus.categories[index];

                return ListTile(
                  onTap: () {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                    context
                        .read<AddPostBloc>()
                        .add(SelectCategoryEvent(category: category));
                    context
                        .read<AddPostBloc>()
                        .add(GetSubCategoriesEvent(parentId: category.id!));
                  },
                  title: Text(
                    category.title!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: SvgPicture.asset('assets/icons/arrow-left-red.svg'),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.pageHorizontal),
                  visualDensity: VisualDensity.compact,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                );
              },
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
