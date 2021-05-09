import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';

import 'details.dart';

main() async {
  runApp(MaterialApp(home: textRecognitionWidget()));
}

class textRecognitionWidget extends StatefulWidget {
  final File image;

  const textRecognitionWidget({
    Key key,
    @required this.image,
  }) : super(key: key);

  @override
  _textRecognitionWidgetState createState() => _textRecognitionWidgetState();
}

class _textRecognitionWidgetState extends State<textRecognitionWidget> {
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: Text('Text Recognition'),
        ),
        body: Container(
              height: 550.0,
              width: double.infinity,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 10.0,
                    child: widget.image != null
                        ? Image.file(
                      File(widget.image.path),
                      fit: BoxFit.fitWidth,
                      ) : Container(),
                  ),
                ),
              ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Text('Scan'),
          backgroundColor: Colors.deepPurpleAccent,
          onPressed: scanText,),
    );
  }

  Future scanText() async {
     Center(
          child: CircularProgressIndicator(),
     );
    final FirebaseVisionImage visionImage =
    FirebaseVisionImage.fromFile(File(widget.image.path));
    final TextRecognizer textRecognizer =
    FirebaseVision.instance.textRecognizer();
    final VisionText visionText = await textRecognizer.processImage(visionImage);

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        _text += line.text + '\n';
      }
    }

    Navigator.of(context).pop();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Details(_text)));
  }
}