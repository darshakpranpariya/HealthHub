import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthhub/services/crud1.dart';

class GetAISuggestions extends StatefulWidget {
  final String question;
  GetAISuggestions({Key key, this.question}) : super(key: key);

  @override
  _GetAISuggestionsState createState() => _GetAISuggestionsState();
}

class _GetAISuggestionsState extends State<GetAISuggestions> {
  CRUD1 crudobj = new CRUD1();
  QuerySnapshot messages;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    crudobj.getData('DAA').then((result) {
      setState(() {
        messages = result;
      });
    });
  }

  Future<bool> manage_back_button(){
    Navigator.pop(context,true);
    Navigator.pop(context,true);
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: manage_back_button,
          child: Scaffold(
        appBar:AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: (){Navigator.pop(context,true);
              Navigator.pop(context,true);
            }
          ),),
        body: Container(
          decoration: BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Colors.red[200], Colors.blue[200]])),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Container(
                  color: Colors.pink[100],
                  child: Center(
                      child: Text("Question: "+widget.question,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold)))),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Container(color:Colors.pink[100],child: Center(child: Text("Answers",style:TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)))),
              if (messages != null)
                for (int i = 0; i < messages.documents.length; i++)
                  get_suggestions(i),
              if (messages == null) Column(
                children: <Widget>[
                  Container(child: CircularProgressIndicator()),
                  
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget get_suggestions(int i) {
    if (messages.documents[i].data['Result'] != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Container(
            color: Colors.amber[100],
            child: Text(
              messages.documents[i].data['Result'],
              style: TextStyle(fontSize: 18.0),
            )),
      );
    } else
      return Container();
  }
}
