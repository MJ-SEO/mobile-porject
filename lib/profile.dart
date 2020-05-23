import 'package:flutter/material.dart';
import 'package:pproject/app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Record {
  final String major1;
  final String major2;
  final int present;
  final int require;
  final int average;
  final DocumentReference reference;


  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['major1'] != null),
        major1 = map['major1'],
        major2 = map['major2'],
        present = map['present'],
        require = map['require'],
        average = map['average'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

// @override
// String toString() => "Record<$name:$price>";
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  FirebaseUser _user;

  void initState() {
    super.initState();
    _prepareService();
  }

  void _prepareService() async {
    _user = await _auth.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.blueGrey,
            title: Text('21600343 서명준'),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                ),
                onPressed: () {
                  _signOut();
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ]
        ),
        body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('user').snapshots(),
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
    final record = Record.fromSnapshot(data);
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 30),
              Text("제 1전공: " + record.major1,
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                  maxLines: 1),
              SizedBox(height: 30,),
              Text("제 2전공: " + record.major2,
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                  maxLines: 1),
              SizedBox(height: 30,),
              Text("여태까지 들은 학점: " + record.present.toString(),
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                  maxLines: 1),
              SizedBox(height: 30,),
              Text("졸업까지 들어야 할 학점: " + record.require.toString(),
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                  maxLines: 1),
              SizedBox(height: 30,),
              Text("여태까지 들은 학점 평균: " + record.average.toString(),
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                  maxLines: 1),
              SizedBox(height: 30),
              RaisedButton(
                color: Colors.greenAccent,
                child: Text(
                    "세부현황 보기"
                ),
                onPressed: () {

                },
              ),
            ]
        ),
      );
  }

    void _signOut() async {
      await _auth.signOut();
    }
}

/*
FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.hasData) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  SizedBox(height: 30),
              Text("제 1전공: 컴퓨터 공학(33)", style: TextStyle(fontSize: 18.0, color: Colors.white), maxLines: 1),
              SizedBox(height: 30,),
              Text("제 2전공: 경영학(33)", style: TextStyle(fontSize: 18.0, color: Colors.white), maxLines: 1),
              SizedBox(height: 30,),
              Text("여태까지 들은 학점: " , style: TextStyle(fontSize: 18.0, color: Colors.white), maxLines: 1),
              SizedBox(height: 30,),
              Text("졸업까지 들어야 할 학점: 57", style: TextStyle(fontSize: 18.0, color: Colors.white), maxLines: 1),
              SizedBox(height: 30,),
              Text("여태까지 들은 학점 평균: 3.99", style: TextStyle(fontSize: 18.0, color: Colors.white), maxLines: 1),
              SizedBox(height: 30),
              RaisedButton(
                color: Colors.greenAccent,
                child: Text(
                    "세부현황 보기"
                ),
                onPressed: (){

                },
              ),
              ]
              )
            );
          }
          else {
            return Text('Loading...');
          }
        },
      ),


      ontainer(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 30),
                Text("전공: 전산전자 공학부", style: TextStyle(fontSize: 18.0, color: Colors.white), maxLines: 1),
                SizedBox(height: 30,),
                Text("여태까지 들은 학점: 76", style: TextStyle(fontSize: 18.0, color: Colors.white), maxLines: 1),
                SizedBox(height: 30,),
                Text("졸업까지 들어야 할 학점: 57", style: TextStyle(fontSize: 18.0, color: Colors.white), maxLines: 1),
                SizedBox(height: 30,),
                Text("여태까지 들은 학점 평균: 3.99", style: TextStyle(fontSize: 18.0, color: Colors.white), maxLines: 1),
                SizedBox(height: 30),
                RaisedButton(
                  color: Colors.greenAccent,
                  child: Text(
                    "세부현황 보기"
                  ),
                  onPressed: (){

                  },
                ),
                RaisedButton(
                  color: Colors.greenAccent,
                  child: Text(
                      "추천학회 및 동아리 정보"
                  ),
                  onPressed: (){

                  },
                )
              ],
            ),
      ),
    );*/