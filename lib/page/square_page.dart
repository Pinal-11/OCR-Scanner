import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:ocr_scanner/utils.dart';
class SquarePage extends StatefulWidget {
  final bool isGallery;

  const SquarePage({
    Key key,
    @required this.isGallery,
  }) : super(key: key);

  @override
  _SquarePageState createState() => _SquarePageState();
}

class _SquarePageState extends State<SquarePage> {
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
                  onPressed: () {},
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
      cropImage: cropSquareImage,
    );

    if (file == null) return;
    else {
      setState(() {
        image = file;
      });
    }
  }

  Future<File> cropSquareImage(File imageFile) async =>
      await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [CropAspectRatioPreset.square],
        compressQuality: 70,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: androidUiSettingsLocked(),
        iosUiSettings: iosUiSettingsLocked(),
      );

  IOSUiSettings iosUiSettingsLocked() => IOSUiSettings(
        rotateClockwiseButtonHidden: false,
        rotateButtonsHidden: false,
      );

  AndroidUiSettings androidUiSettingsLocked() => AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.red,
        toolbarWidgetColor: Colors.white,
        hideBottomControls: true,
      );
}
