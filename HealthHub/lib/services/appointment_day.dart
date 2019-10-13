import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthhub/services/appointment_evening.dart';
import 'package:healthhub/services/crud1.dart';
import 'package:healthhub/services/doctor_info.dart';

class Appointment extends StatefulWidget {
  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment>
    with SingleTickerProviderStateMixin {
  QuerySnapshot doctor;
  CRUD1 crudobj = new CRUD1();
final _text = TextEditingController();
  final _text1 = TextEditingController();
  final _text2 = TextEditingController();
  String patient_name,patient_phone,patient_age;
  bool _validate;
  bool cl;

Future<void> _ackAlert(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Doctors'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top:15.0),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: RaisedButton(
                        color: Colors.orange,
                        child: Text(
                          (1).toString(),
                          style: TextStyle(fontSize: 12.0),
                        ),
                        onPressed: (){},
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0))),
                  ),
                Text("Shift's Current Token",style: TextStyle(fontSize: 14.0,),),
                
              ],
            ),
            Padding(padding: EdgeInsets.only(top:15.0),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: RaisedButton(
                        color: Colors.green,
                        child: Text(
                          (1).toString(),
                          style: TextStyle(fontSize: 12.0),
                        ),
                        onPressed: (){ },
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0))),
                  ),
                Text("Your Booked Token",style: TextStyle(fontSize: 14.0,),),
                
              ],
            ),
            Padding(padding: EdgeInsets.only(top:15.0),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: RaisedButton(
                        color: Colors.grey[300],
                        child: Text(
                          (1).toString(),
                          style: TextStyle(fontSize: 12.0),
                        ),
                        onPressed: (){},
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0))),
                  ),
                Text("Available Token For\n Booking",style: TextStyle(fontSize: 14.0,),),
                
              ],
            ),
            Padding(padding: EdgeInsets.only(top:15.0),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: RaisedButton(
                        color: Colors.pink[100],
                        child: Text(
                          (1).toString(),
                          style: TextStyle(fontSize: 12.0),
                        ),
                        onPressed: (){ },
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0))),
                  ),
                Text("Patient Booked Token",style: TextStyle(fontSize: 14.0,),),
                
              ],
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
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
                      controller: _text2,
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
                          //   _text.text.isEmpty || _text1.text.isEmpty || _text2.text.isEmpty ? _validate = true : _validate = false;
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
 TabController controller;
  @override
  void initState() {
    controller = new TabController(length:2, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              "Appointment Schedule",
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.info,
                      size: 30.0,
                    ),
                    onPressed: () {
                      _ackAlert(context);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.assignment_ind,
                      size: 30.0,
                    ),
                    onPressed: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => doctor_info()),
                      );
                    },
                  ),
                ],
              )
            ],
            bottom: TabBar(
              controller: controller,
              tabs: [
                Tab(
                  text: "      morning\n(10:00 to 1:00)",
                ),
                Tab(
                  text: "      evening\n(5:00 to 10:00)",
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: controller,
            children: <Widget>[
              morning(),
              Appointment_evening()
            ],
          ),
        ),
      ),
    );
  }

  Widget morning(){
    return ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),
              ),
              time_doct(1),
              Padding(
                padding: EdgeInsets.only(top:15.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[card(1), card(2), card(3), card(4), card(5)],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[card(6), card(7), card(8), card(9), card(10)],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[card(11), card(12), card(13), card(14), card(15)],
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
              ),
              time_doct(3),
              Padding(
                padding: EdgeInsets.only(top:15.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[card(16), card(17), card(18), card(19), card(20)],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[card(21), card(22), card(23), card(24), card(25)],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[card(26), card(27), card(28), card(29), card(30)],
              ),
              
            ],
          );
  }
  Widget card(int i) {
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //   children: <Widget>[
      return SizedBox(
        height: 50.0,
        width: 50.0,
        child: RaisedButton(
            color: Colors.grey[300],
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

    //   ],
    // );
  }


  
}
