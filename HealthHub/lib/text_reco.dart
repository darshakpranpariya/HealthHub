// import 'dart:io';

// import 'package:firebase_ml_vision/firebase_ml_vision.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class Text_Reco extends StatefulWidget {
//   @override
//   _Text_RecoState createState() => _Text_RecoState();
// }

// class _Text_RecoState extends State<Text_Reco> {
//   File pickedImage;
//   bool isImageLoaded = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//       children: <Widget>[
//         FloatingActionButton(
//           heroTag: "btn1",
//           child: Icon(Icons.photo),
//           onPressed: pickImage,
//           backgroundColor: Colors.pink,
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 0.20,
//         ),
//         isImageLoaded
//             ? Center(
//                 child: Container(
//                     height: 200.0,
//                     width: 200.0,
//                     decoration: BoxDecoration(
//                         image: DecorationImage(
//                             image: FileImage(pickedImage), fit: BoxFit.cover))),
//               )
//             : Container(),
//         FloatingActionButton(
//           heroTag: "btn2",
//           child: Icon(Icons.arrow_forward_ios),
//           onPressed: readText,
//           backgroundColor: Colors.pink,
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 0.20,
//         ),
//       ],
//     ));
//   }

//   Future pickImage() async {
//     var tempStore = await ImagePicker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       pickedImage = tempStore;
//       isImageLoaded = true;
//     });
//   }

//   Future readText() async {
//     FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
//     TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
//     VisionText readText = await recognizeText.processImage(ourImage);

//     for (TextBlock block in readText.blocks) {
//       for (TextLine line in block.lines) {
//         for (TextElement word in line.elements) {
//           print(word.text);
//         }
//       }
//     }
//   }
// }
