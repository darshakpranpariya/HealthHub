//import 'package:firebaselogin/firstpage.dart';
//import 'package:firebaselogin/loginpage.dart';
//import 'package:firebaselogin/services/crud.dart';
import 'package:flutter/material.dart';
import 'package:healthhub/AI%20assistant/sytody_app.dart';
import 'package:healthhub/doctor_home.dart';
import 'package:healthhub/loginpage.dart';
import 'package:healthhub/patient_home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firstpagee.dart';
// import 'loginpage.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String spe,sprv;
  spe=prefs.getString('email');
  sprv=prefs.getString('radiovalue');
  runApp(MaterialApp(debugShowCheckedModeBanner: false,home: spe != null && sprv=='0' ? Patient_Home(email: spe):FirstPagee()));
  // runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "HealthHub",
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: FirstPagee(),
    );
  }
}