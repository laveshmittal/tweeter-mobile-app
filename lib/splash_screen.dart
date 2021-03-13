import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tweeter/home_screen.dart';
import 'package:tweeter/router.gr.dart';
import 'package:tweeter/user_login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateTo();
  }

  navigateTo() async {
    Timer(Duration(seconds: 2), () {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      if (_auth.currentUser == null)
        ExtendedNavigator.root
            .pushAndRemoveUntil(Routes.userLoginScreen, (route) => false);
      else
        ExtendedNavigator.root
            .pushAndRemoveUntil(Routes.homeScreen, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Center(
          child: Image.asset("assets/logo.png"),
        ),
      ),
    );
  }
}
