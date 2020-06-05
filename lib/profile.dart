import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pproject/app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pproject/gls.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;
int p;

class Proarg{
  final String uid;

  Proarg(this.uid);
}

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

  @override
  initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1));
    _setting();
  }

  String a;

  void _setting(){
    a = "에ㅇ베베";
  }

  getp(int a){
    p = a;
  }

  Firestore db;
  String uid;

  void _gerCur() async{
    final FirebaseUser user = await _auth.currentUser();
    uid = user.uid.toString();
  }

  @override
  Widget build(BuildContext context) {
    final Proarg args = ModalRoute
        .of(context)
        .settings
        .arguments;
    final int p = 10;
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
        body: FutureBuilder(
          future: _auth.currentUser(),
          builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
            if (snapshot.data == null) {
              _gerCur();
              return Center(
                heightFactor: 100,
                child: LinearProgressIndicator(
                ),
              );
            }
            else {
              return StreamBuilder<DocumentSnapshot>(
                stream: Firestore.instance.collection("user")
                    .document(uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  final record = Record.fromSnapshot(snapshot.data);
                  getp(snapshot.data['present']);
                  if (snapshot.data == null) return LinearProgressIndicator();
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
                          Text(
                              "졸업까지 들어야 할 학점: " + record.require.toString(),
                              style: TextStyle(fontSize: 18.0, color: Colors.white),
                              maxLines: 1),
                          SizedBox(height: 30,),
                          Text("여태까지 들은 학점 평균: " +
                              (snapshot.data['sum'] / snapshot.data['present'])
                                  .toString(),
                              style: TextStyle(fontSize: 18.0, color: Colors.white),
                              maxLines: 1),
                          SizedBox(height: 30),
                          RaisedButton(
                            color: Colors.greenAccent,
                            child: Text(
                                "세부현황 보기"
                            ),
                            onPressed: () {
                              print(uid);
                            },
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: CustomPaint(
                                      size: Size(150, 300),
                                      painter: PieChart(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                  );
                },
              );
            }
          },
        ),
/*
        StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance.collection("user")
              .document(args.uid)
              .snapshots(),
          builder: (context, snapshot) {
            getp(snapshot.data['present']);
            if (!snapshot.hasData) return LinearProgressIndicator();
            return Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 30),
                    Text("제 1전공: " + snapshot.data['major1'],
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                        maxLines: 1),
                    SizedBox(height: 30,),
                    Text("제 2전공: " + snapshot.data['major2'],
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                        maxLines: 1),
                    SizedBox(height: 30,),
                    Text("여태까지 들은 학점: " + snapshot.data['present'].toString(),
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                        maxLines: 1),
                    SizedBox(height: 30,),
                    Text(
                        "졸업까지 들어야 할 학점: " + snapshot.data['require'].toString(),
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                        maxLines: 1),
                    SizedBox(height: 30,),
                    Text("여태까지 들은 학점 평균: " +
                        (snapshot.data['sum'] / snapshot.data['present'])
                            .toString(),
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                        maxLines: 1),
                    SizedBox(height: 30),
                    RaisedButton(
                      color: Colors.greenAccent,
                      child: Text(
                          "세부현황 보기"
                      ),
                      onPressed: () {
                        print(uid);
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: CustomPaint(
                                size: Size(150, 300),
                                painter: PieChart(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
            );
          },
        )
      // _buildBody(context),
    );*/
    );
  }
    void _signOut() async {
      await _auth.signOut();
    }
}

class PieChart extends CustomPainter {
  
  int percentage = p;
  double textScaleFactor = 1.5;

  @override
  void paint(Canvas canvas, Size size) {
  Paint paint = Paint() // 화면에 그릴 때 쓸 Paint를 정의합니다.
  ..color = Colors.white
  ..strokeWidth = 30.0 // 선의 길이를 정합니다.
  ..style = PaintingStyle.stroke // 선의 스타일을 정합니다. stroke면 외곽선만 그리고, fill이면 다 채웁니다.
  ..strokeCap = StrokeCap.round; // stroke의 스타일을 정합니다. round를 고르면 stroke의 끝이 둥글게 됩니다.

  double radius = min(size.width / 1.2 - paint.strokeWidth / 2 , size.height / 2 - paint.strokeWidth/2); // 원의 반지름을 구함. 선의 굵기에 영향을 받지 않게 보정함.
  Offset center = Offset(size.width / 2, size.height/ 2); // 원이 위젯의 가운데에 그려지게 좌표를 정함.

  canvas.drawCircle(center, radius, paint); // 원을 그림.

  double arcAngle = 2 * 3.14 * (percentage / 133); // 호(arc)의 각도를 정함. 정해진 각도만큼만 그리도록 함.

  paint..color = Colors.greenAccent; // 호를 그릴 때는 색을 바꿔줌.
  canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -3.14 / 2, arcAngle, false, paint); // 호(arc)를 그림.

  drawText(canvas, size, "$percentage / 133",); // 텍스트를 화면에 표시함.
  }

  // 원의 중앙에 텍스트를 적음.
  void drawText(Canvas canvas, Size size, String text) {
  double fontSize = getFontSize(size, text);

  TextSpan sp = TextSpan(style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.white), text: text); // TextSpan은 Text위젯과 거의 동일하다.
  TextPainter tp = TextPainter(text: sp, textDirection: TextDirection.ltr);

  tp.layout(); // 필수! 텍스트 페인터에 그려질 텍스트의 크기와 방향를 정함.
  double dx = size.width / 2 - tp.width / 2;
  double dy = size.height / 2 - tp.height / 2;

  Offset offset = Offset(dx, dy);
  tp.paint(canvas, offset);
  }

  // 화면 크기에 비례하도록 텍스트 폰트 크기를 정함.
  double getFontSize(Size size, String text) {
  return size.width / text.length * textScaleFactor;
  }

  @override
  bool shouldRepaint(PieChart old) {
  return old.percentage != percentage;
  }
}

