import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:healthhub/patient_home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginpage.dart';

// import 'loginpage.dart';

class FirstPagee extends StatefulWidget {
  @override
  FirstPageeState createState() => FirstPageeState();
}

class FirstPageeState extends State<FirstPagee>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  String spe, sprv;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    new Future.delayed(
        const Duration(seconds: 4),
        () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            ));

    // if(spe!=null && sprv=='0'){
    //   print("hello");
    //   new Future.delayed(
    //     const Duration(seconds: 2),
    //     () => Navigator.push(
    //           context,
    //           MaterialPageRoute(builder: (context) => Patient_Home(email: spe)),
    //         ));
    // }
    // else if(spe!=null && sprv=='1'){
    //   new Future.delayed(
    //     const Duration(seconds: 2),
    //     () => Navigator.push(
    //           context,
    //           MaterialPageRoute(builder: (context) => Patient_Home()),
    //         ));
    // }
    // else{
    //   new Future.delayed(
    //     const Duration(seconds: 2),
    //     () => Navigator.push(
    //           context,
    //           MaterialPageRoute(builder: (context) => LoginPage()),
    //         ));
    // }
    _controller.forward();
  }

  addStringToSF(String e, String rv) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', e);
    prefs.setString('radiovalue', rv);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RotationTransition(
            turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
            child: Center(
              child: Image.asset(
                'asset/logo.jpg',
                width: queryData.size.width * 0.75,
                height: queryData.size.height * 0.45,
                fit: BoxFit.cover,
              ),
            ),
            
          ),
        ],
      ),
    );
  }
}
