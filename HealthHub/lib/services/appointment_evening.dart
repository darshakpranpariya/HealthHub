import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthhub/services/appointment_day.dart';

import 'crud1.dart';

class Appointment_evening extends StatefulWidget {
  @override
  _Appointment_eveningState createState() => _Appointment_eveningState();
}

class _Appointment_eveningState extends State<Appointment_evening> 
with SingleTickerProviderStateMixin{
  

QuerySnapshot doctor;
  CRUD1 crudobj = new CRUD1();
final _text = TextEditingController();
  final _text1 = TextEditingController();
  String patient_name,patient_phone,patient_age;
  bool _validate;

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
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Icon(Icons.person_add,size:50.0,),
                    SizedBox(height: 40.0),
                    TextField(
                      controller: _text,
                      style: TextStyle(fontSize: 20.0),
                      obscureText: false,
                      decoration: InputDecoration(
                        // errorText: _validate ? 'Value Can\'t Be Empty' : null,
                          contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 20.0, 15.0),
                          hintText: "Patient Name",
                          hintStyle: TextStyle(fontSize: 18.0,color: Colors.orange),
                          border:
                              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                          onChanged: (value){
                              this.patient_name=value;
                          },
                    ),
                    SizedBox(height: 25.0),
                    TextField(
                      controller: _text1,
                      style: TextStyle(fontSize: 20.0),
                      obscureText: false,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Patient Phone",
                          hintStyle: TextStyle(fontSize: 20.0,color: Colors.orange),
                          border:
                              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                          onChanged: (value){
                            this.patient_phone=value;
                          },
                    ),
                    SizedBox(height: 25.0),
                    TextField(
                      controller: _text1,
                      style: TextStyle(fontSize: 20.0),
                      obscureText: false,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Patient Age",
                          hintStyle: TextStyle(fontSize: 20.0,color: Colors.orange),
                          border:
                              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                          onChanged: (value){
                            this.patient_age=value;
                          },
                    ),
                    SizedBox(
                      height: 35.0,
                    ),
                      Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.blue[200],
                        child: MaterialButton(
                          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          onPressed: () {
                          //   Navigator.of(context).pop();
                          //   setState(() {
                          //   _text.text.isEmpty || _text1.text.isEmpty ? _validate = true : _validate = false;
                          //   });
                          //   if(!_validate){
                
                          //   Map<String,dynamic> noteData = {'NoteTitle':noteTitle,'Note':note,'Date':formattedDate};
                          //   crudobj.addData(noteData,context).then((result){
                          //     _ackAlert(context);
                          //   }).catchError((e){
                          //     print(e);
                          //   });}
                          //   _text.clear();
                          //   _text1.clear();
                          //  _validate=false;
                          },
                          child: Text("Done",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize:18.0),
                        ),
                      )
                    ),
                  ],
                ),
              ),
            ),
          ),
    ],
  );
}



Widget time_doct(int i) {
    crudobj.getData('time_doct').then((result) {
      setState(() {
        doctor = result;
      });
    });
    if (doctor == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(doctor.documents[i].data["time"],
              style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold)),
          Text(doctor.documents[i].data["doctor"],
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold))
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),
              ),
              time_doct(0),
              Padding(
                padding: EdgeInsets.only(top:15.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[card(31), card(32), card(33), card(34), card(35)],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[card(36), card(37), card(38), card(39), card(40)],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[card(41), card(42), card(43), card(44), card(45)],
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
              ),
              time_doct(4),
              Padding(
                padding: EdgeInsets.only(top:15.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[card(46), card(47), card(48), card(49), card(50)],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[card(51), card(52), card(53), card(54), card(55)],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[card(56), card(57), card(58), card(59), card(60)],
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
              ),
              time_doct(2),
              Padding(
                padding: EdgeInsets.only(top:15.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[card(61), card(62), card(63), card(64), card(65)],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[card(66), card(67), card(68), card(69), card(70)],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[card(71), card(72), card(73), card(74), card(75)],
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
              ),
            ],
          ),
    );
  }
  Widget card(int i) {
      return SizedBox(
        height: 50.0,
        width: 50.0,
        child: RaisedButton(
            child: Text(
              (i).toString(),
              style: TextStyle(fontSize: 12.0),
            ),
            onPressed: (){
              showDialog(
                context: context,
                builder: (BuildContext context) => addDialog(context),
              );
            },
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0))),
      );
  }
}