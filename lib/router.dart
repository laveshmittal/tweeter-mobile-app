import 'package:auto_route/auto_route_annotations.dart';
import 'package:tweeter/home_screen.dart';
import 'package:tweeter/spam_detector_screen.dart';
import 'package:tweeter/splash_screen.dart';
import 'package:tweeter/user_login_screen.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    // initial route is named "/"
    MaterialRoute(page: SplashScreen, initial: true),
    MaterialRoute(page: UserLoginScreen),
    MaterialRoute(page: SpamDetectorScreen),
    MaterialRoute(page: HomeScreen),
  ],
)
class $Router {}
