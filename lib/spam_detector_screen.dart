import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tweeter/constants.dart';
import 'package:tweeter/services/api.dart';
import 'package:tweeter/widgets/common_appbar.dart';

TextEditingController tweetIdController = TextEditingController();
TextEditingController tweetTextController = TextEditingController();

class SpamDetectorScreen extends StatefulWidget {
  final DetectionType detectionType;
  SpamDetectorScreen({@required this.detectionType});
  @override
  _SpamDetectorState createState() => _SpamDetectorState();
}

class _SpamDetectorState extends State<SpamDetectorScreen> {
  bool showLoader = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commomAppbar(showBackArrow: true),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(16),
            child: getDetectorWidget(widget.detectionType),
          ),
          showLoader
              ? Container(
                  color: Colors.black54,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container()
        ],
      ))),
    );
  }

  Widget getDetectorWidget(DetectionType detectionType) {
    switch (detectionType) {
      case DetectionType.id:
        return Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Text(
              "Please input a tweet id for spam detection ",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: tweetIdController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  labelText: "Tweet Id",
                  hintText: "Please provide a tweet id"),
            ),
            Builder(
              builder: (ctx) => ElevatedButton(
                  onPressed: () async {
                    try {
                      FocusScope.of(ctx).unfocus();
                    } catch (e) {}

                    if (RegExp('[0-9]+').hasMatch(tweetIdController.text)) {
                      setState(() {
                        showLoader = true;
                      });
                      var response =
                          await Api().detectById(tweetIdController.text);
                      var obj = jsonDecode(response);
                      print(obj);
                      if (obj['success'] == true) {
                        showResultDialog(obj);
                      } else {
                        Fluttertoast.showToast(
                            msg: "${obj['error_message']}",
                            gravity: ToastGravity.BOTTOM);
                      }
                      setState(() {
                        showLoader = false;
                      });
                    } else {
                      Fluttertoast.showToast(
                          msg: "Please provide valid id",
                          gravity: ToastGravity.BOTTOM);
                    }
                  },
                  child: Text("Fetch Details")),
            )
          ],
        );
        break;
      default:
        return Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Text(
              "Please input a tweet's text for spam detection ",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: tweetTextController,
              keyboardType: TextInputType.text,
              maxLines: 10,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  labelText: "Tweet Text",
                  alignLabelWithHint: true,
                  hintText: "Please provide tweet text"),
            ),
            Builder(
              builder: (ctx) => ElevatedButton(
                  onPressed: () async {
                    try {
                      FocusScope.of(ctx).unfocus();
                    } catch (e) {}

                    if (tweetTextController.text.length > 0) {
                      setState(() {
                        showLoader = true;
                      });
                      var response =
                          await Api().detectByText(tweetTextController.text);
                      var obj = jsonDecode(response);
                      print(obj);
                      if (obj['success'] == true) {
                        showResultDialog(obj);
                      } else {
                        Fluttertoast.showToast(
                            msg: "${obj['error_message']}",
                            gravity: ToastGravity.BOTTOM);
                      }

                      setState(() {
                        showLoader = false;
                      });
                    } else {
                      Fluttertoast.showToast(
                          msg: "Please provide valid text",
                          gravity: ToastGravity.BOTTOM);
                    }
                  },
                  child: Text("Fetch Details")),
            ),
          ],
        );
    }
  }

  Future showResultDialog(obj) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: obj['spam']
            ? Center(
                child: Text(
                  "SPAM",
                  style: TextStyle(color: Colors.red),
                ),
              )
            : Center(
                child: Text(
                  "NOT SPAM",
                  style: TextStyle(color: Colors.green),
                ),
              ),
        content: Builder(
          builder: (ctx) => Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Sentiment:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8.0,
                ),
                progressBar((double.parse('${obj['polarity']}') + 1.0) / 2, ctx,
                    "Negative", "Positive"),
                SizedBox(
                  height: 30.0,
                ),
                Text("Subjectivity:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 8.0,
                ),
                progressBar((double.parse('${obj['subjectivity']}') + 1.0) / 2,
                    ctx, "Objective", "Subjective"),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Center(
                    child: ElevatedButton(
                        onPressed: () {
                          ExtendedNavigator.root.pop();
                        },
                        child: Text("Go Back")),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget progressBar(double value, BuildContext ctx, String leftHandTitle,
      String rightHandTitle) {
    var barWidth = MediaQuery.of(ctx).size.width * 0.5;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: barWidth + 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  "$leftHandTitle",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Container(
                child: Text(
                  "$rightHandTitle",
                  style: TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
        ),
        Container(
          height: 30.0,
          padding: EdgeInsets.all(8),
          alignment: Alignment.topCenter,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 5.0,
                child: Row(
                  children: [
                    Container(
                      height: 12.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(colors: [
                            Colors.red,
                            Colors.yellow,
                            Colors.green
                          ])),
                      width: barWidth,
                    ),
                  ],
                ),
              ),
              Positioned(
                left: barWidth * value - 12,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black,
                      ),
                      height: 24.0,
                      width: 2.0,
                    ),
                    Container(
                      child: Text((value).toString()),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
