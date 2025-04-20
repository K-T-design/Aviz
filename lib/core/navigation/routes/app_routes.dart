import 'package:aviz/ui/add_post/add_post_page.dart';
import 'package:aviz/ui/all_posts/all_posts_page.dart';
import 'package:aviz/ui/auth/login/login_page.dart';
import 'package:aviz/ui/auth/otp/otp_page.dart';
import 'package:aviz/ui/auth/signup/signup_page.dart';
import 'package:aviz/ui/favorite/favorite_page.dart';
import 'package:aviz/ui/home/home_page.dart';
import 'package:aviz/ui/intro/landing/intro_page.dart';
import 'package:aviz/ui/intro/splash/view/splash_page.dart';
import 'package:aviz/ui/main/main_page.dart';
import 'package:aviz/ui/map/map_page.dart';
import 'package:aviz/ui/post_detail/post_detail_page.dart';
import 'package:aviz/ui/profile/profile_page.dart';
import 'package:aviz/ui/user_posts/user_posts_page.dart';

abstract class AppRoutes {
  static const splash = '/splash';

  static const intro = '/intro';
  static const login = '/login';
  static const signup = '/signup';
  static const otp = '/otp';

  static const main = '/main';
  static const home = '/home';

  static const postDetail = '/post-detail';
  static const userPosts = '/user-posts';
  static const allPosts = '/all-posts';
  static const favoritePosts = '/favorite-posts';

  static const profile = '/profile';

  static const addPost = '/add-post';

  static const map = '/map';

  static final routes = {
    // Intro
    AppRoutes.splash: (context) => const SplashPage(),
    AppRoutes.intro: (context) => const IntroPage(),

    // Auth
    AppRoutes.login: (context) => const LoginPage(),
    AppRoutes.signup: (context) => const SignupPage(),
    AppRoutes.otp: (context) => const OtpPage(),

    // Main
    AppRoutes.main: (context) => const MainPage(),
    AppRoutes.home: (context) => const HomePage(),

    // Post
    AppRoutes.postDetail: (context) => const PostDetailPage(),
    AppRoutes.userPosts: (context) => const UserPostsPage(),
    AppRoutes.allPosts: (context) => const AllPostsPage(),
    AppRoutes.favoritePosts: (context) => const FavoritePage(),

    // Profile
    AppRoutes.profile: (context) => const ProfilePage(),

    // Profile
    AppRoutes.addPost: (context) => const AddPostPage(),

    // Map
    AppRoutes.map: (context) => const MapPage(),
  };
}
