import 'package:flutter/material.dart';

class LogOut extends StatefulWidget {
  @override
  _LogOutState createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  @override
  Widget build(BuildContext context) {
    return
       Drawer(
        child: new Text("\n\n\nDrawer Is Here"),
      );
   
  }
}