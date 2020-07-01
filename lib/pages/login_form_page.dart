import 'package:effors/constants/color.dart';
import 'package:effors/constants/loader.dart';
import 'package:effors/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginFormPage extends StatefulWidget {
  @override
  _LoginFormPageState createState() => _LoginFormPageState();
}

class _LoginFormPageState extends State<LoginFormPage> {
  final AuthService _auth = AuthService();
  String email = "";
  String password = "";
  String error = "";
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final dev_height =
        MediaQuery.of(context).size.height; //height of device screen
    final dev_width = MediaQuery.of(context).size.width;

    final emailField = Container(
        width: dev_width - 80,
        padding: EdgeInsets.only(top: 30.0),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          validator: (String value) {
            if (value.isEmpty) {
              return "Please enter your email";
            }
            Pattern pattern =
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            RegExp regex = new RegExp(pattern);
            if (!regex.hasMatch(value)) return 'Enter Valid Email';
          },
          onChanged: (value) {
            setState(() {
              email = value;
            });
          },
          decoration: InputDecoration(
            hintText: "Email address",
            hintStyle: GoogleFonts.lato(
                fontWeight: FontWeight.w300,
                color: Colors.grey[400],
                fontSize: 18.0),
          ),
        ));

    final passwordField = Container(
        width: dev_width - 80,
        padding: EdgeInsets.only(top: 30.0),
        child: TextFormField(
          validator: (String value) {
            if (value.isEmpty) {
              return "Please enter password";
            }
          },
          onChanged: (value) {
            setState(() {
              password = value;
            });
          },
          decoration: InputDecoration(
            hintText: "Password",
            hintStyle: GoogleFonts.lato(
                fontWeight: FontWeight.w300,
                color: Colors.grey[400],
                fontSize: 18.0),
          ),
          obscureText: true,
        ));

    final signInButton = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 34.0, top: 80.0),
          child: SizedBox(
            width: 100.0,
            child: FloatingActionButton.extended(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  setState(() {
                    loading = true;
                  });
                  dynamic result =
                      await _auth.signInWithEmailAndPassword(email, password);
                  Future.delayed(const Duration(milliseconds: 100), () {
                    Navigator.pop(context, true);
                  });
                  if (result == null) {
                    setState(() {
                      error = "Wrong Credentials";
                      loading = false;
                    });
                  }
                }
              },
              label: FaIcon(FontAwesomeIcons.arrowRight),
              backgroundColor: AppTheme.beige,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              elevation: 0.0,
            ),
          ),
        ),
      ],
    );

    return loading
        ? Loader()
        : SingleChildScrollView(
            child: Container(
              width: dev_width,
              height: dev_height,
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 100.0, left: 33.0),
                    child: Text(
                      "Welcome Back,",
                      style: TextStyle(
                          fontSize: 36.0, fontWeight: FontWeight.w300),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0),
                    child: Text(
                      "Wanderer",
                      style: TextStyle(
                          fontSize: 36.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Container(
                      child: Column(
                        children: [
                          emailField,
                          passwordField,
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, top: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 14.0, top: 14.0),
                                  child: InkWell(
                                      onTap: () {
                                        if (email.isNotEmpty) {
                                          _auth.resetPassword(email);
                                        } else {
                                          _formKey.currentState.validate();
                                        }
                                      },
                                      child: Text("Forgot password?",
                                          style: GoogleFonts.lato(
                                              fontWeight: FontWeight.w700))),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Column(
                              children: [
                                SignInButton(
                                  Buttons.GoogleDark,
                                  onPressed: () async {
                                    try {
                                      setState(() {
                                        loading = true;
                                      });
                                      await _auth.signInWithGoogle();
                                      Future.delayed(
                                          const Duration(milliseconds: 100),
                                          () {
                                        Navigator.pop(context, true);
                                      });
                                    } catch (e) {
                                      print(e.toString());
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                ),
                              ],
                            ),
                          ),
                          signInButton
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
