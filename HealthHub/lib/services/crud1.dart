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
  Future<void> addData(data,tablename,BuildContext context) async{
    if(checksignin()){
      
        Firestore.instance.collection(tablename).add(data).catchError((e){
        print(e);
        });
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
    Firestore.instance.collection("token").document(selectedDoc).updateData(newValue).catchError((e){
      print(e);
    });
  }
  void deleteData(docId){
    Firestore.instance.collection("token").document(docId).delete().catchError((e){
      print(e);
    });
  }
  void deleteData1(docId){
    Firestore.instance.collection("messages").document(docId).delete().catchError((e){
      print(e);
    });
  }
  void deleteData2(docId){
    Firestore.instance.collection("manage_token_status").document(docId).delete().catchError((e){
      print(e);
    });
  }
}