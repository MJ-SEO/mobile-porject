import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pproject/app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pproject/gls.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;
TextEditingController _newEvaluation = TextEditingController();
TextEditingController _newEvaluation2 = TextEditingController();

class Narg{
  final String name;
  final String major;
  final String uid;

  Narg(this.name, this.major, this.uid);
}

class Record {
  final String eval;
  final int star;
  final DocumentReference reference;


  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['evaluation'] != null),
        star = map['stars'],
        eval = map['evaluation'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

// @override
// String toString() => "Record<$name:$price>";
}

class RecommendPage extends StatefulWidget {
  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> {

  @override
  initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1));
  }

  String a;

  Firestore db;
  String uid;

  void _gerCur() async {
    final FirebaseUser user = await _auth.currentUser();
    uid = user.uid.toString();
  }

  @override
  Widget build(BuildContext context) {
    final Narg args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          title: Text(args.name),
        ),
        body: _buildBody(context),
        floatingActionButton: FloatingActionButton(
          onPressed: showCreateDialog,
          child: const Icon(Icons.add),
          backgroundColor: Colors.greenAccent,
        )
    );
  }

  void showCreateDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("강의평을 남겨주세요"),
          content: Container(
            height: 130,
            child: Column(
              children: <Widget>[
                TextField(
                  autofocus: true,
                  controller: _newEvaluation,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "별점을 입력해 주세요(1~5)",
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  autofocus: true,
                  controller: _newEvaluation2,
                  decoration: InputDecoration(
                    hintText: "강의평을 입력해주세요",
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("ADD"),
              onPressed: () {
                createDoc(int.parse(_newEvaluation.text) ,_newEvaluation2.text);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void createDoc(int a, String e) {
    final Narg args = ModalRoute.of(context).settings.arguments;
    Firestore.instance.collection(args.major).document(args.name).collection('evaluation').document(args.uid).setData({
      "evaluation" : e,
      "stars" : a,
    });
  }

  Widget _buildBody(BuildContext context) {
    final Narg args = ModalRoute.of(context).settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection(args.major).document(args.name).collection('evaluation').snapshots(),
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

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    SizedBox(height: 50);
    final record = Record.fromSnapshot(data);
          return ListTile(
            leading: Text(record.star.toString(), style: TextStyle(color: Colors.white, fontSize: 20.0)),
            title: Text(record.eval, style: TextStyle(color: Colors.white)),
          );
  }
}
