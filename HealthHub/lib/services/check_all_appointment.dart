import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthhub/services/appointment_day.dart';

import 'appointment_evening.dart';
import 'crud1.dart';

class Check_All_Appointment extends StatefulWidget {
  final String doctorname;
  Check_All_Appointment({Key key, this.doctorname}) : super(key: key);

  @override
  _Check_All_AppointmentState createState() => _Check_All_AppointmentState();
}

class _Check_All_AppointmentState extends State<Check_All_Appointment> {
  CRUD1 crudobj = new CRUD1();
  QuerySnapshot appointments;
  Appointment ob1 = new Appointment();
 AppointmentState ob2 = new AppointmentState();
 Appointment_eveningState ob3 = new Appointment_eveningState();


  @override
  void initState() {
    crudobj.getData('token').then((result) {
      setState(() {
        appointments = result;
      });
    });
  }

  int l = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          for (int i = 0; i < appointments.documents.length; i++)
            Column(
              children: <Widget>[
                returnpatientname(i),
              ],
            ),
        ],
      ),
    );
  }

  Widget returnpatientname(int i) {
    if (appointments != null) {
      print(appointments.documents[i].data["doctor_name"]);
      if (widget.doctorname == appointments.documents[i].data["doctor_name"]) {
        Padding(
          padding: EdgeInsets.only(top: 10.0),
        );
        return Card(
          color: Colors.lime[50],
          child: ListTile(
            leading: RaisedButton(
                child: Text("${appointments.documents[i].data["token_num"]}",
                    style: TextStyle(fontSize: 15.0)),
                onPressed: null,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(40.0))),
            title: Text("${appointments.documents[i].data["patient_name"]}"),
            subtitle: Text(
                "Phone=${appointments.documents[i].data["patient_phone"]}\nAge=${appointments.documents[i].data["patient_age"]}"),
            trailing: IconButton(
        icon: Icon(Icons.done_outline),
        tooltip: 'press to show token as running...',
        onPressed: () {
          setState(() {
            crudobj.updateData(appointments.documents[i].documentID, {"token_status":"1"});
          });
        },
      ),
            isThreeLine: true,
            onLongPress: () {
              showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Doctor'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('You really want to delete this appointment.\n'),
                          Text('Press DELETE to remove...'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('DELETE'),
                        onPressed: () {
                          crudobj
                              .deleteData(appointments.documents[i].documentID);
                          crudobj.getData('token').then((result) {
                            setState(() {
                              appointments = result;
                            });
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
      } else
        return Container();
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
