import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyCLI extends StatefulWidget {
  @override
  _MyCLIState createState() => _MyCLIState();
}

class _MyCLIState extends State<MyCLI> {
  var cmdcontroller = TextEditingController();
  String cmd;
  String cmd2;
  var fsconnect = FirebaseFirestore.instance;

  var out;

  oscommand(cmd) async {
    var url = "http://192.168.43.61/cgi-bin/web.py?x=$cmd&y=$cmd2";
    var response = await http.get(url);

    setState(() {
      out = response.body;
    });
    fsconnect.collection("command").add({
      'command': cmd,
      'output': out,
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: Colors.white60,
        appBar: AppBar(
          title: Row(
            children: [
              Icon(Icons.computer),
              SizedBox(
                width: 10,
              ),
              Text(
                "My CLI",
                style: TextStyle(
                    fontFamily: 'Android SC',
                    fontWeight: FontWeight.w100,
                    fontStyle: FontStyle.italic),
              ),
              SizedBox(
                width: 170,
              ),
              IconButton(
                  icon: Icon(
                    Icons.history,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "history");
                  })
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/rhbg.jpg'),
                  fit: BoxFit.cover)),
          child: Center(
            child: Container(
              width: 300,
              height: 600,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 250,
                    height: 40,
                    child: TextField(
                      controller: cmdcontroller,
                      cursorColor: Colors.red,
                      onChanged: (value) {
                        cmd = value;
                      },
                      autocorrect: false,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.red)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: EdgeInsets.only(
                            left: 20, bottom: 11, top: 11, right: 20),
                        hintText: "Enter Linux Command",
                        prefixIcon: Icon(
                          Icons.keyboard,
                          color: Colors.white60,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton.icon(
                    color: Colors.black38,
                    onPressed: () {
                      oscommand(cmd);
                      cmdcontroller.clear();
                    },
                    label: Text(
                      "Submit",
                    ),
                    icon: Icon(
                      Icons.send,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.black26,
                    width: 250,
                    height: 250,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          color: Colors.black38,
                          child: Text(
                            "Output",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          height: 220,
                          child: SingleChildScrollView(
                            child: Text(
                              out ?? "Waiting ...",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
