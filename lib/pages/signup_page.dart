import 'package:effors/constants/color.dart';
import 'package:effors/constants/loader.dart';
import 'package:effors/pages/more_detail_page.dart';
import 'package:effors/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String name = "";
  String email = "";
  String password = "";
  String error = "";
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final dev_width = MediaQuery.of(context).size.width;
    AuthService _auth = AuthService();

    final nameField = Container(
        width: dev_width - 80,
        padding: EdgeInsets.only(top: 50.0),
        child: TextFormField(
          validator: (String value) {
            if (value.isEmpty) {
              return "Please enter your name";
            }
          },
          onChanged: (value) {
            setState(() {
              name = value;
            });
          },
          decoration: InputDecoration(
            hintText: "Full Name",
            hintStyle: GoogleFonts.lato(
                fontWeight: FontWeight.w300,
                color: Colors.grey[400],
                fontSize: 18.0),
          ),
        ));

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
            if (value.length < 6) {
              return "Too short";
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
          padding: const EdgeInsets.only(right: 34.0, top: 60.0),
          child: SizedBox(
            width: 100.0,
            child: FloatingActionButton.extended(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  setState(() {
                    loading = true;
                  });
                  dynamic result = await _auth.registerWithEmailAndPassword(
                      name, email, password);

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MoreDetail()));

                  if (result == null) {
                    setState(() {
                      error = "Please try again";
                      loading = false;
                    });
                    AlertDialog(
                      title: Text("Error"),
                      content: Text(error),
                    );
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
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 100.0, left: 33.0),
                    child: Text(
                      "Hello human,",
                      style: TextStyle(
                          fontSize: 36.0, fontWeight: FontWeight.w800),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 35.0),
                    child: Text(
                      "Enter your information below or \nlogin with a social account",
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Container(
                      child: Column(
                        children: [
                          nameField,
                          emailField,
                          passwordField,
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 28.0, top: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SignInButton(Buttons.GoogleDark,
                                    onPressed: () async {
                                  try {
                                    setState(() {
                                      loading = true;
                                    });
                                    await _auth.signInWithGoogle().then(
                                        (value) => Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        MoreDetail())));
                                  } catch (e) {
                                    print(e.toString());
                                    setState(() {
                                      loading = false;
                                    });
                                  }
                                },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    text: "Sign up with Google"),
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
