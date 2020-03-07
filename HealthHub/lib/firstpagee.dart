import 'package:flutter/material.dart';
import 'package:healthhub/patient_home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginpage.dart';
// import 'loginpage.dart';

class FirstPagee extends StatefulWidget {
  
  @override
  FirstPageeState createState() => FirstPageeState();
}

class FirstPageeState extends State<FirstPagee> {

  String spe,sprv;
  @override
  void initState() {
    super.initState();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // spe=prefs.getString('email');
    // sprv=prefs.getString('radiovalue');
    new Future.delayed(
        const Duration(seconds: 2),
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
  }

  addStringToSF(String e,String rv) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('email',e);
  prefs.setString('radiovalue', rv);
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
                width: queryData.size.width*0.75,
                height: queryData.size.height*0.45,
                fit: BoxFit.cover,
              ),
            ),
        ],
      ),
    );
  }
}