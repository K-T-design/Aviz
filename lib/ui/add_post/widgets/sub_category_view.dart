import 'package:aviz/core/theme/app_colors.dart';
import 'package:aviz/core/theme/app_sizes.dart';
import 'package:aviz/core/widgets/loading_in_button.dart';
import 'package:aviz/core/widgets/try_again_widget.dart';
import 'package:aviz/ui/add_post/bloc/add_post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class SubCategoryView extends StatelessWidget {
  const SubCategoryView({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPostBloc, AddPostState>(
      builder: (context, state) {
        final getSubCategoriesStatus = state.getSubCategoriesStatus;

        if (getSubCategoriesStatus is GetSubCategoriesLoading) {
          return const Center(
            child: LoadingInButton(
              color: AppColors.primary,
            ),
          );
        } else if (getSubCategoriesStatus is GetSubCategoriesError) {
          return TryAgainWidget(
            onPressed: () {
              final parentId = state.selectedCategory?.id;
              Logger().w(parentId);
              context
                  .read<AddPostBloc>()
                  .add(GetSubCategoriesEvent(parentId: parentId!));
            },
          );
        } else if (getSubCategoriesStatus is GetSubCategoriesSuccess) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.pageHorizontal),
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: getSubCategoriesStatus.subCategories.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final category =
                          getSubCategoriesStatus.subCategories[index];

                      return ListTile(
                        onTap: () {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                          context
                              .read<AddPostBloc>()
                              .add(SelectCategoryEvent(category: category));
                        },
                        title: Text(
                          category.title!,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                ),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
