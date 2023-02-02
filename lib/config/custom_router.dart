import 'package:flutter/material.dart';

import '/screens/dashboard/widgets/twin_details.dart';
import '/screens/login/login_screen.dart';
import '/screens/nav/nav_screen.dart';
import '/screens/notifictions/notifications_screen.dart';
import '/screens/profile/edit_profile_screen.dart';
import '/screens/registration/screens/registration_prompt.dart';
import '/screens/registration/screens/registration_screen.dart';
import '/screens/reset-password/reset_password.dart';
import '/screens/splash/splash_screen.dart';
import 'auth_wrapper.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/'),
            builder: (_) => const Scaffold());

      case AuthWrapper.routeName:
        return AuthWrapper.route();

      case SplashScreen.routeName:
        return SplashScreen.route();

      case NavScreen.routeName:
        return NavScreen.route();

      case RegistrationPrompt.routeName:
        return RegistrationPrompt.route();

      case RegistrationScreen.routeName:
        return RegistrationScreen.route();

      case LoginScreen.routeName:
        return LoginScreen.route();

      case EditProfileScreen.routeName:
        return EditProfileScreen.route();

      case NotificationsScreen.routeName:
        return NotificationsScreen.route();

      case TwinsDetailsScreen.routeName:
        return TwinsDetailsScreen.route(
            args: settings.arguments as TwinsDetailsArgs);

      case ResetPassword.routeName:
        return ResetPassword.route(
            args: settings.arguments as ResetPasswordArgs?);
      default:
        return _errorRoute();
    }
  }

  static Route onGenerateNestedRouter(RouteSettings settings) {
    print('NestedRoute: ${settings.name}');
    switch (settings.name) {
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Error',
          ),
        ),
        body: const Center(
          child: Text(
            'Something went wrong',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
