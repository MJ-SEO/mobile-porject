import 'package:flutter/material.dart';
import 'package:pproject/app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ZZarg{
  final String uid;
  ZZarg(this.uid);
}

class Record {
  final String name;
  final int credit;
  final DocumentReference reference;


  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        name = map['name'],
        credit = map['credit'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}

class ZzPage extends StatefulWidget {
  @override
  _ZzPageState createState() => _ZzPageState();
}

class _ZzPageState extends State<ZzPage> {
  bool _contain = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[400],
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          title: Text('전산전자공학부'),
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
      stream: Firestore.instance.collection('zz').snapshots(),
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
    final ZZarg args = ModalRoute.of(context).settings.arguments;
    final record = Record.fromSnapshot(data);
    return ListTile(
        leading: IconButton(
          icon: Icon(Icons.favorite, color: Colors.red,),
          onPressed: (){
            setState(() {

            });
            Firestore.instance.collection('user').document(args.uid).collection("class").document(record.name).
            setData({"name" : record.name});
          },
        ),
        title: Text(record.name, style: TextStyle(color: Colors.white),),
    );
  }

}