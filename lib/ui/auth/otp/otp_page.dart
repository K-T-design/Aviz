import 'dart:async';

import 'package:aviz/core/navigation/args/otp_page_args.dart';
import 'package:aviz/core/navigation/routes/app_routes.dart';
import 'package:aviz/core/services/di/di.dart';
import 'package:aviz/core/theme/app_colors.dart';
import 'package:aviz/core/utils/hooks/use_countdown.dart';
import 'package:aviz/core/utils/hooks/use_page_args.dart';
import 'package:aviz/core/widgets/snack_bar/app_snack_bar.dart';
import 'package:aviz/core/widgets/loading_in_button.dart';
import 'package:aviz/ui/auth/otp/bloc/otp_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpBloc(di()),
      child: const OtpView(),
    );
  }
}

class OtpView extends HookWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    final args = usePageArgs<OtpPageArgs>();
    final code = useState('');
    final (timeLeft, isActive) = useCountdown(120);

    useEffect(() {
      if (!isActive) {
        Future.delayed(Duration.zero, () {
          if (context.mounted) Navigator.of(context).pop();
        });
      }
      return null;
    }, [isActive]);

    // Format seconds into MM:SS
    final minutes = (timeLeft ~/ 60).toString().padLeft(2, '0');
    final seconds = (timeLeft % 60).toString().padLeft(2, '0');

    return Scaffold(
      body: BlocListener<OtpBloc, OtpState>(
        listenWhen: (p, c) => p.verifyOtpStatus != c.verifyOtpStatus,
        listener: (context, state) {
          final verifyOtpStatus = state.verifyOtpStatus;

          if (verifyOtpStatus is VerifyOtpSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.home,
              (route) => false,
            );
          } else if (verifyOtpStatus is VerifyOtpError) {
            AppSnackBar.showError(verifyOtpStatus.message);
          }
        },
        child: SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
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
                        const Text(
                          "تایید شماره موبایل",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          args.isFromSignup
                              ? "کد ثبت نام پیامک شده را وارد کنید"
                              : "کد ورود پیامک شده را وارد کنید",
                          style: const TextStyle(
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
                  child: Column(
                    children: [
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: OtpTextField(
                          numberOfFields: 4,
                          cursorColor: AppColors.primary,
                          focusedBorderColor: AppColors.primary,
                          fieldWidth: size.width * 0.2,
                          fieldHeight: size.width * 0.2,
                          filled: true,
                          fillColor: AppColors.otpTextField,
                          autoFocus: true,
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          showFieldAsBox: true,
                          onCodeChanged: (String code) {},
                          onSubmit: (String verificationCode) {
                            code.value = verificationCode;

                            context.read<OtpBloc>().add(
                                  VerifyOtpEvent(
                                    code: verificationCode,
                                    phoneNumber: args.phoneNumber,
                                    isSignup: args.isFromSignup,
                                  ),
                                );
                          }, // end onSubmit
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "$minutes:$seconds",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "ارسال مجدد کد",
                            style: TextStyle(
                              color: Colors.grey.withOpacity(0.7),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
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
                        SizedBox(
                          width: size.width,
                          height: size.height * 0.06,
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<OtpBloc>().add(
                                    VerifyOtpEvent(
                                      code: code.value,
                                      phoneNumber: args.phoneNumber,
                                      isSignup: args.isFromSignup,
                                    ),
                                  );
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(AppColors.primary),
                              foregroundColor:
                                  WidgetStateProperty.all(Colors.white),
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: const BorderSide(
                                      color: AppColors.primary),
                                ),
                              ),
                            ),
                            child: BlocBuilder<OtpBloc, OtpState>(
                              buildWhen: (p, c) =>
                                  p.verifyOtpStatus != c.verifyOtpStatus,
                              builder: (context, state) {
                                final verifyOtpStatus = state.verifyOtpStatus;

                                if (verifyOtpStatus is VerifyOtpLoading) {
                                  return const LoadingInButton();
                                } else {
                                  return Text(
                                    args.isFromSignup
                                        ? "تایید ثبت نام"
                                        : "تایید ورود",
                                  );
                                }
                              },
                            ),
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
    );
  }
}
