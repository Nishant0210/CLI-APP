import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyReg extends StatefulWidget {
  @override
  _MyRegState createState() => _MyRegState();
}

class _MyRegState extends State<MyReg> {
  var authc = FirebaseAuth.instance;
  var email;
  var password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
        title: Text(
          "Registration",
          style: TextStyle(
              fontFamily: 'Android SC',
              fontWeight: FontWeight.w100,
              fontStyle: FontStyle.italic),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 300,
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black26,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: AssetImage('assets/images/lbg3.jpg'),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 250,
                  height: 40,
                  child: TextField(
                    cursorColor: Colors.amberAccent,
                    onChanged: (value) {
                      email = value;
                    },
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amberAccent),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: EdgeInsets.only(
                          left: 20, bottom: 11, top: 11, right: 20),
                      hintText: "Email ID",
                      prefixIcon: Icon(
                        Icons.mail,
                        color: Colors.white60,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 250,
                  height: 40,
                  child: TextField(
                    obscureText: true,
                    cursorColor: Colors.amberAccent,
                    onChanged: (value) {
                      password = value;
                    },
                    autocorrect: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amberAccent),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: EdgeInsets.only(
                          left: 20, bottom: 11, top: 11, right: 20),
                      hintText: "password",
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: Colors.white60,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Material(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.circular(20),
                  child: MaterialButton(
                    onPressed: () async {
                      try {
                        var user = await authc.createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );

                        if (user.additionalUserInfo.isNewUser == true) {
                          Fluttertoast.showToast(
                              msg: "Successfully Registered !!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.amber,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          Navigator.pushNamed(context, "login");
                        }
                      } catch (e) {
                        Fluttertoast.showToast(
                            msg:
                                "The email address is already in use by another account",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.amber,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
