import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:saloon_booking/homepage.dart';
import 'package:saloon_booking/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

FirebaseUser currentUser;
String _email, _password;
final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = new GoogleSignIn();
bool isGoogleSignIn = false;
String errorMessage = '';
String successMessage = '';
final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();

final _emailIdController = TextEditingController(text: '');
final _passwordController = TextEditingController(text: '');

class _Login extends State<Login> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0xff292930),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: ListView(children: [
              Image.asset('images/logo.png'),
              SizedBox(
                height: 15,
              ),
              Form(
                key: _formStateKey,
                // ignore: deprecated_member_use
                autovalidate: true,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //SizedBox(height: size.height * 0.03),
                      TextFormField(
                        validator: validateEmail,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 0.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                          labelStyle: TextStyle(color: Colors.white),
                          //fillColor: Colors.white,
                          //contentPadding:
                          //EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                          labelText: 'Email Id',
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        obscureText: true,
                        validator: validatePassword,
                        onSaved: (value) {
                          _password = value;
                        },
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 0.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                          labelStyle: TextStyle(
                              color: Colors.white, fontFamily: "Segoe UI"),
                          //fillColor: Colors.white,
                          //contentPadding:
                          //EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                          labelText: 'Password',
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ]),
              ),
              SizedBox(
                height: 50,
              ),
              MaterialButton(
                elevation: 0,
                minWidth: double.maxFinite,
                height: 50,
                onPressed: () {
                  if (_formStateKey.currentState.validate()) {
                    _formStateKey.currentState.save();
                    signIn(_email, _password).then((user) async {
                      if (user != null) {
                        print('Logged in successfully.');
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('email', _email);
                        print(_email);
                        setState(() {
                          Get.off(Homepage());
                        });
                      } else {
                        print('Error while Login.');
                      }
                    });
                  }
                },
                color: Color(0xff25bcbb),
                child: Text('Login',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                textColor: Colors.white,
              ),
              SizedBox(height: 20),
              MaterialButton(
                elevation: 0,
                minWidth: double.maxFinite,
                height: 50,
                onPressed: () {
                  googleSignin(context).then((user) {
                    if (user != null) {
                      print('Logged in successfully.');
                      setState(() {
                        isGoogleSignIn = true;
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (context) => Homepage(),
                          ),
                        );
                      });
                    } else {
                      print('Error while Login.');
                    }
                  });
                },
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.google),
                    SizedBox(width: 10),
                    Text('Sign-in using Google',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
                textColor: Colors.white,
              ),
              Container(
                  child: Row(
                children: <Widget>[
                  Text(
                    "Does not have account",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 15,
                        color: Color(0xffeae9ef)),
                  ),
                  FlatButton(
                    textColor: Colors.blue,
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      //signup screen
                      //
                      Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => Signup(),
                        ),
                      );
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              )),
            ])));
  }

  Future<FirebaseUser> signIn(String email, String password) async {
    try {
      FirebaseUser user = (await auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;

      assert(user != null);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await auth.currentUser();
      assert(user.uid == currentUser.uid);
      return user;
    } catch (e) {
      handleError(e);
      return null;
    }
  }

  Future<FirebaseUser> googleSignin(BuildContext context) async {
    try {
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final FirebaseUser user =
          (await auth.signInWithCredential(credential)).user;
      assert(user.email != null);
      assert(user.displayName != null);
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      currentUser = await auth.currentUser();
      assert(user.uid == currentUser.uid);
      print(currentUser);
      print(currentUser.phoneNumber);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('UserName', "${currentUser.displayName}");
      print("User Name  : ${currentUser.displayName}");
    } catch (e) {
      handleError(e);
    }
    return currentUser;
  }

  Future<bool> googleSignout() async {
    await auth.signOut();
    await googleSignIn.signOut();
    return true;
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_USER_NOT_FOUND':
        setState(() {
          errorMessage = 'User Not Found!!!';
        });
        break;
      case 'ERROR_WRONG_PASSWORD':
        setState(() {
          errorMessage = 'Wrong Password!!!';
        });
        break;
    }
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty || !regex.hasMatch(value))
      return 'Enter Valid Email Id!!!';
    else
      return null;
  }

  String validatePassword(String value) {
    if (value.trim().isEmpty) {
      return 'Password is empty!!!';
    }
    return null;
  }
}
