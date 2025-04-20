import 'package:aviz/core/navigation/args/post_detail_page_args.dart';
import 'package:aviz/core/navigation/routes/app_routes.dart';
import 'package:aviz/core/theme/app_sizes.dart';
import 'package:aviz/core/utils/extensions/price_extension.dart';
import 'package:aviz/core/utils/formatters/price_formatter.dart';
import 'package:aviz/core/utils/validators/validators.dart';
import 'package:aviz/core/widgets/snack_bar/app_snack_bar.dart';
import 'package:aviz/core/widgets/app_text_field.dart';
import 'package:aviz/core/widgets/main_button.dart';
import 'package:aviz/core/widgets/title_field.dart';
import 'package:aviz/ui/add_post/bloc/add_post_bloc.dart';
import 'package:aviz/ui/add_post/widgets/attribute_switch.dart';
import 'package:aviz/ui/main/bloc/main_bloc.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPostInfoView extends HookWidget {
  const MainPostInfoView({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final titleController = useTextEditingController();
    final descController = useTextEditingController();
    final priceController = useTextEditingController();

    useEffect(() {
      AppSnackBar.init(context);
      return null;
    }, []);

    useEffect(() {
      priceController.addListener(() => PriceFormatter.format(priceController));
      return null;
    }, [priceController]);

    return BlocListener<AddPostBloc, AddPostState>(
      listener: (context, state) {
        final sendPostDataStatus = state.sendPostDataStatus;

        if (sendPostDataStatus is SendPostDataSuccess) {
          context.read<AddPostBloc>().add(SetInitialStateEvent());

          Navigator.pushNamed(
            context,
            AppRoutes.postDetail,
            arguments: PostDetailPageArgs(
              post: sendPostDataStatus.post,
            ),
          );
          context.read<MainBloc>().add(ChangeNavItem(navItem: NavItem.home));
          pageController.jumpToPage(0);
          AppSnackBar.showSuccess('آویز شما با موفقت ثبت شد');
        } else if (sendPostDataStatus is SendPostDataError) {
          AppSnackBar.showError('اتصال اینترنت خود را بررسی کنید');
        }
      },
      child: Form(
        key: formKey,
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 8)),
            const SliverToBoxAdapter(
              child: TitleField(
                text: 'تصویر آویز',
                iconSvgPath: 'assets/icons/camera.svg',
                enablePadding: true,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.pageHorizontal),
                child: AspectRatio(
                  aspectRatio: 343 / 160,
                  child: DottedBorder(
                    color: Colors.grey.shade300,
                    strokeWidth: 1,
                    radius: const Radius.circular(100),
                    dashPattern: const [12, 3],
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Column(
                          spacing: 12,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'لطفا تصویر آویز خود را بارگذاری کنید',
                              style: TextStyle(color: Colors.grey),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                spacing: 8,
                                children: [
                                  SvgPicture.asset(
                                      'assets/icons/document-upload.svg'),
                                  const Text('انتخاب تصویر'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
            const SliverToBoxAdapter(
              child: TitleField(
                text: 'عنوان آویز',
                iconSvgPath: 'assets/icons/edit-2.svg',
                enablePadding: true,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.pageHorizontal),
                child: AppTextField(
                  textController: titleController,
                  hintText: 'عنوان آویز را انتخاب کنید',
                  textInputAction: TextInputAction.done,
                  validator: (value) => Validators.notEmpty(value),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
            const SliverToBoxAdapter(
              child: TitleField(
                text: 'توضیحات',
                iconSvgPath: 'assets/icons/clipboard-text.svg',
                enablePadding: true,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.pageHorizontal),
                child: AppTextField(
                  textController: descController,
                  hintText: 'توضیحات آویز را انتخاب کنید',
                  textInputAction: TextInputAction.done,
                  maxLines: 3,
                  validator: (value) => Validators.notEmpty(value),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
            const SliverToBoxAdapter(
              child: TitleField(
                text: 'قیمت',
                iconSvgPath: 'assets/icons/clipboard.svg',
                enablePadding: true,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.pageHorizontal),
                child: AppTextField(
                  textController: priceController,
                  hintText: 'تومان',
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  validator: (value) => Validators.notEmpty(value),
                  // inputFormatters: PriceFormatter.inputFormatters,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 50)),
            SliverToBoxAdapter(
              child: BlocBuilder<AddPostBloc, AddPostState>(
                builder: (context, state) {
                  final post = state.post;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.pageHorizontal),
                    child: Column(
                      spacing: 16,
                      children: [
                        AttributeSwitch(
                          title: 'فعال کردن گفتگو',
                          isOn: post.chatAvailable!,
                          onChanged: (value) => context.read<AddPostBloc>().add(
                                ToggleChatAvailableEvent(value),
                              ),
                        ),
                        AttributeSwitch(
                          title: 'فعال کردن تماس',
                          isOn: post.callAvailable!,
                          onChanged: (value) => context.read<AddPostBloc>().add(
                                ToggleCallAvailableEvent(value),
                              ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.pageHorizontal),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Builder(builder: (context) {
                      final sendPostDataStatus =
                          context.watch<AddPostBloc>().state.sendPostDataStatus;

                      return MainButton(
                        text: 'ثبت آگهی',
                        isLoading: sendPostDataStatus is SendPostDataLoading,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AddPostBloc>().add(
                                  SendPostDataEvent(
                                    title: titleController.text,
                                    desc: descController.text,
                                    price: priceController.text.fromPrice(),
                                  ),
                                );
                          }
                        },
                      );
                    }),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
