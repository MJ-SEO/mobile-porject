import 'package:flutter/material.dart';
import 'package:pproject/choice.dart';
import 'package:pproject/login.dart';
import 'package:pproject/home.dart';
import 'package:pproject/mylist.dart';
import 'package:pproject/profile.dart';
import 'package:pproject/gls.dart';
import 'package:pproject/recommend.dart';
import 'package:pproject/zz.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project',
        home: HomePage(),
      initialRoute: '/login',
      routes: {
        '/login' : (context) => LoginPage(),
        '/Home' : (context) => HomePage(),
        '/Profile' : (context) => ProfilePage(),
        '/GLS' : (context) => GlsPage(),
        '/Choice' : (context) => ChoicePage(),
        '/Zz' : (context) => ZzPage(),
        '/Mylist' : (context) => MylistPage(),
        '/Recommend' : (context) => RecommendPage(),
      },
      onGenerateRoute: _getRoute,
    );
  }
  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name != '/login') {
      return null;
    }
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => LoginPage(),
      fullscreenDialog: true,
    );
  }
}
