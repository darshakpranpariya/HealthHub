import 'package:flutter/material.dart';
import 'package:healthhub/services/check_all_appointment.dart';

class Doctor_Home extends StatefulWidget {
  final String email, name;
  Doctor_Home({Key key, this.email, this.name}) : super(key: key);

  @override
  _Doctor_HomeState createState() => _Doctor_HomeState();
}

class _Doctor_HomeState extends State<Doctor_Home> {
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
          Icon(
            Icons.message,
            size: 30.0,
          )
        ],
      ),
      body: Column(
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
                    size: 50.0,                 ),
                  Padding(
                    padding: EdgeInsets.only(top: 50.0),
                  ),
                  Center(
                    child: Text("Hello ${widget.name}",
                        style: TextStyle(
                          shadows: [
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
                          ],
                          fontSize: 18.0
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.0),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Check_All_Appointment(doctorname: widget.name)));
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
    );
  }
}
