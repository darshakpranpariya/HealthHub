import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:healthhub/services/appointment_day.dart';

import 'crud1.dart';

class Appointment_evening extends StatefulWidget {

  final String emailll;
  Appointment_evening({Key key, this.emailll}) : super(key: key);

  @override
  Appointment_eveningState createState() => Appointment_eveningState(email: emailll);
}

class Appointment_eveningState extends State<Appointment_evening> 
with SingleTickerProviderStateMixin{
  
  AppointmentState ob1 = new AppointmentState();
   String email;
  Appointment_eveningState({Key key, this.email});
  QuerySnapshot doctor,token_data,token_status_data;
  CRUD1 crudobj = new CRUD1();
  final _text = TextEditingController();
  final _text1 = TextEditingController();
  final _text2 = TextEditingController();
  String patient_name,patient_phone,patient_age,dn;
  bool _validate;

  String getdoctor_name(String token_num){
    int token = int.parse(token_num);
    if(token>=1 && token<=15){
      return doctor.documents[1].data["doctor"];
    }
    else if(token>=16 && token<=30){
      return doctor.documents[3].data["doctor"];
    }
    else if(token>=31 && token<=45){
      return doctor.documents[0].data["doctor"];
    }
    else if(token>=46 && token<=60){
      return doctor.documents[4].data["doctor"];
    }
    else{
      return doctor.documents[3].data["doctor"];
    }
  }

Widget addDialog(BuildContext context,String token_num) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
      ),      
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context,token_num),
    );
  }


  dialogContent(BuildContext context,String token_num) {
  return Stack(
    
    children: <Widget>[
      Center(
            child: Container(
              height: 500,
              decoration: BoxDecoration(
                color: Colors.brown[50],
                border: Border.all(color: Colors.orange),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 15.0),
                    Icon(Icons.person_add,size:50.0,),
                    SizedBox(height: 15.0),
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
                      keyboardType: TextInputType.number,
                      controller: _text1,
                      style: TextStyle(fontSize: 20.0),
                      obscureText: false,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Patient Phone",
                          hintStyle: TextStyle(fontSize: 18.0,color: Colors.orange),
                          border:
                              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                          onChanged: (value){
                            this.patient_phone=value;
                          },
                    ),
                    SizedBox(height: 25.0),
                    TextField(
                      controller: _text2,
                      style: TextStyle(fontSize: 20.0),
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Patient Age",
                          hintStyle: TextStyle(fontSize: 18.0,color: Colors.orange),
                          border:
                              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                          onChanged: (value){
                            this.patient_age=value;
                          },
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                      Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.blue[200],
                        child: MaterialButton(
                          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          onPressed: () {
                          Navigator.of(context).pop();
                            setState(() {
                            _text.text.isEmpty || _text1.text.isEmpty || _text2.text.isEmpty ? _validate = true : _validate = false;
                            });
                            if(!_validate){
                              String doctor_name = getdoctor_name(token_num);
                              dn = doctor_name;
                            Map<String,dynamic> tokendata = {'user_email':widget.emailll,'token_num':token_num,'doctor_name':doctor_name,'patient_name':patient_name,'patient_phone':patient_phone,'patient_age':patient_age,};
                            crudobj.addData(tokendata,"token",context).then((result){
                            // showDialog(
                            //     context: context,
                            //     builder: (BuildContext context) {
                            //       // return object of type Dialog
                            //       return AlertDialog(
                            //         title: new Text("Thanks"),
                            //         content: new Text("${patient_name} your token number ${token_num} is booked...\n\nPlease refresh screen with back button..."),
                            //         actions: <Widget>[
                            //           // usually buttons at the bottom of the dialog
                            //           new FlatButton(
                            //             child: new Text("Close"),
                            //             onPressed: () {
                            //               Navigator.of(context).pop();
                            //             },
                            //           ),
                            //         ],
                            //       );
                            //     },
                            //   );
                            }).catchError((e){
                              print(e);
                            });}
                            _text.clear();
                            _text1.clear();
                             _text2.clear();
                           _validate=false;
                           int t = int.parse(token_num);
                          String time="";
                          if(t>=31 && t<=45)
                            time+="In between 05:00 to 06:30 in evening";
                          else if(t>=46 && t<=60)
                            time+="In between 06:30 to 8:00 in evening";
                          else
                            time+="In between 08:00 to 10:00 in night";
                          FlutterOpenWhatsapp.sendSingleMessage("91${patient_phone}", "Thanks for booking an appointment,\n${patient_name} Your appointment for ${dn} is booked successfully!\nyour token number is ${token_num},\nyour appointment time is ${time}.");
                          Navigator.of(context).pop();
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

void alrertdialog(int i) {
    int q = 0;
    for (int k = 0; k < token_data.documents.length; k++) {
      if (int.parse(token_data.documents[k].data["token_num"]) == i) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("Thanks"),
                content: new Text(
                    "${token_data.documents[k].data["patient_name"]} your token number is ${token_data.documents[k].data["token_num"]}"),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });

        q = 1;
      }
      if (q == 1) break;
    }
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
  void initState() {
    super.initState();
    crudobj.getData('token').then((result) {
      setState(() {
        token_data = result;
      });
    });
    crudobj.getData('manage_token_status').then((result) {
      setState(() {
        token_status_data = result;
      });
    });
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
  // Widget card(int i) {
  //     return SizedBox(
  //       height: 50.0,
  //       width: 50.0,
  //       child: RaisedButton(
  //           child: Text(
  //             (i).toString(),
  //             style: TextStyle(fontSize: 12.0),
  //           ),
  //           onPressed: (){
  //             showDialog(
  //               context: context,
  //               builder: (BuildContext context) => addDialog(context,(i).toString()),
  //             );
  //           },
  //           shape: RoundedRectangleBorder(
  //               borderRadius: new BorderRadius.circular(30.0))),
  //     );
  // }
int c=0;

void check_color(int i) {
    for (int j = 0; j < token_data.documents.length; j++) {
      if (int.parse(token_data.documents[j].data["token_num"]) == i) {
        if (token_data.documents[j].data["user_email"] == email) {
          c = 1;
        } else {
          c = -1;
        }
      }
      if (c == 1 || c == -1) break;
    }
  }

Widget card(int i) {
    if (token_data != null) {
      c = 0;
      check_color(i);
      if (c == 1) {
        return SizedBox(
          height: 50.0,
          width: 50.0,
          child: RaisedButton(
              color: Colors.green,
              child: Text(
                (i).toString(),
                style: TextStyle(fontSize: 12.0),
              ),
              onPressed: () {
                alrertdialog(i);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0))),
        );
      } else if (c == -1) {
        return SizedBox(
          height: 50.0,
          width: 50.0,
          child: RaisedButton(
              color: Colors.pink[100],
              child: Text(
                (i).toString(),
                style: TextStyle(fontSize: 12.0),
              ),
              onPressed: () {
                Scaffold(

                );
                  final snackBar = SnackBar(content: Text('Sorry! Token already booked'));
                Scaffold.of(context).showSnackBar(snackBar);
                
                
              },
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0))),
        );
      }else if(c==2){
        print(c);
        print("oooo");
        return SizedBox(
          height: 50.0,
          width: 50.0,
          child: RaisedButton(
              color: Colors.orange,
              child: Text(
                (i).toString(),
                style: TextStyle(fontSize: 12.0),
              ),
              onPressed: () {
                final snackBar =
                    SnackBar(content: Text('Sorry! Token already booked'));
                Scaffold.of(context).showSnackBar(snackBar);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0))),
        );
      } 
      else {
        int temp=0;
        for(int p=0;p<token_status_data.documents.length;p++){
          if(i==int.parse(token_status_data.documents[p].data['token_num'])){
            temp=1;
            return SizedBox(
          height: 50.0,
          width: 50.0,
          child: RaisedButton(
              color: Colors.grey[600],
              child: Text(
                (i).toString(),
                style: TextStyle(fontSize: 12.0),
              ),
              onPressed: () {
               final snackBar =
                    SnackBar(content: Text('token was appointed already...'));
                Scaffold.of(context).showSnackBar(snackBar);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0))),
        );
          }
          if(temp==1)
            break;
        }
        if(temp==0){
          return SizedBox(
          height: 50.0,
          width: 50.0,
          child: RaisedButton(
              color: Colors.grey[300],
              child: Text(
                (i).toString(),
                style: TextStyle(fontSize: 12.0),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      addDialog(context, (i).toString()),
                );
              },
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0))),
        );
        } 
      }
    } else {
      return CircularProgressIndicator();
    }
  }

}