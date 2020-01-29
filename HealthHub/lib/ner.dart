import 'package:flutter/material.dart';
import 'package:healthhub/services/api.dart';

class NER extends StatefulWidget {
  @override
  _NERState createState() => _NERState();
}

class _NERState extends State<NER> {

   String url;

  var Data;

  String QueryText = 'Jargons will print here...';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title:
        Text("Name Entity Recognization",style: TextStyle(fontSize: 17.0),),
        leading: Icon(Icons.assessment,size: 35.0,),
        
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
               Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    maxLines: null,
                    onChanged: (value) {
                      url = 'http://10.0.2.2:5000/api?text=' + value.toString();
                    },
                    decoration: InputDecoration(
                        hintText: 'Search Anything Here',
                        
                        suffixIcon: GestureDetector(
                            onTap: () async {
                              
                              Data = await Getdata(url);
                              
                              setState(() {
                                QueryText = Data;
                              });
                            },
                            child: Icon(Icons.search))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    QueryText,
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}