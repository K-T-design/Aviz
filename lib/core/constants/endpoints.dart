abstract class Endpoints {
  static const _baseUrl = 'http://192.168.110.233:8080';

  // User
  static const signup = '$_baseUrl/users/v1/signup';
  static const verifyPhone = '$_baseUrl/users/v1/verify-phone';
  static const login = '$_baseUrl/users/v1/login';
  static const verifyOtp = '$_baseUrl/users/v1/verify-otp';
  static const user = '$_baseUrl/users/v1';

  // Post
  static const hottest = '$_baseUrl/posts/v1/hottest';
  static const latest = '$_baseUrl/posts/v1/latest';
  static const addPost = '$_baseUrl/posts/v1';
  static const postById = '$_baseUrl/posts/v1/{postId}';
  static const userPosts = '$_baseUrl/posts/v1/user';
  static const allPosts = '$_baseUrl/posts/v1';
  static const favoritePosts = '$_baseUrl/posts/v1/favorite';
  static const addPostToFavorite = '$_baseUrl/posts/v1/favorite';

  // Category
  static const categories = '$_baseUrl/categories/v1';
}
