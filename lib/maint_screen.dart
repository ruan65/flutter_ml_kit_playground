import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'face_detection_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          height: 300,
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text('Face'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FaceDetectionScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
