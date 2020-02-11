import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthhub/services/api.dart';
import 'package:requests/requests.dart';

class NER extends StatefulWidget {
  @override
  _NERState createState() => _NERState();
}

class _NERState extends State<NER> {
  String url;
  String final_answer = "";
  var Data;
  var ans = new List();
  String str;
  Map<String, String> jawab;
  // var jawab = new List();
  String QueryText = 'Jargons will print here...';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text(
          "Name Entity Recognization",
          style: TextStyle(fontSize: 17.0),
        ),
        leading: Icon(
          Icons.assessment,
          size: 35.0,
        ),
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
                    str = value.toString();
                  },
                  decoration: InputDecoration(
                      hintText: 'Search Anything Here',
                      suffixIcon: GestureDetector(
                          onTap: () async {
                            Data = await Getdata(str);
                            setState(() {
                              FocusScope.of(context).requestFocus(new FocusNode());
                              ans = Data['denotations'];
                              for (int i = 0; i < ans.length; i++) {
                                String s = "", typee;
                                int b, e;
                                b = ans[i]['span']['begin'];
                                e = ans[i]['span']['end'];
                                for (int j = b; j < e; j++) {
                                  s += str[j];
                                }
                                typee = ans[i]['obj'];
                                String s1 = (i + 1).toString() + ") " + s;
                                s1 += ":" + typee;
                                final_answer += "\n" + s1;
                              }
                              QueryText = final_answer;
                            });
                          },
                          child: Icon(Icons.search))),
                ),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      QueryText,
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
