import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saloon_booking/detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:saloon_booking/Login.dart';
//import 'package:sloon/detail.dart';

const List stylishData = [
  {
    'stylistName': 'Stylish A',
    'rateAmount': '100',
    'imgUrl': 'images/stylist1.png',
    'bgColor': Color(0xffFFF0EB),
  },
  {
    'stylistName': 'Stylish B',
    'rateAmount': '150',
    'imgUrl': 'images/stylist2.png',
    'bgColor': Color(0xffEBF6FF),
  },
  {
    'stylistName': 'Stylish C',
    'rateAmount': '150',
    'imgUrl': 'images/stylist3.png',
    'bgColor': Color(0xffFFF3EB),
  }
];

class Homepage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {
  /*  FirebaseUser user;
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser currentUser;
  Future<FirebaseUser> getUserData() async {
    try {
      currentUser = await auth.currentUser();
      assert(user.uid == currentUser.uid);
      print(currentUser);
      print(currentUser.phoneNumber);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.getString("Username");
      print("User Name  : ${currentUser.displayName}");
    } catch (e) {}
    return currentUser;
  }

  void initstate() {
    print("hello");
    //super.initState();
    //
    getUserData();
  } */

  //String Username;
  // Future<void> getUserData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //  Username = prefs.getString('UserName');
  //  setState(() {});
  // }

  // final FirebaseAuth auth = FirebaseAuth.instance;
  // ignore: non_constant_identifier_names
  // String UserId = '';
  //getCurrentUser() async {
  //  final FirebaseUser user = await auth.currentUser();
  // final uid = user.uid;
  // Similarly we can get email as well
  ////final uemail = user.email;
  //  UserId = uid;
  //Useremail = uemail;
  //print('User ID:  '+UserId);
  // print("Updated");
  //print(uemail);
  //}

  //FirebaseAuth auth;
  // const FirebaseUser currentUser = auth.currentUser as FirebaseUser;
  /*  void initState() {
    getCurrentUser();
    setState(() {});

    super.initState();
  }  */
// ShedPreferences prefs = await SharedPreferences.getInstance();
  // prefs.getString(currentuser);
  //
  //
  //
  /*  void initState() {
     SharedPreferences prefs = await SharedPreferences.getInstance();
       var Username = prefs.getString('UserName');
       setState(() {});

  } */

  @override
  Widget build(BuildContext context) {
    //  print("User Name  : ${currentUser.displayName}");
    return Scaffold(
      backgroundColor: Color(0xff292930),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Stylist :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      StylistCard(stylishData[0], 0),
                      StylistCard(stylishData[1], 1),
                      StylistCard(stylishData[2], 2),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StylistCard extends StatelessWidget {
  final stylist;

  final i;
  StylistCard(this.stylist, this.i);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4 - 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: stylist['bgColor'],
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 20,
            right: -60,
            child: Image.asset(
              stylist['imgUrl'],
              width: MediaQuery.of(context).size.width * 0.60,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 40, left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  stylist['stylistName'],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                MaterialButton(
                  onPressed: () {
                    // print("Hiiiiiiiiiiii " + stylist['stylistName']);
                    // print("Hiiiiiiiiiiii " + stylist['imgUrl']);
                    // print("Hiiiiiiiiiiii " + stylist['bgColor']);
                    //
                    if (i == 0) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(stylishData[0])));
                    } else if (i == 1) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(stylishData[1])));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(stylishData[2])));
                    }
                  },
                  color: Color(0xff292930),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'View Profile',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
