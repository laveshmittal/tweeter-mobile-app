import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:tweeter/constants.dart';

class Api {
  Future<String> detectById(String id) async {
    try {
      http.Response response =
          await http.get(Uri.https(SERVER_URL, "/tweetId/$id"));
      // var dbRef = FirebaseDatabase.instance.reference().child('');
      return response.body;
    } catch (e) {
      return {"success": false}.toString();
    }
  }

  Future<String> detectByText(String text) async {
    try {
      http.Response response = await http.post(
        Uri.https(
          SERVER_URL,
          "/text/",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'text': text,
        }),
      );
      return response.body;
    } catch (e) {
      print(e);
      return {"success": false}.toString();
    }
  }
}
