import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar commomAppbar({bool showBackArrow = false}) => AppBar(
      // actions: [
      //   IconButton(
      //       icon: Icon(
      //         CupertinoIcons.person_alt,
      //         color: Colors.black,
      //       ),
      //       onPressed: () {})
      // ],
      leading: !showBackArrow
          ? null
          : IconButton(
              icon: Icon(
                CupertinoIcons.back,
                color: Colors.black,
              ),
              onPressed: () {
                ExtendedNavigator.root.pop();
              }),
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Container(
        height: 80,
        width: 80,
        child: Image.asset(
          'assets/logo.png',
        ),
      ),
    );
