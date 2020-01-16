import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthhub/services/appointment_day.dart';
import 'package:healthhub/services/crud1.dart';
import 'package:intl/intl.dart';

class Patient_Home extends StatefulWidget {

    final String email;
    Patient_Home({Key key, this.email}) : super(key: key);

  @override
  _Patient_HomeState createState() => _Patient_HomeState();
}

class _Patient_HomeState extends State<Patient_Home>
    with SingleTickerProviderStateMixin {


  DateTime date = DateTime.now();
  QuerySnapshot data;
  CRUD1 crudobj = new CRUD1();
  TabController controller;
  int currentindex = 0;
  final List<Widget> _children = [];
  
  @override
  void initState() {
    controller = new TabController(length: 2, vsync: this);
    super.initState();
  }

  Widget card(BuildContext context) {
    int c1=0;
    // setState(() {
    int t = date.hour;
    print(t);
    if (!(t>=10 && t<22)) {
      return Card(
        color: Colors.green[50],
        child: Column(
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.not_interested, size: 40),
              title: Text("Doctors is not available...\n Shift not running..."),
              //subtitle: Text('TWICE'),
            ),
          ],
        ),
      );
    } else {
        return Card(
          color: Colors.green[50],
          child: Column(
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.check_circle, size: 40),
                title: Text("Doctors is available...\n Shift running..."),
                //subtitle: Text('TWICE'),
              ),
            ],
          ),
        );
    }
    // });
  }

  void onTabTapped(int index) {
    setState(() {
      currentindex = index;
      _children[currentindex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        leading: Icon(Icons.dehaze),
        title: Text(
          "HealthHub",
          style: TextStyle(fontSize: 17.0),
        ),
        actions: <Widget>[
          Text(DateFormat('d-M-y \n  EEEE').format(date)),
        ],
      ),
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: 400.0,
                height: 200.0,
                color: Colors.blueGrey[100],
              ),
              hospitaldetails(),
            ],
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50.0),
              ),
              Card(
                color: Colors.yellow[50],
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text("Book appointment",
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold)),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Appointment(emaill: widget.email)));
                      },
                      child: Container(
                        width: 200.0,
                        height: 50.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: currentindex, // new
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.mail),
            title: new Text('Messages'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profile'))
        ],
      ),
    );
  }

  Widget hospitaldetails() {
    crudobj.getData('hospital').then((result) {
      setState(() {
        data = result;
      });
    });
    if (data == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 5.0),
          ),
          Text(
            data.documents[0].data['hos_name'],
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          Text(data.documents[0].data['hos_time'],
              style: TextStyle(
                fontSize: 15.0,
              )),
          Text(data.documents[0].data['hos_add'],
              style: TextStyle(
                fontSize: 15.0,
              )),
          Text(data.documents[0].data['hos_phone'],
              style: TextStyle(
                fontSize: 15.0,
              )),
          card(context),
        ],
      );
    }
  }
}
