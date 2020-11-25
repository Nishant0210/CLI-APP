import 'package:FirestoreApp/cliPage.dart';
import 'package:FirestoreApp/history.dart';
import 'package:FirestoreApp/login.dart';
import 'package:FirestoreApp/register.dart';
import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: "login",
      routes: {
        "reg": (context) => MyReg(),
        "login": (context) => MyLogin(),
        "cli": (context) => MyCLI(),
        "history": (context) => CmdHistory(),
      },
    ),
  );
}
