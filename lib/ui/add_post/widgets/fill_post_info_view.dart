import 'package:aviz/core/theme/app_sizes.dart';
import 'package:aviz/core/utils/validators/validators.dart';
import 'package:aviz/core/widgets/form_field_item.dart';
import 'package:aviz/core/widgets/form_text_field.dart';
import 'package:aviz/core/widgets/loading_in_button.dart';
import 'package:aviz/core/widgets/main_button.dart';
import 'package:aviz/core/widgets/show_year_picker.dart';
import 'package:aviz/core/widgets/title_field.dart';
import 'package:aviz/ui/add_post/bloc/add_post_bloc.dart';
import 'package:aviz/ui/add_post/widgets/attribute_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FillPostInfoView extends HookWidget {
  const FillPostInfoView({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());

    final addressController = useTextEditingController();
    final areaController = useTextEditingController();
    final roomController = useTextEditingController();
    final floorController = useTextEditingController();
    final builtYearController = useTextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.pageHorizontal),
      child: Form(
        key: formKey,
        child: CustomScrollView(
          slivers: [
            // TODO: fix TitleField everywhere
            const SliverToBoxAdapter(
              child: TitleField(
                text: 'انتخاب دسته بندی',
                iconSvgPath: 'assets/icons/category-2.svg',
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
            SliverToBoxAdapter(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 32,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8,
                      children: [
                        const Text(
                          'دسته بندی',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        BlocBuilder<AddPostBloc, AddPostState>(
                          builder: (context, state) {
                            final getSubCategoriesStatus =
                                state.getSubCategoriesStatus;

                            if (getSubCategoriesStatus
                                is GetSubCategoriesSuccess) {
                              return DropdownMenu(
                                width: 170,
                                inputDecorationTheme: InputDecorationTheme(
                                  isDense: true,
                                  contentPadding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  constraints: BoxConstraints.tight(
                                    const Size.fromHeight(48),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                ),
                                hintText:
                                    state.selectedCategory?.title! ?? 'خطا',
                                textStyle: const TextStyle(
                                  fontSize: 13,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onSelected: (value) {
                                  context.read<AddPostBloc>().add(
                                      SelectCategoryEvent(category: value!));
                                },
                                selectedTrailingIcon: RotatedBox(
                                  quarterTurns: 2,
                                  child: Transform.scale(
                                    scale: 0.8,
                                    child: SvgPicture.asset(
                                        'assets/icons/arrow-down.svg'),
                                  ),
                                ),
                                trailingIcon: Transform.scale(
                                  scale: 0.8,
                                  child: SvgPicture.asset(
                                      'assets/icons/arrow-down.svg'),
                                ),
                                menuStyle: MenuStyle(
                                  visualDensity: VisualDensity.standard,
                                  backgroundColor: WidgetStateProperty.all(
                                      Colors.grey.shade50), // Popup background

                                  padding:
                                      WidgetStateProperty.all(EdgeInsets.zero),
                                  elevation: WidgetStateProperty.all(0),
                                ),
                                dropdownMenuEntries: [
                                  for (var cat
                                      in getSubCategoriesStatus.subCategories)
                                    DropdownMenuEntry(
                                      value: cat,
                                      label: cat.title!,
                                    ),
                                ],
                              );
                            } else {
                              return const LoadingInButton();
                            }
                          },
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8,
                      children: [
                        const Text(
                          'محدوده ملک',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        FormTextField(
                          controller: addressController,
                          validator: (value) => Validators.notEmpty(value),
                          hintText: 'خیابان ستارخان',
                          isNumField: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(
              child: Divider(
                thickness: 0,
                height: 50,
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                spacing: 8,
                children: [
                  SvgPicture.asset('assets/icons/clipboard.svg'),
                  const Text(
                    'ویژگی ها',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 32,
                children: [
                  Expanded(
                    child: FormFieldItem(
                      title: 'متراژ',
                      textField: FormTextField(
                        controller: areaController,
                        hintText: '80',
                        validator: (value) => Validators.notEmpty(value),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FormFieldItem(
                      title: 'تعداد اتاق',
                      textField: FormTextField(
                        controller: roomController,
                        hintText: '2',
                        validator: (value) => Validators.notEmpty(value),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 10)),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 32,
                children: [
                  Expanded(
                    child: FormFieldItem(
                      title: 'طبقه',
                      textField: FormTextField(
                        controller: floorController,
                        hintText: '3',
                        validator: (value) => Validators.notEmpty(value),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FormFieldItem(
                      title: 'سال ساخت',
                      textField: FormTextField(
                        controller: builtYearController,
                        validator: (value) => Validators.notEmpty(value),
                        hintText: '1403',
                        readOnly: true,
                        onTap: () {
                          showYearPicker(context, builtYearController);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(
              child: Divider(
                thickness: 0,
                height: 50,
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                spacing: 8,
                children: [
                  SvgPicture.asset('assets/icons/magicpen.svg'),
                  const Text(
                    'امکانات',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
            SliverToBoxAdapter(
              child: BlocBuilder<AddPostBloc, AddPostState>(
                builder: (context, state) {
                  final post = state.post;
                  return Column(
                    spacing: 16,
                    children: [
                      AttributeSwitch(
                        title: 'آسانسور',
                        isOn: post.hasElevator!,
                        onChanged: (value) => context.read<AddPostBloc>().add(
                              ToggleHasElevatorEvent(value),
                            ),
                      ),
                      AttributeSwitch(
                        title: 'پارکینگ',
                        isOn: post.hasParking!,
                        onChanged: (value) => context.read<AddPostBloc>().add(
                              ToggleHasParkingEvent(value),
                            ),
                      ),
                      AttributeSwitch(
                        title: 'انباری',
                        isOn: post.hasBasement!,
                        onChanged: (value) => context.read<AddPostBloc>().add(
                              ToggleHasBasementEvent(value),
                            ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  MainButton(
                    text: 'بعدی',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AddPostBloc>().add(FillPostInfoEvent(
                              area: double.parse(areaController.text),
                              numOfRooms: double.parse(roomController.text),
                              floor: double.parse(floorController.text),
                              builtYear: int.parse(builtYearController.text),
                              address: addressController.text,
                            ));
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
