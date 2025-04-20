import 'package:aviz/core/navigation/args/otp_page_args.dart';
import 'package:aviz/core/navigation/routes/app_routes.dart';
import 'package:aviz/core/services/di/di.dart';
import 'package:aviz/core/utils/validators/validators.dart';
import 'package:aviz/core/widgets/snack_bar/app_snack_bar.dart';
import 'package:aviz/core/widgets/app_text_field.dart';
import 'package:aviz/core/widgets/auth_prompt_text.dart';
import 'package:aviz/core/widgets/main_button.dart';
import 'package:aviz/ui/auth/signup/bloc/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(di()),
      child: const SignupView(),
    );
  }
}

class SignupView extends HookWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    final formKey = useMemoized(GlobalKey<FormState>.new);
    final nameController = useTextEditingController();
    final phoneController = useTextEditingController();

    useEffect(() {
      AppSnackBar.init(context);
      return null;
    }, []);

    return BlocListener<SignupBloc, SignupState>(
      listenWhen: (p, c) => p.signupStatus != c.signupStatus,
      listener: (context, state) {
        var signupStatus = state.signupStatus;

        if (signupStatus is SignupError) {
          AppSnackBar.showError(signupStatus.message);
        } else if (signupStatus is SignupSuccess) {
          Navigator.pushNamed(context, AppRoutes.otp,
              arguments: OtpPageArgs(
                isFromSignup: true,
                phoneNumber: signupStatus.phoneNumber,
              ));
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Form(
              key: formKey,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.05,
                        horizontal: size.width * 0.05,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "خوش اومدی به ",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Image.asset('assets/images/aviz_txt_logo.png'),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "این فوق العادست که آویزو برای آگهی هات انتخاب کردی!",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * .05),
                      child: Column(
                        children: [
                          AppTextField(
                            textController: nameController,
                            hintText: 'نام و نام خانوادگی',
                            validator: (value) => Validators.fullName(value),
                          ),
                          const SizedBox(height: 16),
                          AppTextField(
                            textController: phoneController,
                            hintText: 'شماره موبایل',
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.done,
                            validator: (value) => Validators.phoneNumber(value),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * .05,
                        vertical: size.height * .03,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BlocBuilder<SignupBloc, SignupState>(
                            buildWhen: (p, c) =>
                                p.signupStatus != c.signupStatus,
                            builder: (context, state) {
                              var signupStatus = state.signupStatus;

                              return MainButton(
                                text: 'مرحله بعد',
                                isLoading: signupStatus is SignupLoading,
                                icon: const Icon(
                                  Icons.navigate_next_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    context.read<SignupBloc>().add(
                                          SignupEvent(
                                            phoneNumber: phoneController.text,
                                            name: nameController.text,
                                          ),
                                        );
                                  }
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          AuthPromptText(
                            promptText: 'قبلا ثبت نام کردی؟',
                            actionText: 'ورود',
                            onAction: () => Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.login,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
