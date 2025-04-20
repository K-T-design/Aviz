import 'package:aviz/core/navigation/args/otp_page_args.dart';
import 'package:aviz/core/navigation/routes/app_routes.dart';
import 'package:aviz/core/services/di/di.dart';
import 'package:aviz/core/utils/validators/validators.dart';
import 'package:aviz/core/widgets/snack_bar/app_snack_bar.dart';
import 'package:aviz/core/widgets/app_text_field.dart';
import 'package:aviz/core/widgets/auth_prompt_text.dart';
import 'package:aviz/core/widgets/main_button.dart';
import 'package:aviz/ui/auth/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(di()),
      child: const LoginView(),
    );
  }
}

class LoginView extends HookWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    final formKey = useMemoized(GlobalKey<FormState>.new);
    final phoneController = useTextEditingController();

    useEffect(() {
      AppSnackBar.init(context);
      return null;
    }, []);

    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listenWhen: (p, c) => p.loginStatus != c.loginStatus,
        listener: (context, state) {
          var loginStatus = state.loginStatus;

          if (loginStatus is LoginError) {
            AppSnackBar.showError(loginStatus.message);
          } else if (loginStatus is LoginSuccess) {
            Navigator.pushNamed(context, AppRoutes.otp,
                arguments: OtpPageArgs(
                  isFromSignup: false,
                  phoneNumber: loginStatus.phoneNumber,
                ));
          }
        },
        child: SafeArea(
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
                                "ورود به ",
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
                            "خوشحالیم که مجددا آویز رو برای آگهی انتخاب کردی!",
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
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * .05,
                      ),
                      child: AppTextField(
                        textController: phoneController,
                        hintText: 'شماره موبایل',
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        validator: (value) => Validators.phoneNumber(value),
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
                          BlocBuilder<LoginBloc, LoginState>(
                            buildWhen: (p, c) => p.loginStatus != c.loginStatus,
                            builder: (context, state) {
                              var loginStatus = state.loginStatus;

                              return MainButton(
                                text: 'مرحله بعد',
                                isLoading: loginStatus is LoginLoading,
                                icon: const Icon(
                                  Icons.navigate_next_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    context.read<LoginBloc>().add(
                                          LoginEvent(
                                            phoneNumber: phoneController.text,
                                          ),
                                        );
                                  }
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          AuthPromptText(
                            promptText: 'تا حالا ثبت نام نکردی؟',
                            actionText: 'ثبت نام',
                            onAction: () => Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.signup,
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
