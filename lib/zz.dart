import 'package:flutter/material.dart';
import 'package:pproject/app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

final FirebaseAuth _auth = FirebaseAuth.instance;

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

  String uid;

  void _gerCur() async{
    final FirebaseUser user = await _auth.currentUser();
    uid = user.uid.toString();
  }

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
      stream: Firestore.instance.collection('zz').orderBy("name").snapshots(),
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

  static Future<bool> con(String uid, String name) async{
    DocumentSnapshot a = await Firestore.instance.collection('user').document(uid).collection('class').document(name).get();
    if(a.exists){
      return Future<bool>.value(true);
    }
    else {
      return Future<bool>.value(false);
    }
  }

    Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
      SizedBox(height: 50);
      final ZZarg args = ModalRoute.of(context).settings.arguments;
      final record = Record.fromSnapshot(data);
      return FutureBuilder(
        future: con(args.uid,record.name),
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
                  _gerCur();
              setState(() {
                if(!snapshot.data){
                  Firestore.instance.collection('user').document(uid).collection("class").document(record.name).setData({"name": record.name, "grade" : 0, "credit": record.credit});
                  Firestore.instance.collection('user').document(uid).updateData({"present" : FieldValue.increment(record.credit)});
                  Firestore.instance.collection('user').document(uid).updateData({"require" : FieldValue.increment(-record.credit)});
                }
                else{
                  Firestore.instance.collection('user').document(uid)
                      .collection("class").document(record.name)
                      .delete();
                  Firestore.instance.collection('user').document(uid).updateData({"present" : FieldValue.increment(-record.credit)});
                  Firestore.instance.collection('user').document(uid).updateData({"require" : FieldValue.increment(record.credit)});
                }
              });
            },
          ),
          title: Text(record.name, style: TextStyle(color: Colors.white),),
          trailing: IconButton(
            icon: Icon(Icons.chat, color: Colors.white),

          ),
          );
        }
      );
    }
}