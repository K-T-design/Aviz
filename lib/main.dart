import 'package:aviz/app.dart';
import 'package:aviz/core/blocs/add_favorite_bloc/toggle_favorite_bloc.dart';
import 'package:aviz/core/blocs/app_bloc_observer.dart';
import 'package:aviz/core/blocs/auth_bloc/auth_bloc.dart';
import 'package:aviz/core/services/di/di.dart';
import 'package:aviz/ui/intro/landing/bloc/intro_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  Bloc.observer = AppBlocObserver();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => IntroBloc(di())),
        BlocProvider(create: (context) => AuthBloc(di())..add(WatchUser())),
        BlocProvider(create: (context) => ToggleFavoriteBloc(di())),
      ],
      child: const App(),
    ),
  );
}
