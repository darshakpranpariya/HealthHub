import 'package:flutter/material.dart';

import 'loginpage.dart';
// import 'loginpage.dart';

class FirstPagee extends StatefulWidget {
  
  @override
  _FirstPageeState createState() => _FirstPageeState();
}

class _FirstPageeState extends State<FirstPagee> {

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    new Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            ));
  }
  @override
  Widget build(BuildContext context) {
     MediaQueryData queryData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.green[50],
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
            Center(
              child: Image.asset(
                'asset/1.png',
                width: queryData.size.width-80,
                height: queryData.size.height-350,
                fit: BoxFit.cover,
              ),
            ),
          // Center(
          //   // child: Padding(
          //   //   padding: EdgeInsets.only(top:0.0),
          //   //   child: Text("Welcme To HealthHub",style:TextStyle(fontSize: 22.0,color: Colors.green[300],fontWeight: FontWeight.bold)),
          //   // ),
          // ),
        ],
      ),
    );
  }
}