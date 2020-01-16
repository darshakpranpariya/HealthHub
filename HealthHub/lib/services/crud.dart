import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:healthhub/services/crud1.dart';
class CRUD extends StatefulWidget {
  @override
  _CRUDState createState() => _CRUDState();
}

class _CRUDState extends State<CRUD> with
SingleTickerProviderStateMixin {

  //DateTime now = DateTime.now();
  

  String noteTitle;
  String note;
  QuerySnapshot notes;

  CRUD1 crudobj = new CRUD1();

  final _text = TextEditingController();
  final _text1 = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  // static final TextEditingController _textController = TextEditingController();
  // bool r = false;

   Widget addDialog(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
      ),      
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

Future<void> _ackAlert(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Thanks'),
        content: const Text('Your Note Saved Successfully \n Please press Refresh button'),
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

  dialogContent(BuildContext context) {
  return Stack(
    
    children: <Widget>[
      Center(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: ListView(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Icon(Icons.event_note,size:50.0,),
                    SizedBox(height: 40.0),
                    TextField(
                      controller: _text,
                      style: TextStyle(fontSize: 20.0),
                      obscureText: false,
                      decoration: InputDecoration(
                        // errorText: _validate ? 'Value Can\'t Be Empty' : null,
                          contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 20.0, 15.0),
                          hintText: "Notes Title",
                          hintStyle: TextStyle(fontSize: 18.0,color: Colors.orange),
                          border:
                              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                          onChanged: (value){
                              this.noteTitle=value;
                          },
                    ),
                    SizedBox(height: 25.0),
                    TextField(
                      controller: _text1,
                      style: TextStyle(fontSize: 20.0),
                      obscureText: false,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Notes",
                          hintStyle: TextStyle(fontSize: 20.0,color: Colors.orange),
                          border:
                              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                          onChanged: (value){
                            this.note=value;
                          },
                    ),
                    SizedBox(
                      height: 35.0,
                    ),
                      Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.orange[200],
                        child: MaterialButton(
                          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          onPressed: () {
                            Navigator.of(context).pop();
                            setState(() {
                            _text.text.isEmpty || _text1.text.isEmpty ? _validate = true : _validate = false;
                            });
                            if(!_validate){
                            String formattedDate = DateFormat('    d-M-y  h:mm a').format(DateTime.now());
                            Map<String,dynamic> noteData = {'NoteTitle':noteTitle,'Note':note,'Date':formattedDate};
                            crudobj.addData(noteData,"",context).then((result){
                              _ackAlert(context);
                            }).catchError((e){
                              print(e);
                            });}
                            _text.clear();
                            _text1.clear();
                           _validate=false;
                          },
                          child: Text("Done",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize:18.0),
                        ),
                      )
                    ),
                  ],
                ),
              ),
            ),
          ),
    ],
  );
}

  TabController controller;
  @override
  void initState() {

    controller = new TabController(length:2, vsync: this);

    crudobj.getData('ok').then((result){
      setState(() {
       notes = result; 
      });
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              showDialog(
                context: context,
                builder: (BuildContext context) => addDialog(context),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: (){
              crudobj.getData('ok').then((result){
              setState(() {
              notes = result; 
              });
            });
            },
          )
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.green[200],
        child: TabBar(
          controller: controller,
          tabs: <Widget>[
            Icon(Icons.note_add,size:50.0,),
            Icon(Icons.photo,size: 50.0,)
          ],
          indicatorColor: Colors.white,
        ),
      ),
      body:TabBarView(
      controller: controller,
      children: <Widget>[
        noteList(),
        // pp.ProfilePage(),
      ],
    ),
  );
}

  Widget noteList(){
    if(notes!=null){
      return ListView.builder(
        itemCount: notes.documents.length,
        padding: EdgeInsets.all(5.0),
        itemBuilder:(context,i){
          return  ListTile(
                leading: Icon(Icons.note),
                title: 
                  Text(notes.documents[i].data['NoteTitle'],
                  style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                subtitle:
                    Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    Text(notes.documents[i].data['Note'],
                    style: TextStyle(fontSize: 15.0),),
                  
                    Text(notes.documents[i].data['Date'],
                    style: TextStyle(fontSize: 15.0),),
                    ],
                  ),    
                trailing: 
                  Icon(Icons.delete),
                  onLongPress: (){
                    crudobj.deleteData(notes.documents[i].documentID);
                        crudobj.getData('ok').then((result){
                        setState(() {
                        notes = result; 
                        });
                      });
                  },
              );
        }
      );
    }
    else{
      return Center(child: Text("Loading please wait...",
      style: TextStyle(fontSize: 20.0,color: Colors.pink[300],fontWeight: FontWeight.bold),));
      
    }
  }
}
