// import 'dart:async';
// import 'package:aviz/core/blocs/auth_bloc/auth_bloc.dart';
// import 'package:aviz/core/navigation/routes/app_routes.dart';
// import 'package:aviz/core/theme/app_colors.dart';
// import 'package:aviz/core/widgets/app_snack_bar.dart';
// import 'package:aviz/core/widgets/loading_in_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:logger/logger.dart';
//
// class SplashPage extends StatefulWidget {
//   const SplashPage({super.key});
//
//   @override
//   State<SplashPage> createState() => _SplashPageState();
// }
//
// class _SplashPageState extends State<SplashPage> {
//   String? _nextRoute;
//
//   @override
//   void initState() {
//     super.initState();
//     AppSnackBar.init(context);
//
//     Future.delayed(const Duration(seconds: 3), () {
//       if (_nextRoute != null && mounted) {
//         Navigator.pushReplacementNamed(context, _nextRoute!);
//       }
//     });
//   }
//
//   final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
//       GlobalKey<ScaffoldMessengerState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return ScaffoldMessenger(
//       key: _scaffoldMessengerKey,
//       child: Scaffold(
//         backgroundColor: AppColors.primary,
//         body: BlocListener<AuthBloc, AuthState>(
//           listener: (context, state) {
//             if (state is Authenticated) {
//               _nextRoute = AppRoutes.home;
//             } else if (state is Unauthenticated) {
//               if (state.isFirstEntry) {
//                 _nextRoute = AppRoutes.intro;
//               } else {
//                 _nextRoute = AppRoutes.login;
//               }
//             } else if (state is AuthError) {
//               Logger().e(state.message);
//               AppSnackBar.showSimpleError(state.message);
//
//               // ScaffoldMessenger.of(context).showSnackBar(
//               //   SnackBar(content: Text(state.message)),
//               // );
//               // WidgetsBinding.instance.addPostFrameCallback((_) {
//               //
//               // });
//             }
//           },
//           child: Stack(
//             children: [
//               Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       'assets/images/aviz_txt_logo.png',
//                       scale: 0.7,
//                     ),
//                   ],
//                 ),
//               ),
//               Positioned(
//                 bottom: 22,
//                 right: 0,
//                 left: 0,
//                 child: Column(
//                   children: [
//                     const LoadingInButton(size: 28),
//                     const SizedBox(height: 8),
//                     BlocBuilder<AuthBloc, AuthState>(
//                       builder: (context, state) {
//                         if (state is AuthError) {
//                           return const Text(
//                             'Trying to connect...',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 14,
//                             ),
//                           );
//                         }
//                         return const SizedBox.shrink();
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:aviz/core/blocs/auth_bloc/auth_bloc.dart';
import 'package:aviz/core/navigation/routes/app_routes.dart';
import 'package:aviz/core/theme/app_colors.dart';
import 'package:aviz/core/widgets/snack_bar/app_snack_bar.dart';
import 'package:aviz/core/widgets/loading_in_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String? _nextRoute;
  bool _hasNavigated = false;

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  void _navigate() {
    if (_nextRoute != null && !_hasNavigated && mounted) {
      _hasNavigated = true;
      Navigator.pushReplacementNamed(context, _nextRoute!);
    }
  }

  @override
  void initState() {
    super.initState();
    AppSnackBar.init(context);
    Future.delayed(const Duration(seconds: 3), () {
      _navigate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              _nextRoute = AppRoutes.main;
            } else if (state is Unauthenticated) {
              _nextRoute =
                  state.isFirstEntry ? AppRoutes.intro : AppRoutes.login;
            } else if (state is AuthError) {
              AppSnackBar.showSimpleError(state.message);
              return;
            }

            Future.delayed(const Duration(milliseconds: 1500), _navigate);
          },
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/aviz_txt_logo.png',
                      scale: 0.7,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 22,
                right: 0,
                left: 0,
                child: Column(
                  children: [
                    const LoadingInButton(size: 28),
                    const SizedBox(height: 8),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthError) {
                          return const Text(
                            'تلاش برای اتصال...',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
