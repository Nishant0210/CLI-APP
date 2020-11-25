import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MyLogin extends StatefulWidget {
  @override
  _MyLoginState createState() => _MyLoginState();
}

var authc = FirebaseAuth.instance;

class _MyLoginState extends State<MyLogin> {
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var email;
  var password;
  bool spi = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
        title: Text(
          "My CLI App",
          style: TextStyle(
              fontFamily: 'Android SC',
              fontWeight: FontWeight.w100,
              fontStyle: FontStyle.italic),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: spi,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 300,
              height: 500,
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
                      controller: emailcontroller,
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
                      controller: passwordcontroller,
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
                        emailcontroller.clear();
                        passwordcontroller.clear();
                        setState(() {
                          spi = true;
                        });

                        try {
                          var userSignin =
                              await authc.signInWithEmailAndPassword(
                                  email: email, password: password);
                          print(userSignin);

                          if (userSignin != null) {
                            Navigator.pushNamed(context, "cli");
                            setState(() {
                              spi = false;
                            });
                          }
                        } catch (e) {
                          print(e);
                          Fluttertoast.showToast(
                              msg: "Not Registered or Invalid Credentials",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.amber,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          setState(() {
                            spi = false;
                          });
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text("Don't have an account?"),
                        FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "reg");
                            },
                            child: Text("Create an Account"))
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
