import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pproject/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class ChoicePage extends StatefulWidget {
  @override
  _ChoicePageState createState() => _ChoicePageState();
}

class _ChoicePageState extends State<ChoicePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 300),
              RaisedButton(
                color: Colors.greenAccent,
                child: Text('선택완료'),
                onPressed: () async{
                  final FirebaseUser user = await _auth.currentUser();
                  final String uid = user.uid.toString();
                  final snapShot = await Firestore.instance
                      .collection('user')
                      .document(uid)
                      .get();
                  if(snapShot == null || !snapShot.exists) {
                    createDoc(uid);
                    print("생성");
                  }
                  else{
                    print("이미 있음");
                  }
                  print(uid);
                  Navigator.pushNamed(
                      context,
                      '/Home',
                      arguments: PassArg(uid),
                  );
                },
              )
            ],
          ),
        )
    );
  }

  void createDoc(String uid) async{
    Firestore.instance.collection('user').document(uid).setData({
      "major1" : "컴퓨터 공학",
      "major2" : "경영학",
      "present" : 0,
      "require" : 133,
      "average" : 0,
    });
  }

}
