import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pproject/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chips_choice/chips_choice.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class ChoicePage extends StatefulWidget {
  @override
  _ChoicePageState createState() => _ChoicePageState();
}

class _ChoicePageState extends State<ChoicePage> {

  int tag = 1;
  List<String> tags = [];
  List<String> tags2 = [];

  List<String> options = [
    '경영학(33)', '컴퓨터공학(33)', '컴퓨터공학(45)',
    '시각디자인(33)', '제품디자인(33)', '경제학(33)',
    '경영학(45)', '국제지역학(33)', 'GM(33)', '상담심리학(33)',
    '전자제어공학(33)',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
        body:ListView(
          padding: EdgeInsets.fromLTRB(10, 100, 10, 10),
          children: <Widget>[
          Content(
            title: '1전공',
            child: ChipsChoice<String>.multiple(
              value: tags,
              options: ChipsChoiceOption.listFrom<String, String>(
                source: options,
                value: (i, v) => v,
                label: (i, v) => v,
              ),
              onChanged: (val) => setState(() => tags = val),
            ),
        ),
            SizedBox(height: 60),
            Content(
              title: '2전공',
              child: ChipsChoice<String>.multiple(
                value: tags2,
                options: ChipsChoiceOption.listFrom<String, String>(
                  source: options,
                  value: (i, v) => v,
                  label: (i, v) => v,
                ),
                onChanged: (val) => setState(() => tags2 = val),
              ),
            ),
        SizedBox(height: 50),
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
        ),
            RaisedButton(
              child: Text("ddddddd"),
              onPressed: (){
                print(tags);
                print(tags2);
              }
            )
      ]
    )
    );
  }

  void createDoc(String uid) async{
    Firestore.instance.collection('user').document(uid).setData({
      "major1" : tags.toString(),
      "major2" : tags2.toString(),
      "present" : 0,
      "require" : 133,
      "average" : 0,
      "sum" : 0,
    });
  }

}

class Content extends StatelessWidget {

  final String title;
  final Widget child;

  Content({
    Key key,
    @required this.title,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(15),
            color: Colors.blueGrey[50],
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w500
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
