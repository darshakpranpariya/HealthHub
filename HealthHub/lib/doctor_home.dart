import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthhub/services/check_all_appointment.dart';
import 'package:healthhub/services/crud1.dart';
import 'package:intl/intl.dart';

class Doctor_Home extends StatefulWidget {
  final String email, name;
  Doctor_Home({Key key, this.email, this.name}) : super(key: key);

  @override
  _Doctor_HomeState createState() => _Doctor_HomeState();
}

class _Doctor_HomeState extends State<Doctor_Home> {
  CRUD1 crudobj = new CRUD1();
  QuerySnapshot final_message;
  String message;
  final _text = TextEditingController();
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: Icon(
          Icons.person_outline,
          size: 30.0,
        ),
        title: Text("Welcome"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.message),
            tooltip: 'leave any message to patient...',
            onPressed: () {
              setState(() {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => addDialog(context),
                );
              });
            },
          ),
        ],
      ),
      body: ListView(children: <Widget>[
        Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 100.0),
            ),
            Center(
              child: Container(
                width: 300.0,
                height: 300.0,
                decoration: BoxDecoration(
                  color: Colors.brown[50],
                  border: Border.all(color: Colors.brown[400]),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    Icon(
                      Icons.sentiment_very_satisfied,
                      size: 50.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 50.0),
                    ),
                    Center(
                      child: Text("Hello ${widget.name}",
                          style: TextStyle(shadows: [
                            Shadow(
                              color: Colors.blue,
                              blurRadius: 8.0,
                              offset: Offset(5.0, 5.0),
                            ),
                            Shadow(
                              color: Colors.green[50],
                              blurRadius: 8.0,
                              offset: Offset(-5.0, 5.0),
                            ),
                          ], fontSize: 18.0)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30.0),
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Check_All_Appointment(
                                    doctorname: widget.name)));
                      },
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF0D47A1),
                              Color(0xFF1976D2),
                              Color(0xFF42A5F5),
                            ],
                          ),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: const Text('Check All Appointment',
                            style: TextStyle(fontSize: 15.0)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  Widget addDialog(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: Container(
            height: 350,
            decoration: BoxDecoration(
                color: Colors.orange[50],
                border: Border.all(color: Colors.orange),
                borderRadius: BorderRadius.circular(30),
              ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Icon(
                    Icons.event_note,
                    size: 50.0,
                  ),
                  SizedBox(height: 40.0),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: _text,
                    style: TextStyle(fontSize: 18.0),
                    obscureText: false,
                    decoration: InputDecoration(
                        // errorText: _validate ? 'Value Can\'t Be Empty' : null,
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 15.0, 20.0, 15.0),
                        hintText: "Write Message here...",
                        hintStyle:
                            TextStyle(fontSize: 18.0, color: Colors.orange),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0))),
                    onChanged: (value) {
                      this.message = value;
                    },
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.orange[200],
                      child: MaterialButton(
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: () {
                          Navigator.of(context).pop();
                          setState(() {
                            _text.text.isEmpty
                                ? _validate = true
                                : _validate = false;
                          });
                          if (!_validate) {
                            String formattedDate =
                                DateFormat('    d-M-y  h:mm a')
                                    .format(DateTime.now());
                            Map<String, dynamic> Data = {
                              'message': message,
                              'Date': formattedDate,
                              'doctor_name':widget.name
                            };
                            crudobj
                                .addData(Data, "messages", context)
                                .then((result) {
                            }).catchError((e) {
                              print(e);
                            });
                          }
                          _text.clear();
                          _validate = false;
                        },
                        child: Text(
                          "Done",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
