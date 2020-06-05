import 'dart:wasm';

import 'package:flutter/material.dart';
import 'package:pproject/app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';


class ZZarg{
  final String uid;
  ZZarg(this.uid);
}

class Record {
  final String name;
  final int credit;
  int heart;
  final DocumentReference reference;


  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        name = map['name'],
        heart = map['heart'],
        credit = map['credit'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}

class ZzPage extends StatefulWidget {
  @override
  _ZzPageState createState() => _ZzPageState();
}


class _ZzPageState extends State<ZzPage> {

  @override

  FirebaseUser user;
  bool contain = false;
  int toggle =0;
  String snap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[400],
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          title: Text('전산전자공학부'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
              ),
              onPressed: () {

              },
            ),
          ]
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('zz').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      children: snapshot.map((data) => _buildListItem(context, data)).toList()
    );
  }

  void checkIfLikedOrNot(String uid, String name) async{
    DocumentSnapshot ds = await Firestore.instance.collection('user')
        .document(uid)
        .collection('class').document(name).get();
    this.setState(() {
      contain = ds.exists;
    });
  }

  static Future<bool> con(String uid, String name) async{
    DocumentSnapshot a = await Firestore.instance.collection('user').document(uid).collection('class').document(name).get();
    Future<bool> re = Future.value(true);
    if(a.exists){
      re = Future<bool>.value(true);
    }
    else {
      re = Future<bool>.value(false);
    }

    return re;
  }

    Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
      final ZZarg args = ModalRoute.of(context).settings.arguments;
      final record = Record.fromSnapshot(data);
      var a = con(args.uid,record.name);
      return FutureBuilder(
        future: a,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
          if(snapshot.data == null) {
            return Center(
              heightFactor: 100,
              child: LinearProgressIndicator(
              ),
            );
          }
          return ListTile(
            leading: IconButton (
                icon: snapshot.data ? Icon(Icons.favorite, color: Colors.red) : Icon(Icons.favorite_border, color: Colors.red),
            onPressed: (){
              setState(() {
                if(!snapshot.data){
                  Firestore.instance.collection('user').document(args.uid).collection("class").document(record.name).setData({"name": record.name, "grade" : 0, "credit": record.credit});
                  Firestore.instance.collection('user').document(args.uid).updateData({"present" : FieldValue.increment(record.credit)});
                  Firestore.instance.collection('user').document(args.uid).updateData({"require" : FieldValue.increment(-record.credit)});
                }
                else{
                  Firestore.instance.collection('user').document(args.uid)
                      .collection("class").document(record.name)
                      .delete();
                  Firestore.instance.collection('user').document(args.uid).updateData({"present" : FieldValue.increment(-record.credit)});
                  Firestore.instance.collection('user').document(args.uid).updateData({"require" : FieldValue.increment(record.credit)});
                }
              });
            },
          ),
          title: Text(record.name, style: TextStyle(color: Colors.white),),
          );
        }
      );
/*

    return ListTile (
        leading: IconButton (
          icon: await con(args.uid, record.name) ? Icon(Icons.favorite, color: Colors.red) : Icon(Icons.favorite_border, color: Colors.red),
          onPressed: (){
            setState(() {
              checkIfLikedOrNot(args.uid, record.name);
              if(!contain){
                Firestore.instance.collection('user').document(args.uid).
                collection("class").document(record.name)
                    .setData({"name": record.name});
              }
              else{
                Firestore.instance.collection('user').document(args.uid)
                    .collection("class").document(record.name)
                    .delete();
              }
            });
            },
        ),
        title: Text(record.name, style: TextStyle(color: Colors.white),),
    );
  }
*/
    }
}