import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tweeter/constants.dart';
import 'package:tweeter/router.gr.dart';
import 'package:tweeter/widgets/common_appbar.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commomAppbar(),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                        child: ListTile(
                      contentPadding: EdgeInsets.all(8),
                      title: Text(
                        "Hi ${_auth.currentUser.displayName.split(" ")[0]}, Welcome to Tweeter!",
                        style: TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(
                        "We can help you in detecting a tweet is spam or not. You have to provide us a tweet id or a text.",
                        style: TextStyle(fontSize: 16),
                      ),
                    )),
                    SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: Text(
                        "Choose your preference",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: ElevatedButton(
                        child: Text("I Have a Tweet Id"),
                        onPressed: () async {
                          ExtendedNavigator.root.push(Routes.spamDetectorScreen,
                              arguments: SpamDetectorScreenArguments(
                                detectionType: DetectionType.id,
                              ));
                        },
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        child: Text("I Have a Tweet's Text"),
                        onPressed: () async {
                          ExtendedNavigator.root.push(Routes.spamDetectorScreen,
                              arguments: SpamDetectorScreenArguments(
                                detectionType: DetectionType.text,
                              ));
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: 8),
              // height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    child: Text("Log out"),
                    onPressed: () async {
                      FirebaseAuth.instance.signOut();
                      final GoogleSignIn googleSignIn = GoogleSignIn();
                      await googleSignIn.signOut();
                      ExtendedNavigator.root.pushAndRemoveUntil(
                          Routes.splashScreen, (route) => false);
                    },
                  ),
                  Text(
                    "Developed by Lavesh Mittal",
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                ],
              ))
        ],
      )),
    );
  }
}
