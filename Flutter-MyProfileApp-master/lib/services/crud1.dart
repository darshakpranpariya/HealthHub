import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CRUD1{

  bool checksignin(){
    if(FirebaseAuth.instance.currentUser()!=null)
      return true;
    else
      return false;
  }
  Future<void> addData(signupdata,BuildContext context) async{
    if(checksignin()){
      
        Firestore.instance.collection('patient').add(signupdata).catchError((e){
        print(e);
        print("helooooo");
        });
     
     
        // Firestore.instance.collection("doctor").add(signupdata).catchError((e){
        // print(e);
        // });
    }
    else{
      final snackBar = SnackBar(content: Text('Please Do Login'));
      Scaffold.of(context).showSnackBar(snackBar);
    } 
  }

  getData(String table) async{
    return await Firestore.instance.collection(table).getDocuments();
  }
  
  updateData(selectedDoc,newValue){
    Firestore.instance.collection("testcrud").document(selectedDoc).updateData(newValue).catchError((e){
      print(e);
    });
  }
  void deleteData(docId){
    Firestore.instance.collection("testcrud").document(docId).delete().catchError((e){
      print(e);
    });
  }
}