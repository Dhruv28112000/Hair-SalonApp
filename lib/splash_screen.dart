import 'package:flutter/material.dart';
import 'package:saloon_booking/Login.dart';

//import 'package:saloon_booking/user.dart';

class Splash extends StatefulWidget {
  @override
  _Splash createState() => _Splash();
}

// ignore: camel_case_types
class _Splash extends State<Splash> {
  void initState() {
    var d = Duration(seconds: 3);
    // delayed 3 seconds to next page
    Future.delayed(d, () {
      // to next page and close this page
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Login();
          },
        ),
        (route) => false,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0xff292930),
        body: Center(
          child: Stack(
              //crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(bottom: 45),
                    child: Align(
                      child: Text(
                        "Welcome",
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 30,
                            color: Color(0xffeae9ef)),
                      ),
                    )),
                Positioned(
                  child: Align(
                    //padding: EdgeInsets.only(top: 0),
                    child: Text(
                      "To the Divine Salon",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20,
                          color: Color(0xffeae9ef)),
                    ),
                  ),
                ),
                Positioned(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,

                    //padding: EdgeInsets.only(top: 0),
                    child: Text(
                      "MADE IN INDIA",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20,
                          color: Color(0xffeae9ef)),
                    ),
                  ),
                ),
              ]),
        ));
  }
}
