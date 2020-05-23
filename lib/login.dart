import 'package:flutter/material.dart';
import 'package:pproject/app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                SizedBox(height: 16.0,),
                Image.network('https://upload.wikimedia.org/wikipedia/commons/0/09/HGU-Emblem-eng2.png', scale: 1.7),
                SizedBox(height: 16.0),
              ],
            ),
            SizedBox(height: 30),
            Container(
              height: 60,
              child: RaisedButton(
                color: Color.fromRGBO(255, 30, 30, 90),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.person, color: Colors.white),
                    Text("      sign in google", style: TextStyle(color: Colors.white, fontSize: 20),),
                  ],
                ),
                onPressed: () async{
                  _signInWithGoogle();
                  Navigator.pushNamed(context, '/Choice');
                },
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              height: 60,
              child: RaisedButton(
                color: Color.fromRGBO(255, 255, 255, 90),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.help, color: Colors.white),
                    Text("      sign in anonymous", style: TextStyle(color: Colors.white, fontSize: 20),),
                  ],
                ),
                onPressed: () async{
                  _signInAn();
                  Navigator.pushNamed(
                    context,
                    '/Choice',
                  );
                },
              ),
            ),
            SizedBox(height: 20,),
            Container(
              height: 60,
              child: RaisedButton(
                color: Color.fromRGBO(123, 123, 123, 90),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.next_week, color: Colors.white),
                    Text("      go main page", style: TextStyle(color: Colors.white, fontSize: 20),),
                  ],
                ),
                onPressed: () async{
                 final FirebaseUser user = await auth.currentUser();
                  if(user == null)
                    print("gsdfg");
                  else
                    Navigator.pushNamed(context, '/Choice');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_signInWithGoogle() async{
  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  final FirebaseUser user =
      (await auth.signInWithCredential(credential)).user;
  assert(user.email != null);
  assert(user.displayName != null);
  assert(!user.isAnonymous);

}

void _signInAn() async{
  final FirebaseUser user = (await auth.signInAnonymously()).user;

  assert(user != null);
  assert(user.isAnonymous);

  final FirebaseUser currentUser = await auth.currentUser();
  assert(user.uid == currentUser.uid);
}

void createDoc(String uid) async{
  Firestore.instance.collection('user').document(uid).setData({
    "class" : '',
    "present" : 0,
    "require" : 133,
  });
}
