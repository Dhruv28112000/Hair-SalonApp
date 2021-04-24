import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:saloon_booking/Login.dart';
import 'package:saloon_booking/homepage.dart';

class Signup extends StatefulWidget {
  @override
  _Signup createState() => _Signup();
}

class _Signup extends State<Signup> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final fb = FirebaseDatabase.instance.reference().child("Users");
  String errorMessage = '';
  String successMessage = '';
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  String _emailId;
  String _password;
  final _name = TextEditingController(text: '');

  final _emailIdController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  final _confirmPasswordController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0xff292930),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: ListView(
              children: [
                Image.asset('images/logo.png'),
                Form(
                    key: _formStateKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //Image.asset(''),

                          //SizedBox(height: size.height * 0.03),
                          TextFormField(
                            cursorColor: Colors.white,
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.emailAddress,
                            controller: _name,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 0.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0)),
                              labelStyle: TextStyle(color: Colors.white),
                              //fillColor: Colors.white,
                              //contentPadding:
                              //EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                              labelText: 'Full Name',
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          TextFormField(
                            onSaved: (value) {
                              _emailId = value;
                            },
                            validator: validateEmail,
                            cursorColor: Colors.white,
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailIdController,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 0.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0)),
                              labelStyle: TextStyle(color: Colors.white),
                              //fillColor: Colors.white,
                              //contentPadding:
                              //EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                              labelText: 'Email Id',
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            validator: validatePassword,
                            obscureText: true,
                            onSaved: (value) {
                              _password = value;
                            },
                            controller: _passwordController,
                            cursorColor: Colors.white,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 0.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0)),
                              labelStyle: TextStyle(
                                  color: Colors.white, fontFamily: "Segoe UI"),
                              //fillColor: Colors.white,
                              //contentPadding:
                              //EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                              labelText: 'Password',
                            ),
                          ),

                          TextFormField(
                            validator: validateConfirmPassword,
                            obscureText: true,
                            onSaved: (value) {
                              _password = value;
                            },
                            controller: _confirmPasswordController,
                            cursorColor: Colors.white,
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 0.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0)),
                              labelStyle: TextStyle(
                                  color: Colors.white, fontFamily: "Segoe UI"),
                              //fillColor: Colors.white,
                              //contentPadding:
                              //EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                              labelText: 'Confirm Password',
                            ),
                          ),
                          SizedBox(
                            height: 45,
                          ),

                          MaterialButton(
                            elevation: 0,
                            minWidth: double.maxFinite,
                            height: 50,
                            onPressed: () {
                              if (_formStateKey.currentState.validate()) {
                                _formStateKey.currentState.save();
                                signUp(_emailId, _password).then((user) async {
                                  if (user != null) {
                                    print('Registered Successfully.');
                                    setState(() {
                                      successMessage =
                                          'Registered Successfully.\nYou can now navigate to Login Page.';
                                      Navigator.pushReplacement(
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
                              }
                            },
                            color: Color(0xff25bcbb),
                            child: Text('SignIn',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            textColor: Colors.white,
                          ),

                          Container(
                              child: Row(
                            children: <Widget>[
                              Text(
                                "Already  have an  account",
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 15,
                                    color: Color(0xffeae9ef)),
                              ),
                              FlatButton(
                                textColor: Colors.blue,
                                child: Text(
                                  'Log In',
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    new MaterialPageRoute(
                                      builder: (context) => Login(),
                                    ),
                                  );
                                },
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          )),
                        ]))
              ],
            )));
  }

  Future<FirebaseUser> signUp(email, password) async {
    //fb.child(_emailId).set(true).then((value){print("Done");});
    try {
      FirebaseUser user = (await auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      //String userid =user.uid;
      //fb.child(user.uid).set(true).then((value) {
      // print("Done");
      // });
      assert(user != null);
      assert(await user.getIdToken() != null);
      return user;
    } catch (e) {
      handleError(e);
      return null;
    }
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        setState(() {
          errorMessage = 'Email Id already Exist!!!';
        });
        break;
      default:
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
    if (value.trim().isEmpty || value.length < 6 || value.length > 14) {
      return 'Minimum 6 & Maximum 14 Characters!!!';
    }
    return null;
  }

  String validateConfirmPassword(String value) {
    if (value.trim() != _passwordController.text.trim()) {
      return 'Password Mismatch!!!';
    }
    return null;
  }
}
