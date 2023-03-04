import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:passmanager/src/screen/index/index.dart';
import 'package:passmanager/src/screen/validation/login/view/login_screen.dart';
import 'package:passmanager/src/screen/validation/register/view/register_screen.dart';

import '../../screen/splash/splash_screen.dart';
import 'error_route.dart';
import 'route_name.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const SplashScreen(),
        );
      case loginPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const LoginScreen(),
        );
      case registerPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const RegisterScreen(),
        );

      case indexPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const IndexScreen(),
        );

      /// ==============End=================
      ///
      default:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const ErrorScreen(),
        );
    }
  }
}
