// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'home_screen.dart';
import 'spam_detector_screen.dart';
import 'splash_screen.dart';
import 'user_login_screen.dart';

class Routes {
  static const String splashScreen = '/';
  static const String userLoginScreen = '/user-login-screen';
  static const String spamDetectorScreen = '/spam-detector-screen';
  static const String homeScreen = '/home-screen';
  static const all = <String>{
    splashScreen,
    userLoginScreen,
    spamDetectorScreen,
    homeScreen,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashScreen, page: SplashScreen),
    RouteDef(Routes.userLoginScreen, page: UserLoginScreen),
    RouteDef(Routes.spamDetectorScreen, page: SpamDetectorScreen),
    RouteDef(Routes.homeScreen, page: HomeScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    SplashScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SplashScreen(),
        settings: data,
      );
    },
    UserLoginScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => UserLoginScreen(),
        settings: data,
      );
    },
    SpamDetectorScreen: (data) {
      final args = data.getArgs<SpamDetectorScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) =>
            SpamDetectorScreen(detectionType: args.detectionType),
        settings: data,
      );
    },
    HomeScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeScreen(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// SpamDetectorScreen arguments holder class
class SpamDetectorScreenArguments {
  final DetectionType detectionType;
  SpamDetectorScreenArguments({@required this.detectionType});
}
