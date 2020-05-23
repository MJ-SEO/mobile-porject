import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pproject/profile.dart';
import 'package:pproject/gls.dart';

class PassArg {
  final String uid;

  PassArg(this.uid);
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final PassArg args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          leading: IconButton(
            icon: Icon(
              Icons.person,
              semanticLabel: 'person',
            ),
            onPressed: (){
                Navigator.pushNamed(
                  context,
                  '/Profile',
              );
            },
          ),
          title: Text('21600343 서명준', textAlign: TextAlign.center), // 여기 로그인 사람 닉네임
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.menu,       // 여기 drawer?
              ),
              onPressed: () {

              },
            ),
          ],
        ),
        body: Container(
          color: Colors.blueGrey,
          child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 7.8 / 9.0,

            padding: EdgeInsets.all(15.0),
            children: <Widget>[
              RaisedButton(
                color: Colors.greenAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.child_care, color: Colors.white, size: 30),
                    SizedBox(height: 20),
                    Text("글로벌리더십\n       학부", style: TextStyle(color: Colors.white, fontSize: 13))
                  ],
                ),
                onPressed: () {
                      print(args.uid);
                      Navigator.pushNamed(context, "/GLS", arguments: Glsarg(args.uid));
                },
              ),
              RaisedButton(
                color: Colors.greenAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.computer, color: Colors.white, size: 30),
                    SizedBox(height: 20),
                    Text("전산전자\n 공학부", style: TextStyle(color: Colors.white, fontSize: 14),)
                  ],
                ),
                onPressed: () {
                  //    Navigator.pushNamed(context, "교양선택 페이지")
                },
              ),
              RaisedButton(
                color: Colors.greenAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.monetization_on, color: Colors.white, size: 30),
                    SizedBox(height: 20),
                    Text("경영경제\n   학부", style: TextStyle(color: Colors.white, fontSize: 13))
                  ],
                ),
                onPressed: () {
                  //    Navigator.pushNamed(context, "교양선택 페이지")
                },
              ),
              RaisedButton(
                color: Colors.greenAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.favorite, color: Colors.white, size: 30),
                    SizedBox(height: 20),
                    Text("생명공학부", style: TextStyle(color: Colors.white, fontSize: 13))
                  ],
                ),
                onPressed: () {
                  //    Navigator.pushNamed(context, "교양선택 페이지")
                },
              ),
              RaisedButton(
                color: Colors.greenAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.public, color: Colors.white, size: 30),
                    SizedBox(height: 20),
                    Text("국제어문학부", style: TextStyle(color: Colors.white, fontSize: 13))
                  ],
                ),
                onPressed: () {
                  //    Navigator.pushNamed(context, "교양선택 페이지")
                },
              ),
              RaisedButton(
                color: Colors.greenAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.chrome_reader_mode, color: Colors.white, size: 30),
                    SizedBox(height: 20),
                    Text("언론정부문화\n        학부", style: TextStyle(color: Colors.white, fontSize: 13))
                  ],
                ),
                onPressed: () {
                  //    Navigator.pushNamed(context, "교양선택 페이지")
                },
              ),
              RaisedButton(
                color: Colors.greenAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.import_contacts, color: Colors.white, size: 30),
                    SizedBox(height: 20),
                    Text("법학부", style: TextStyle(color: Colors.white, fontSize: 13))
                  ],
                ),
                onPressed: () {
                  //    Navigator.pushNamed(context, "교양선택 페이지")
                },
              ),
              RaisedButton(
                color: Colors.greenAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.group, color: Colors.white, size: 30),
                    SizedBox(height: 20),
                    Text("   상담심리\n사회복지학부", style: TextStyle(color: Colors.white, fontSize: 13))
                  ],
                ),
                onPressed: () {
                  //    Navigator.pushNamed(context, "교양선택 페이지")
                },
              ),
              RaisedButton(
                color: Colors.greenAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.build, color: Colors.white, size: 30),
                    SizedBox(height: 20),
                    Text("기계제어\n  공학부", style: TextStyle(color: Colors.white, fontSize: 13))
                  ],
                ),
                onPressed: () {
                  //    Navigator.pushNamed(context, "교양선택 페이지")
                },
              ),
              RaisedButton(
                color: Colors.greenAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.all_inclusive, color: Colors.white, size: 30),
                    SizedBox(height: 20),
                    Text("ICT창업학부", style: TextStyle(color: Colors.white, fontSize: 13))
                  ],
                ),
                onPressed: () {
                  //    Navigator.pushNamed(context, "교양선택 페이지")
                },
              ),
              RaisedButton(
                color: Colors.greenAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.home, color: Colors.white, size: 30),
                    SizedBox(height: 20),
                    Text("   공간환경\n시스템공학부", style: TextStyle(color: Colors.white, fontSize: 13))
                  ],
                ),
                onPressed: () {
                  //    Navigator.pushNamed(context, "교양선택 페이지")
                },
              ),
              RaisedButton(
                color: Colors.greenAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.palette, color: Colors.white, size: 30),
                    SizedBox(height: 20),
                    Text(" 콘텐츠융합\n 디자인학부", style: TextStyle(color: Colors.white, fontSize: 13))
                  ],
                ),
                onPressed: () {
                  //    Navigator.pushNamed(context, "교양선택 페이지")
                },
              ),
              RaisedButton(
                color: Colors.greenAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.account_balance, color: Colors.white, size: 30),
                    SizedBox(height: 20),
                    Text("창의융합교육원\n    (자연과학)", style: TextStyle(color: Colors.white, fontSize: 12))
                  ],
                ),
                onPressed: () {
                  //    Navigator.pushNamed(context, "교양선택 페이지")
                },
              ),
              RaisedButton(
                color: Colors.greenAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.account_balance, color: Colors.white, size: 30),
                    SizedBox(height: 20),
                    Text("창의융합교육원\n    (인문사회)", style: TextStyle(color: Colors.white, fontSize: 12))
                  ],
                ),
                onPressed: () {
                  //    Navigator.pushNamed(context, "교양선택 페이지")
                },
              ),
              RaisedButton(
                color: Colors.greenAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.account_balance, color: Colors.white, size: 30),
                    SizedBox(height: 20),
                    Text("창의융합교육원\n        (공학)", style: TextStyle(color: Colors.white, fontSize: 12))
                  ],
                ),
                onPressed: () {
                  //    Navigator.pushNamed(context, "교양선택 페이지")
                },
              ),
            ],
          ),
        )
    );
  }
}
