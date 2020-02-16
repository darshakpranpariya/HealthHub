import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Text_Reco extends StatefulWidget {
  @override
  _Text_RecoState createState() => _Text_RecoState();
}

class _Text_RecoState extends State<Text_Reco> {
  File pickedImage;
  bool isImageLoaded = false;
  String s="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: <Widget>[
      Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          isImageLoaded
              ? Center(
                  child: Container(
                      height: 300.0,
                      width: 300.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(pickedImage),
                              fit: BoxFit.cover))),
                )
              : Container(
                  height: 200.0,
                  width: 200.0,
                ),
          SizedBox(height: 15.0),
          Text(s),
          Padding(
            padding: const EdgeInsets.only(top: 300),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: "btn1",
                  child: Icon(Icons.photo),
                  onPressed: pickImage,
                  backgroundColor: Colors.pink,
                ),
                FloatingActionButton(
                  heroTag: "btn2",
                  child: Icon(Icons.arrow_forward_ios),
                  onPressed: readText,
                  backgroundColor: Colors.pink,
                ),
              ],
            ),
          ),
        ],
      ),
    ]));
  }

  Future pickImage() async {
    var tempStore = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (tempStore == null) {
      Navigator.pop(context);
    }
    setState(() {
      pickedImage = tempStore;
      isImageLoaded = true;
    });
  }

  VisionText rt;

  Future readText() async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    rt = await recognizeText.processImage(ourImage);
    setState(() {
      for (TextBlock block in rt.blocks) {
        for (TextLine line in block.lines) {
          for (TextElement word in line.elements) {
            s += " " + word.text;
          }
        }
      }
    });
  }
}
