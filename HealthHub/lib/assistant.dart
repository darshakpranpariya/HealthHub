import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthhub/services/crud1.dart';
import 'package:healthhub/services/getaisuggestions.dart';
import 'package:speech_recognition/speech_recognition.dart';
//import 'package:speech_recognition/speech_recognition.dart';

class Assistant extends StatefulWidget {
  @override
  _AssistantState createState() => _AssistantState();
}

class _AssistantState extends State<Assistant> {
  String str, QueryText = "D";
  CRUD1 crudobj = new CRUD1();
  QuerySnapshot messages;
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;

  String resultText = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSpeechRecognizer();
    crudobj.getData('DAA').then((result) {
      setState(() {
        messages = result;
      });
    });
  }

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
      (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
      () => setState(() => _isListening = true),
    );

    _speechRecognition.setRecognitionResultHandler(
      (String speech) => setState(() => resultText = speech),
    );

    _speechRecognition.setRecognitionCompleteHandler(
      () => setState(() => _isListening = false),
    );

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text(
            "Doctor AI Assistant",
            style: TextStyle(fontSize: 17.0),
          ),
          leading: Icon(
            Icons.assistant,
            size: 35.0,
          ),
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.height*0.70,
                    height: MediaQuery.of(context).size.height*0.30,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.pink,
                      elevation: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const ListTile(
                            leading: Icon(Icons.record_voice_over, size: 50),
                            title: Text('Record your symtoms and press Get Suggestions button, then wait till 10 seconds to get AI suggestions for curing your disease.',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.09,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FloatingActionButton(
                        heroTag: "btn1",
                        child: Icon(Icons.cancel),
                        mini: true,
                        backgroundColor: Colors.deepOrange,
                        onPressed: () {
                          if (_isListening)
                            _speechRecognition.cancel().then(
                                  (result) => setState(() {
                                    _isListening = result;
                                    resultText = "";
                                  }),
                                );
                        },
                      ),
                      FloatingActionButton(
                        heroTag: "btn2",
                        child: Icon(Icons.mic),
                        onPressed: () {
                          if (_isAvailable && !_isListening)
                            _speechRecognition
                                .listen(locale: "en_US")
                                .then((result) => print('$result'));
                        },
                        backgroundColor: Colors.pink,
                      ),
                      FloatingActionButton(
                        heroTag: "btn3",
                        child: Icon(Icons.stop),
                        mini: true,
                        backgroundColor: Colors.deepPurple,
                        onPressed: () {
                          if (_isListening)
                            _speechRecognition.stop().then(
                                  (result) =>
                                      setState(() => _isListening = result),
                                );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.cyanAccent[100],
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 12.0,
                    ),
                    child: Text(
                      resultText,
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  RaisedButton(
                    child: Text("Get Suggestions"),
                    onPressed: () {
                      setState(() {
                        Map<String, dynamic> data = {'symptoms': resultText};
                        for (int l = 0; l < messages.documents.length; l++) {
                          crudobj.deleteData3(messages.documents[l].documentID);
                        }
                        crudobj.addData(data, 'DAA', context);
                        

                        new Future.delayed(
                            const Duration(seconds: 10),
                            () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GetAISuggestions(
                                            question: resultText,
                                          )),
                                ));
                      });
                    },
                    color: Colors.blue,
                    textColor: Colors.yellow,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    splashColor: Colors.grey,
                  ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.03,
                  // ),
                ],
              ),
            ),
          ],
        ));
  }
}
