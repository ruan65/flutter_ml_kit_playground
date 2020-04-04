import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FaceDetectionScreen extends StatefulWidget {
  @override
  _FaceDetectionScreenState createState() => _FaceDetectionScreenState();
}

class _FaceDetectionScreenState extends State<FaceDetectionScreen> {
  File _imageFile;
  List<Face> _faces;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Face detector'),
      ),
      body: null == _imageFile
          ? SizedBox.shrink()
          : ImageAndFaces(_imageFile, _faces),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _getImageAndDetectFaces();
        },
        tooltip: 'Pick an image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  _getImageAndDetectFaces() async {
    final imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    print('image file: $imageFile');

    final image = FirebaseVisionImage.fromFile(imageFile);

    final faceDetector = FirebaseVision.instance
        .faceDetector(FaceDetectorOptions(mode: FaceDetectorMode.accurate));

    List<Face> faces = await faceDetector.processImage(image);

    if (mounted) {
      print('mounted: $mounted');
      setState(() {
        _imageFile = imageFile;
        _faces = faces;
      });
    }
  }
}

class ImageAndFaces extends StatelessWidget {

  final File image;
  final List<Face> faces;

  const ImageAndFaces(this.image, this.faces);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 2,
          child: Container(
            constraints: BoxConstraints.expand(),
            child: Image.file(image, fit: BoxFit.cover),
          ),
        ),
        Flexible(
          flex: 1,
          child: ListView(
            children:
                faces.map<Widget>((f) => FaceCoordinates(face: f)).toList(),
          ),
        )
      ],
    );
  }
}

class FaceCoordinates extends StatelessWidget {
  final Face face;

  const FaceCoordinates({Key key, this.face}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pos = face.boundingBox;
    return ListTile(
      title: Text('(${pos.left} ${pos.top} ${pos.right} ${pos.bottom})'),
    );
  }
}
