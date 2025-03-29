import 'package:go_router/go_router.dart';
import 'package:shop_app/features/auth/presentation/view/screens/change_password_screen.dart';
import 'package:shop_app/features/auth/presentation/view/screens/update_profile_screen.dart';
import 'package:shop_app/features/layout/presentation/views/screens/product_details_screen.dart';
import 'package:shop_app/features/layout/presentation/views/screens/profile_screen.dart';
import 'package:shop_app/features/auth/presentation/view/screens/sign_in_screen.dart';
import 'package:shop_app/features/auth/presentation/view/screens/sign_up_screen.dart';
import 'package:shop_app/features/layout/presentation/views/screens/home_screen.dart';
import 'package:shop_app/features/layout/presentation/views/screens/layout_screen.dart';
import 'package:shop_app/features/splash/presentation/view/screens/splash_screen.dart';

abstract class AppRouter {
  static const kSignUpScreen = '/signUpScreen';
  static const kHomeScreen = '/homeScreen';
  static const kSignInScreen = '/signInScreen';
  static const kSplashScreen = '/splashScreen';
  static const kProfileScreen = '/profileScreen';
  static const kLayoutScreen = '/layoutScreen';
  static const kChangePasswordScreen = '/passwordScreen';
  static const kUpdateProfileScreen = '/updateProfileScreen';
  static const kProductDetailsScreen = '/productDetailsScreen';
  static const kNAvBarScreen = '/NavBarScreen';
  static final router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: kSignUpScreen,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: kSignInScreen,
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
        path: AppRouter.kHomeScreen,
        builder: (context, state) {
          return HomeScreen();
        }),
    GoRoute(
      path: kProfileScreen,
      builder: (context, state) => ProfileScreen(),
    ),
    GoRoute(
      path: kLayoutScreen,
      builder: (context, state) => LayoutScreen(),
    ),
    GoRoute(
      path: kChangePasswordScreen,
      builder: (context, state) => ChangePasswordScreen(),
    ),
    GoRoute(
      path: kUpdateProfileScreen,
      builder: (context, state) => UpdateProfileScreen(),
    ),
    GoRoute(
      path: kProductDetailsScreen,
      builder: (context, state) => ProductDetailsScreen(),
    ),
  ]);
}
