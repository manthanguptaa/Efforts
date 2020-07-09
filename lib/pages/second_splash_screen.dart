import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:effors/constants/loader.dart';
import 'package:effors/models/user.dart';
import 'package:effors/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => MyHomePage())));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: StreamBuilder(
            stream: Firestore.instance
                .collection("user")
                .document(user.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Loader();
              }
              var country = snapshot.data;
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height/5),
                  child: Wrap(
                    children: [
                      Image.asset("assets/emoji.png"),
                      Padding(
                        padding:EdgeInsets.only(top:14.0),
                        child: RichText(
                          text: TextSpan(
                              style: TextStyle(fontSize: 25.0, color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: "Fir Muskuraayega",
                                    style: GoogleFonts.lato()),
                                TextSpan(
                                    text: " ${country["country"]}",
                                    style: GoogleFonts.lobster(
                                        fontWeight: FontWeight.w400))
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
