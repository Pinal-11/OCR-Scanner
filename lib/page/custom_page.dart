import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:ocr_scanner/utils.dart';

class CustomPage extends StatefulWidget {
  final bool isGallery;

  const CustomPage({
    Key key,
    @required this.isGallery,
  }) : super(key: key);

  @override
  _CustomPageState createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage> {
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
      cropImage: cropCustomImage,
    );

    if (file == null) return;
    else {
      setState(() {
        image = file;
      });
    }
  }

  static Future<File> cropCustomImage(File imageFile) async =>
      await ImageCropper.cropImage(
        aspectRatio: CropAspectRatio(ratioX: 16, ratioY: 9),
        sourcePath: imageFile.path,
        androidUiSettings: androidUiSettings(),
        iosUiSettings: iosUiSettings(),
      );

  static IOSUiSettings iosUiSettings() => IOSUiSettings(
        aspectRatioLockEnabled: false,
      );

  static AndroidUiSettings androidUiSettings() => AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.red,
        toolbarWidgetColor: Colors.white,
        lockAspectRatio: false,
      );
}
