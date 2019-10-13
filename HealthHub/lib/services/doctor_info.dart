import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthhub/services/crud1.dart';

class doctor_info extends StatefulWidget {
  @override
  _doctor_infoState createState() => _doctor_infoState();
}

class _doctor_infoState extends State<doctor_info> {

  CRUD1 crudobj = new CRUD1();
  QuerySnapshot doctor;

  @override
  void initState(){
      crudobj.getData('time_doct').then((result) {
      setState(() {
        doctor = result;
      });
    });
  }

    Widget alldoctinfo(int i){
    return Column(
      children: <Widget>[
        SizedBox(
          height: 30.0,
          width: 50.0,
          child: RaisedButton(
            child:Text((i+1).toString(),style: TextStyle(fontSize: 10.0)),
            onPressed: null,
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0))
          ),
        ),
           time_doctt(i),
        
      ],
    );
  }
  
  Widget time_doctt(int i) {
  
    if (doctor == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top:10.0),),
          Text(doctor.documents[i].data["doctor"],
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 15.0,
                  )),
                  Text("Register_Number :  "+doctor.documents[i].data["reg_num"],
              style: TextStyle(fontSize: 15.0)),
          Text("Experience :  "+doctor.documents[i].data["experience"],
              style: TextStyle(fontSize: 15.0)),
              Text("Specialist :"+doctor.documents[i].data["specialist"],
              style: TextStyle(fontSize: 15.0)),
              Text("Education :  "+doctor.documents[i].data["education"],
              style: TextStyle(fontSize: 15.0))
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Center(child: Container(
            height: 40.0,
            width: 80.0,
            color: Colors.pink[50],
            child: Text("Doctors",style: TextStyle(fontSize:17.0,fontWeight: FontWeight.bold,color: Colors.pink[200]),))),
          Padding(
            padding: EdgeInsets.only(top:15.0),
          ),
          for(int i=0;i<doctor.documents.length;i++)
            Container(
            height: 200.0,
            width: 100.0,
            color: Colors.brown[50],
            child: alldoctinfo(i),
            ),
        ],
      ),
    );
  }




}