import 'package:aviz/core/exceptions/exception_handler.dart';
import 'package:aviz/data/data_src/local/auth_local_data_src.dart';
import 'package:aviz/data/data_src/remote/auth_remote_data_src.dart';
import 'package:aviz/data/data_src/remote/category_remote_data-src.dart';
import 'package:aviz/data/data_src/remote/post_remote_data_src.dart';
import 'package:aviz/data/repo/auth/auth_repo.dart';
import 'package:aviz/data/repo/post/add_post_repo.dart';
import 'package:aviz/data/repo/post/favorite_post_repo.dart';
import 'package:aviz/data/repo/post/post_repo.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../interceptors/deep.dart';

final di = GetIt.instance;

initDependencies() async {
  // Services

  di.registerSingleton<Logger>(Logger());
  di.registerSingleton<ExceptionHandler>(ExceptionHandler());
  di.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
  initDio();

  // Data Sources
  di.registerSingleton(
    AuthRemoteDataSrc(
      logger: di(),
      httpClient: di(),
      handleException: di(),
    ),
  );
  di.registerSingleton(AuthLocalDataSrc(prefs: di()));

  di.registerSingleton(
    PostDataSrcRemote(
      httpClient: di(),
      exceptionHandler: di(),
    ),
  );
  di.registerSingleton(
    CategoryRemoteDataSrc(
      httpClient: di(),
      exceptionHandler: di(),
    ),
  );

  // Repo
  di.registerSingleton<AuthRepo>(
    AuthRepo(
      authRemoteDataSrc: di(),
      authLocalDataSrc: di(),
    ),
  );

  di.registerSingleton(
    PostRepo(
      postDataSrcRemote: di(),
      authLocalDataSrc: di(),
    ),
  );
  di.registerSingleton(
    AddPostRepo(
      postDataSrcRemote: di(),
      authLocalDataSrc: di(),
      categoryRemoteDataSrc: di(),
    ),
  );

  di.registerSingleton(
    FavoritePostRepo(
      postDataSrcRemote: di(),
      authLocalDataSrc: di(),
    ),
  );
}

initDio() {
  final dio = Dio(
    BaseOptions(
      contentType: 'application/json',
      connectTimeout: const Duration(seconds: 5),
    ),
  );

  dio.interceptors.add(
    DeepRetryInterceptor(dio),
  );

  di.registerSingleton<Dio>(dio);
}
