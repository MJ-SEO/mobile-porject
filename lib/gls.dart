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

 // @override
 // String toString() => "Record<$name:$price>";
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

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final Glsarg args = ModalRoute.of(context).settings.arguments;
    final record = Record.fromSnapshot(data);
    return ListTile(
        leading: IconButton(
          icon: record.heart == 0? Icon(Icons.favorite_border, color: Colors.red,)
          : Icon(Icons.favorite, color: Colors.red,),
          onPressed: (){
            setState(() {
              record.heart == 0? Firestore.instance.collection('gls').document(record.name).updateData({'heart': 1})
                  :Firestore.instance.collection('gls').document(record.name).updateData({'heart': 0});
            });
            if(record.heart==0){
                Firestore.instance.collection('user').document(args.uid).updateData({"present" : FieldValue.increment(record.credit)});
                Firestore.instance.collection('user').document(args.uid).updateData({"require" : FieldValue.increment(-record.credit)});
            }
            else{
              Firestore.instance.collection('user').document(args.uid).updateData({"present" : FieldValue.increment(-record.credit)});
              Firestore.instance.collection('user').document(args.uid).updateData({"require" : FieldValue.increment(record.credit)});
            }
          },
        ),
        title: Text(record.name, style: TextStyle(color: Colors.white),),
    );
  }

}