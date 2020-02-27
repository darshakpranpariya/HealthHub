import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:healthhub/services/appointment_evening.dart';
import 'package:healthhub/services/crud1.dart';
import 'package:healthhub/services/doctor_info.dart';

class Appointment extends StatefulWidget {
  final String emaill;
  Appointment({Key key, this.emaill}) : super(key: key);

  @override
  AppointmentState createState() => AppointmentState(email: emaill);
}

class AppointmentState extends State<Appointment>
    with SingleTickerProviderStateMixin {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  String email;
  AppointmentState({Key key, this.email});
  QuerySnapshot doctor, token_data,token_status_data;
  CRUD1 crudobj = new CRUD1();
  final _text = TextEditingController();
  final _text1 = TextEditingController();
  final _text2 = TextEditingController();
  String patient_name, patient_phone, patient_age,dn;
  bool _validate = false;
  bool cl;
  final formKey = GlobalKey<FormState>();
  //bool validate = false;

  @override
  void dispose() {
    _text.dispose();
    _text1.dispose();
    _text2.dispose();
    super.dispose();
  }

  void validateAndSave(){
    final form = formKey.currentState;
    if(form.validate())
    {
      print ('Form is valid');
    }
    else
    {
      print('form is invalid');
    }
  }

  Future<void> _ackAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          
          backgroundColor: Colors.brown[50],
          title: Text('Token Details'),
          content: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height*0.50,
            decoration: BoxDecoration(
                color: Colors.brown[50],
                border: Border.all(color: Colors.orange),
                borderRadius: BorderRadius.circular(30),
              ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                ),
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
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0))),
                    ),
                    Text(
                      "Shift's Current Token",
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                ),
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
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0))),
                    ),
                    Text(
                      "Your Booked Token",
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                ),
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
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0))),
                    ),
                    Text(
                      "Available Token For\n Booking",
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                ),
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
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0))),
                    ),
                    Text(
                      "All Patients Booked \nToken",
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
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

  Widget addDialog(BuildContext context, String token_num) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context, token_num),
    );
  }

  // Future<Null> refreshList(int t,BuildContext context) async {
  //   refreshKey.currentState?.show(atTop: false);
  //   await Future.delayed(Duration(seconds: 2));

  //   setState(() {
  //     card(t, context);
  //   });

  //   return null;
  // }

  dialogContent(BuildContext context, String token_num) {
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
              child: Form(
                key: formKey,
                              child: ListView(
                  children: <Widget>[
                    SizedBox(height: 15.0),
                    Icon(
                      Icons.person_add,
                      size: 50.0,
                    ),
                    SizedBox(height: 15.0),
                    TextField(
                      //validator: (value) => value.isEmpty ? "Email can't be empty" : null,
                      controller: _text,
                      style: TextStyle(fontSize: 20.0),
                      obscureText: false,
                      decoration: InputDecoration(
                        errorText: _validate ? 'Value Can\'t Be Empty' : null,
                          // errorText: _validate ? 'Value Can\'t Be Empty' : null,
                          contentPadding:
                              EdgeInsets.fromLTRB(10.0, 15.0, 20.0, 15.0),
                          hintText: "Patient Name",
                          hintStyle:
                              TextStyle(fontSize: 18.0, color: Colors.orange),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0))),
                      onChanged: (value) {
                        this.patient_name = value;
                      },
                      
                    ),
                    SizedBox(height: 25.0),
                    TextField(
                      controller: _text1,
                      style: TextStyle(fontSize: 20.0),
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        errorText: _validate ? 'Value Can\'t Be Empty' : null,
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Patient Phone",
                          hintStyle:
                              TextStyle(fontSize: 18.0, color: Colors.orange),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0))),
                      onChanged: (value) {
                        this.patient_phone = value;
                      },
                    ),
                    SizedBox(height: 25.0),
                    TextField(
                      controller: _text2,
                      style: TextStyle(fontSize: 20.0),
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        //errorText: _validate ? 'Value Can\'t Be Empty' : null,
                        
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Patient Age",
                          hintStyle:
                              TextStyle(fontSize: 18.0, color: Colors.orange),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0))),
                      onChanged: (value) {
                        this.patient_age = value;
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
                            Navigator.of(context).pop();
                            setState(() {
                              _text.text.isEmpty ||
                                      _text1.text.isEmpty ||
                                      _text2.text.isEmpty
                                  ? _validate = true
                                  : _validate = false;
                              //print(_validate);
                            });
                            if (!_validate) {
                              String doctor_name = getdoctor_name(token_num);
                              dn = doctor_name;
                              Map<String, dynamic> tokendata = {
                                'user_email': email,
                                'token_num': token_num,
                                'doctor_name': doctor_name,
                                'patient_name': patient_name,
                                'patient_phone': patient_phone,
                                'patient_age': patient_age,
                                'token_status':'0'
                              };
                              crudobj
                                  .addData(tokendata, "token", context)
                                  .then((result) {

                              }).catchError((e) {
                                print(e);
                              });
                            }
                            _text.clear();
                            _text1.clear();
                            _text2.clear();
                            _validate = false;
                            int t = int.parse(token_num);
                            String time="";
                            if(t>=1 && t<=15)
                              time+="In between 10:00 to 11:30 in morning";
                            else if(t>=16 && t<=30)
                              time+="In between 11:30 to 1:00 in morning";
                           FlutterOpenWhatsapp.sendSingleMessage("91${patient_phone}", "Thanks for booking an appointment,\n${patient_name} Your appointment for ${dn} is booked successfully!\nyour token number is ${token_num},\nyour appointment time is ${time}.");
                            Navigator.of(context).pop();
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

  String getdoctor_name(String token_num) {
    int token = int.parse(token_num);
    if (token >= 1 && token <= 15) {
      return doctor.documents[1].data["doctor"];
    } else if (token >= 16 && token <= 30) {
      return doctor.documents[3].data["doctor"];
    } else if (token >= 31 && token <= 45) {
      return doctor.documents[0].data["doctor"];
    } else if (token >= 46 && token <= 60) {
      return doctor.documents[4].data["doctor"];
    } else {
      return doctor.documents[3].data["doctor"];
    }
  }

  TabController controller;
  @override
  void initState() {
    controller = new TabController(length: 2, vsync: this);
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
              morning(context),
              Appointment_evening(emailll: widget.emaill)
            ],
          ),
        ),
      ),
    );
  }

  Widget morning(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Container(
          decoration: BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Colors.blue[200], Colors.red[200]])),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),
              ),
              time_doct(1),
              Padding(
                padding: EdgeInsets.only(top: 15.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  card(1, context),
                  card(2, context),
                  card(3, context),
                  card(4, context),
                  card(5, context)
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  card(6, context),
                  card(7, context),
                  card(8, context),
                  card(9, context),
                  card(10, context)
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  card(11, context),
                  card(12, context),
                  card(13, context),
                  card(14, context),
                  card(15, context)
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
              ),
              time_doct(3),
              Padding(
                padding: EdgeInsets.only(top: 15.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  card(16, context),
                  card(17, context),
                  card(18, context),
                  card(19, context),
                  card(20, context)
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  card(21, context),
                  card(22, context),
                  card(23, context),
                  card(24, context),
                  card(25, context)
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  card(26, context),
                  card(27, context),
                  card(28, context),
                  card(29, context),
                  card(30, context)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  int c = 0;
  void check_color(int i) {

      for (int j = 0; j < token_data.documents.length; j++) {
      if (int.parse(token_data.documents[j].data["token_num"]) == i ) {
        if (token_data.documents[j].data["user_email"] == email) {
          if(int.parse(token_data.documents[j].data["token_status"])==1){
            c=2;
          }
          else
            c = 1;
        } else {
          c = -1;if(int.parse(token_data.documents[j].data["token_status"])==1){
            c=2;
          }
          else
            c = -1;
        }
      }  
      if (c == 1 || c == -1 || c==2) break;
    }
  }

  Widget card(int i, BuildContext context) {
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
                final snackBar =
                    SnackBar(content: Text('Sorry! Token already booked'));
                Scaffold.of(context).showSnackBar(snackBar);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0))),
        );
      }else if(c==2){
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
                    SnackBar(content: Text('Shift''s Current Token running...'));
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
