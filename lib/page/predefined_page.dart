import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:ocr_scanner/textRecognition.dart';
import 'package:ocr_scanner/utils.dart';

class PredefinedPage extends StatefulWidget {
  final bool isGallery;

  const PredefinedPage({
    Key key,
    @required this.isGallery,
  }) : super(key: key);

  @override
  _PredefinedPageState createState() => _PredefinedPageState();
}

class _PredefinedPageState extends State<PredefinedPage> {
  File image;

  @override
  Widget build(BuildContext context) {

    if(image != null){
      return Scaffold(
        body: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top:10.0, bottom: 30.0, left: 30.0, right: 30.0),
                child: Card(
                    elevation: 10.0,
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: 400.0
                      ),
                      child: Center(
                        child: Image.file(image),
                      ),
                    )
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  color: Colors.deepPurpleAccent,
                  onPressed: () => setState(() {image = null;}),
                  child: Row(
                    children: [
                      Icon(Icons.chevron_left, color: Colors.white,),
                      Text(
                        'Back', style: TextStyle(color: Colors.white),),
                    ],
                  ),
                ),
                SizedBox(width: 20,),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> textRecognitionWidget(image: image)));
                    },
                  child: Row(
                    children: [
                      Text('Continue', style: TextStyle(color: Colors.white),
                      ),
                      Icon(Icons.chevron_right, color: Colors.white,)
                    ],
                  ),
                  color: Colors.deepPurpleAccent,),
              ],
            ),
          ],
        ),
      );
    }
    else{
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top:20.0, bottom: 80.0, left: 30.0, right: 30.0),
            child: Card(
                elevation: 10.0,
                child: Container(
                  child: Center(
                    child: Icon(
                      Icons.image,
                      color: Colors.deepPurpleAccent, size: 100,
                    ),
                  ),
                )
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: onClickedButton,
          backgroundColor: Colors.deepPurpleAccent,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 2, color: Colors.white),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(Icons.add, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    }
  }

  Future onClickedButton() async {
    final file = await Utils.pickMedia(
      isGallery: widget.isGallery,
      cropImage: cropPredefinedImage,
    );

    if (file == null)
      return;
    else {
      setState(() {
        image = file;
      });
    }
  }

  Future<File> cropPredefinedImage(File imageFile) async =>
      await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
        ],
        androidUiSettings: androidUiSettingsLocked(),
        iosUiSettings: iosUiSettingsLocked(),
      );

  IOSUiSettings iosUiSettingsLocked() => IOSUiSettings(
        aspectRatioLockEnabled: false,
        resetAspectRatioEnabled: false,
      );

  AndroidUiSettings androidUiSettingsLocked() => AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.red,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      );
}
