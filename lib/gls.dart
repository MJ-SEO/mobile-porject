import 'package:flutter/material.dart';
import 'package:pproject/app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Glsarg{
  final String uid;
  Glsarg(this.uid);
}

class Record {
  final String name;
  int heart;
  final int credit;
  final DocumentReference reference;


  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        name = map['name'],
        heart = map['heart'],
        credit = map['credit'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}

class GlsPage extends StatefulWidget {
  @override
  _GlsPageState createState() => _GlsPageState();
}

class _GlsPageState extends State<GlsPage> {
  bool _contain = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[400],
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          title: Text('글로벌리더십학부'),
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
      stream: Firestore.instance.collection('gls').snapshots(),
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
    final Glsarg args = ModalRoute.of(context).settings.arguments;
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
  }

}