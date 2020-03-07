//import 'package:firebaselogin/profilepage.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:healthhub/firstpagee.dart';
import 'package:healthhub/patient_home.dart';
import 'package:healthhub/services/crud1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:healthhub/doctor_home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType { login, register }

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {

  FirstPageeState ob1 = new FirstPageeState();
  CRUD1 crudobj = new CRUD1();
  final formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  FormType _formType = FormType.login;
  int radiovalue;
  String _username;
  String _phone;
  QuerySnapshot data;
  LoginPage ob;
  bool isLoading = true;
  bool validateAndSave() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      setState(() {
        isLoading = true;
      });
      return false;
    }
  }

  void insert(BuildContext context) {
    Map<String, dynamic> signupdata = {
      'email': _email,
      'username': _username,
      'phone': _phone
    };

    crudobj.addData(signupdata, 'user', context).then((result) {
      print(signupdata);
    }).catchError((e) {
      print(e);
    });
  }

  void submit() async {
    String cate;
    bool temp = true;
    bool v = true;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
      if (validateAndSave()) {
        if (_formType == FormType.login) {
          setState(() {
            isLoading = false;
          });
          FirebaseAuth.instance
              .signInWithEmailAndPassword(email: _email, password: _password)
              .then((FirebaseUser user) {
            v = false;
            print(v);
            if (radiovalue == 0) {
              cate = 'user';
            } else
              cate = 'doctor';
            ob1.addStringToSF(_email,radiovalue.toString());
            crudobj.getData(cate).then((result) {
              setState(() {
                data = result;
                if (data != null) {
                  for (int i = 0; i < data.documents.length; i++) {
                    if (_email == data.documents[i].data['email']) {
                      if (cate == "user") {
                        var route = new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new Patient_Home(email: _email),
                        );
                        Navigator.of(context).push(route);
                      } else {
                        var route = new MaterialPageRoute(
                          builder: (BuildContext context) => new Doctor_Home(
                              email: _email,
                              name: data.documents[i].data['username']),
                        );
                        Navigator.of(context).push(route);
                      }
                      radiovalue = null;
                      temp = false;
                      break;
                    }
                  }
                  if (temp) {
                    var alertDialog = AlertDialog(
                      title: Text("Please select correct category"),
                      content: Text("patient or Doctor"),
                    );
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => alertDialog);
                    setState(() {
                      isLoading = true;
                    });
                  }
                }
              });
            });
          }).catchError((e) {
            print("hello");
            setState(() {
              isLoading = true;
            });
            var alertDialog1 = AlertDialog(
              title: Text("Error"),
              content: Text("your email/password is wrong"),
            );
            showDialog(
                context: context,
                builder: (BuildContext context) => alertDialog1);
            print(e);
          });
          // if (v==true) {
          //   setState(() {
          //     var alertDialog = AlertDialog(
          //             title: Text("Error"),
          //             content: Text("your email/password is wrong"),
          //           );
          //           showDialog(
          //               context: context,
          //               builder: (BuildContext context) => alertDialog);
          //   });

          //         }
        } else {
          FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _email, password: _password)
              .then((user) {
            setState(() {
              insert(context);
            });
            var alertDialog = AlertDialog(
              title: Text("Account Created Successfully"),
              content: Text("Please Do Login"),
            );

            showDialog(
                context: context,
                builder: (BuildContext context) => alertDialog);
          });
        }
      }
    } on SocketException catch (_) {
      setState(() {
        isLoading = true;
      });
      var alertDialog = AlertDialog(
        title: Text("Oops,there is no internet connection"),
        content: Text("please switch on mobile data"),
      );

      showDialog(
          context: context, builder: (BuildContext context) => alertDialog);
    }
  }

  void signin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void login() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  Future<bool> manage_back_button(){
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: manage_back_button,
          child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(title: Text("SignUp/SignIn"),
          flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[Colors.red[200], Colors.blue[300]],
                ),
              ),
            ),),
          
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.white, Colors.red[200]])),
            padding: EdgeInsets.all(15.0),
            child: ListView(
              children: <Widget>[
                Form(
                  key: formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: buildInput() + buildSubmitButton()),
                ),
              ],
            ),
          )),
    );
  }

  List<Widget> buildInput() {
    return [
      TextFormField(
        style: TextStyle(fontSize: 17.0),
        decoration: InputDecoration(
          labelText: "Email",
          labelStyle: TextStyle(fontSize: 17.0),
        ),
        validator: (value) => value.isEmpty ? "Email can't be empty" : null,
        onSaved: (value) {
          _email = value;
        },
      ),
      TextFormField(
        style: TextStyle(fontSize: 17.0),
        decoration: InputDecoration(
            labelText: "Password", labelStyle: TextStyle(fontSize: 17.0)),
        obscureText: true,
        validator: (value) => value.isEmpty ? "Password can't be empty" : null,
        onSaved: (value) => _password = value,
      ),
    ];
  }

  void something(int e) {
    setState(() {
      if (e == 0) {
        radiovalue = 0;
      } else {
        radiovalue = 1;
      }
    });
  }

  List<Widget> buildSubmitButton() {
    if (_formType == FormType.login) {
      return [
        Padding(
          padding: EdgeInsets.only(top: 25.0),
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new Radio(
              activeColor: Colors.blue,
              value: 0,
              groupValue: radiovalue,
              onChanged: (int e) => something(e),
            ),
            new Text(
              'Patient',
              style: new TextStyle(fontSize: 16.0),
            ),
            new Radio(
              activeColor: Colors.deepPurpleAccent,
              value: 1,
              groupValue: radiovalue,
              onChanged: (int e) => something(e),
            ),
            new Text(
              'Doctor',
              style: new TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.0),
        ),
        isLoading
            ? ButtonTheme(
                height: 50.0,
                minWidth: 50.0,
                //buttonColor: Colors.orange[200],
                splashColor: Colors.red,
                child: RaisedButton(
                  child: Text(
                    "LogIn",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: submit,
                ),
              )
            : Center(child: CircularProgressIndicator()),
        Padding(
          padding: EdgeInsets.only(top: 15.0),
        ),
        FlatButton(
          child: Text(
            "Create an account",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          onPressed: signin,
        )
      ];
    } else {
      return [
        TextFormField(
          style: TextStyle(fontSize: 17.0),
          decoration: InputDecoration(
            labelText: "UserName",
            labelStyle: TextStyle(fontSize: 17.0),
          ),
          validator: (value) =>
              value.isEmpty ? "username can't be empty" : null,
          onSaved: (value) => _username = value,
        ),
        TextFormField(
          style: TextStyle(fontSize: 17.0),
          decoration: InputDecoration(
            labelText: "Phone Number",
            labelStyle: TextStyle(fontSize: 17.0),
          ),
          keyboardType: TextInputType.number,
          validator: (value) =>
              value.isEmpty ? "phone number can't be empty" : null,
          onSaved: (value) => _phone = value,
        ),
        Padding(
          padding: EdgeInsets.only(top: 15.0),
        ),
        ButtonTheme(
          height: 50.0,
          minWidth: 50.0,
          splashColor: Colors.red,
          child: RaisedButton(
            child: Text(
              "Create an account",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            onPressed: submit,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 15.0),
        ),
        FlatButton(
          child: Text(
            "Have an account? LogIn",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          onPressed: login,
        )
      ];
    }
  }
}
