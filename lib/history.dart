import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';

class CmdHistory extends StatefulWidget {
  @override
  _CmdHistoryState createState() => _CmdHistoryState();
}

class _CmdHistoryState extends State<CmdHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "History",
          style: TextStyle(
              fontFamily: 'Android SC',
              fontWeight: FontWeight.w100,
              fontStyle: FontStyle.italic),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("command").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot history = snapshot.data.docs[index];

                  return Card(
                    color: Colors.black,
                    child: ListTile(
                      title: Text(
                        history.data()["command"],
                        style: TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(
                        history.data()["output"],
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  );
                });
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(child: Center(child: CircularProgressIndicator()));
          } else {
            {
              return Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.warning),
                    ),
                    Text('Error in loadind data')
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}
