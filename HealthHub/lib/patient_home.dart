import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:healthhub/AI%20assistant/sytody_app.dart';
import 'package:healthhub/assistant.dart';
import 'package:healthhub/services/appointment_day.dart';
import 'package:healthhub/services/crud1.dart';
import 'package:healthhub/text_reco.dart';
import 'package:intl/intl.dart';
import 'package:healthhub/ner.dart';
import 'package:rolling_nav_bar/rolling_nav_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:getflutter/getflutter.dart';

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
  QuerySnapshot messages, token_status, user_details;
  String username = "darshak";

  @override
  void initState() {
    if (date.hour == 23) {
      if (messages != null) {
        for (int l = 0; l < messages.documents.length; l++) {
          crudobj.deleteData1(messages.documents[l].documentID);
        }
      }
    }

    controller = new TabController(length: 1, vsync: this);
    super.initState();
    crudobj.getData('messages').then((result) {
      setState(() {
        messages = result;
      });
    });
    crudobj.getData('manage_token_status').then((result) {
      setState(() {
        token_status = result;
      });
    });
    crudobj.getData('user').then((result) {
      setState(() {
        user_details = result;
      });
    });
  }

  Widget card(BuildContext context) {
    int t = date.hour;
    if (!(t >= 10 && t < 22)) {
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
  }

  void onTabTapped(int index) {
    setState(() {
      currentindex = index;
      // _children[currentindex];
    });
  }
  Future<bool> manage_back_button(){
      showDialog(
  context: context,builder: (_) => FlareGiffyDialog(
    flarePath: 'asset/space_demo.flr',
    flareAnimation: 'loading',
    title: Text('Thank you',
           style: TextStyle(
           fontSize: 22.0, fontWeight: FontWeight.w600),
    ),
    description: Text('Do you really want to exit.',
          textAlign: TextAlign.center,
          style: TextStyle(),
        ),
    onOkButtonPressed: () {exit(0);},
  ) );
    
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: manage_back_button,
          child: Scaffold(
        //backgroundColor: Colors.blue[50],
        drawer: Drawer(
          child: Container(
            decoration: BoxDecoration(
  gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [Colors.green[200], Colors.lime[200]])),
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: return_user_name(),
                  accountEmail: Text(widget.email),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).platform == TargetPlatform.iOS
                            ? Colors.blue
                            : Colors.white,
                    child: Text(
                      username[0].toUpperCase(),
                      style: TextStyle(fontSize: 40.0),
                    ),
                  ),
                ),
                ListTile(
                  title: Text("Thank you for using this app..."),
                ),
                ListTile(
                  title: Text(
                      "If you have any suggestion/query about this application then you can leave mail here..."),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Linkify(
                      onOpen: (link) async {
                        if (await canLaunch(link.url)) {
                          await launch(link.url);
                        } else {
                          throw 'Could not launch $link';
                        }
                      },
                      text: "darshak.patidar7@gmail.com",
                      style: TextStyle(color: Colors.yellow, fontSize: 20.0),
                      linkStyle: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.40,
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName("/"));
                  },
                  child: Text('Logout', style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: Text(
            "HealthHub",
            style: TextStyle(fontSize: 17.0),
          ),
          actions: <Widget>[
            Text(DateFormat('d-M-y \n  EEEE').format(date),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[Colors.red[200], Colors.blue[300]],
              ),
            ),
          ),
        ),
        body: decide_navigation(),
        bottomNavigationBar: Container(
          height: 60,
          child: 
            
             
            RollingNavBar.iconData(
              animationCurve: Curves.linear, // `linear` is recommended for `spinOutIn`
  animationType: AnimationType.spinOutIn,
  baseAnimationSpeed: 500,
  iconData: <IconData>[
      Icons.home,
      Icons.message,
  ],
  indicatorColors: <Color>[
      Colors.red,
      Colors.blue,
  ],
  onTap: onTabTapped, // new
            //currentIndex: currentindex,
)// new
            // items: [
            //   BottomNavigationBarItem(
            //     icon: new Icon(Icons.home),
            //     title: new Text('Home'),
            //   ),
            //   BottomNavigationBarItem(
            //     icon: new Icon(Icons.mail),
            //     title: new Text('Messages'),
            //   ),
            //   // BottomNavigationBarItem(
            //   //     icon: Icon(Icons.person), title: Text('Profile'))
            // ],
          
        ),
      ),
    );
  }

  Widget return_user_name() {
    if (user_details != null) {
      for (int i = 0; i <= user_details.documents.length; i++) {
        if (widget.email == user_details.documents[i].data['email']) {
          username = user_details.documents[i].data['username'];
          return Text(user_details.documents[i].data['username']);
        }
      }
    } else
      return CircularProgressIndicator();
  }

  Widget decide_navigation() {
    if (currentindex == 0) {
      return ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[Colors.yellow[100], Colors.green[200]],
                  ),
                ),
              ),
              hospitaldetails(),
            ],
          ),
          Container(
            decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              Colors.cyan[100],
              Colors.lime[100]
            ],
          ),
        ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 50.0),
                ),
                GFCard(
                  color: Colors.orangeAccent[100],
                  boxFit: BoxFit.cover,
                  imageOverlay: AssetImage('asset/ap.jpg'),
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.18), BlendMode.dstATop),
                  title: GFListTile(
                    avatar: GFAvatar(
                      backgroundImage: AssetImage('asset/aa.jpg'),
                    ),
                    title: Text('Online Appointment Booking',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal[900],fontSize: 14.0),),
                    subTitle: Text('Doctor Appointment'),
                  ),
                  content: Text(
                      "Please Book your appointmnet for doctor and reserve your token quickly"),
                  buttonBar: GFButtonBar(
                    children: <Widget>[
                      GFButton(
                        onPressed: () {
                          setState(() {
                            if (date.hour == 23) {
                              for (int l = 0;
                                  l < token_status.documents.length;
                                  l++) {
                                crudobj.deleteData2(
                                    token_status.documents[l].documentID);
                              }
                            }
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Appointment(emaill: widget.email)));
                        },
                        text: 'Book Appointment',
                      )
                    ],
                  ),
                ),
                GFCard(
                  color: Colors.orangeAccent[100],
                  boxFit: BoxFit.cover,
                  imageOverlay: AssetImage('asset/na.png'),
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.18), BlendMode.dstATop),
                  title: GFListTile(
                    avatar: GFAvatar(
                      backgroundImage: AssetImage('asset/na.png'),
                    ),
                    title: Text('Name Entity Recognization',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal[900],fontSize: 14.0),),
                    subTitle: Text('Recognize all jargon''s'),
                  ),
                  content: Text(
                      "You can understand meaning of all the new medical words by simply write name of that words"),
                  buttonBar: GFButtonBar(
                    children: <Widget>[
                      GFButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => NER()));
                        },
                        text: 'Find Meaning of Medical Words',
                      )
                    ],
                  ),
                ),
                GFCard(
                  color: Colors.orangeAccent[100],
                  boxFit: BoxFit.cover,
                  imageOverlay: AssetImage('asset/aia.jpg'),
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.18), BlendMode.dstATop),
                  title: GFListTile(
                    avatar: GFAvatar(
                      backgroundImage: AssetImage('asset/aia.jpg'),
                    ),
                    title: Text('Doctor AI Assistant',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal[900],fontSize: 14.0),),
                    subTitle: Text('AI Assistant'),
                  ),
                  content: Text(
                      "You can get suggestions from Doctor AI assistant to cure your diseases by simply providing sysmtoms"),
                  buttonBar: GFButtonBar(
                    children: <Widget>[
                      GFButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Assistant()));
                        },
                        text: 'Doctor AI Assistant',
                      )
                    ],
                  ),
                ),
                GFCard(
                  color: Colors.orangeAccent[100],
                  boxFit: BoxFit.cover,
                  imageOverlay: AssetImage('asset/oca.jpg'),
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.18), BlendMode.dstATop),
                  title: GFListTile(
                    avatar: GFAvatar(
                      backgroundImage: AssetImage('asset/oca.jpg'),
                    ),
                    title: Text('Health Data Visualization',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal[900],fontSize: 14.0),),
                    subTitle: Text('OCR'),
                  ),
                  content: Text(
                      "You can visualize your health data from anywhere and anytime,it will also give suggestion to maintain your healh."),
                  buttonBar: GFButtonBar(
                    children: <Widget>[
                      GFButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Text_Reco()));
                        },
                        text: 'Health Data Visualization',
                      )
                    ],
                  ),
                ),
                
              ],
            ),
          ),
        ],
      );
    } else if (currentindex == 1) {
      return Scaffold(
        body: get_all_messages(),
      );
    } else {
      return Scaffold(
        body: ListView(
          children: <Widget>[],
        ),
      );
    }
  }

  Widget get_all_messages() {
    return Container(
      decoration: BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Colors.yellow[200], Colors.red[200]])),
      child: ListView(
        children: <Widget>[
          for (int i = 0; i < messages.documents.length; i++)
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
    if (messages != null) {
      Padding(
        padding: EdgeInsets.only(top: 10.0),
      );
      return Card(
        color: Colors.red[50],
        child: ListTile(
          leading: Icon(Icons.message),
          title: Text("${messages.documents[i].data["doctor_name"]}"),
          subtitle: Text(
              "${messages.documents[i].data["Date"]}\n${messages.documents[i].data["message"]}"),
          isThreeLine: true,
        ),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
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
        crossAxisAlignment: CrossAxisAlignment.center,
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
