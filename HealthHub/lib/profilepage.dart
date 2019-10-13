import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        child:Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top:0.0),
              height: 200.0,
              width: 400.0,
              color: Colors.blue[50],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top:210.0),),
              pp(),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top:200.0),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Darshak Ranpariya", style: TextStyle(color: Colors.black,fontSize:18.0,fontWeight: FontWeight.bold),),
                ],
              ),
              Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("AI Developer", style: TextStyle(color: Colors.black,fontSize:18.0,fontWeight: FontWeight.bold),),
                ],
              ),
              Padding(padding: EdgeInsets.only(top:10.0),),
              Container(
                 color: Colors.blue[50],
                child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   
                  children: <Widget>[
                    Text("173", style: TextStyle(color: Colors.black,fontSize:18.0,fontWeight: FontWeight.bold),),
                    Text("24", style: TextStyle(color: Colors.black,fontSize:18.0,fontWeight: FontWeight.bold),),
                    Text("460", style: TextStyle(color: Colors.black,fontSize:18.0,fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              Container(
                 color: Colors.blue[50],
                child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   
                  children: <Widget>[
                    Text("Followers", style: TextStyle(color: Colors.black,fontSize:18.0,fontWeight: FontWeight.bold),),
                    Text("Posts", style: TextStyle(color: Colors.black,fontSize:18.0,fontWeight: FontWeight.bold),),
                    Text("Scores", style: TextStyle(color: Colors.black,fontSize:18.0,fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(top:10.0),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("Hi, I am a AI Developer working for hourly \nbasis. If you wants to contact me to build\nyour product leave a message.\n-------------------------------------------------------------------\n                     Get in touch with Me     ",
                  style: TextStyle(fontSize: 14.0,color: Colors.black,fontStyle: FontStyle.italic),)
                ],
              ),
              Padding(padding: EdgeInsets.only(top:10.0),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ButtonTheme(
                    height: 30.0,
                    minWidth: 100.0,
                    buttonColor: Colors.green[300],
                    child: RaisedButton(
                      child: Text("FOLLOW",style: TextStyle(fontSize: 18.0,),),
                      onPressed: ()=>{},
                      //highlightColor: Colors.blue[100],
                    ),
                  ),
                  ButtonTheme(
                    height: 30.0,
                    minWidth: 80.0,
                    buttonColor: Colors.green[300],
                    child: RaisedButton(
                      child: Text("MESSAGE", style: TextStyle(fontSize: 18.0,),),
                      onPressed: ()=>{},
                     // highlightColor: Colors.blue[50],
                    ),
                  ),
                ],
              )
            ],
          ),
          
        ],
      ),
    ) 
  );
}
  Widget screen(){
    return Container(
      child: Image(
        height: 240.0,
        // width:400.0,
        image: AssetImage("asset/4.jpeg"),
      ),
    );
  }
  Widget pp(){
    return Container(
     child: CircleAvatar(
      backgroundImage: ExactAssetImage("asset/5.JPG"),
      minRadius: 50,
      maxRadius: 70,
      ),
    );
  }
}