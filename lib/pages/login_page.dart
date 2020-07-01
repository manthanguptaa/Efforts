import 'package:effors/pages/login_form_page.dart';
import 'package:effors/pages/signup_page.dart';
import 'package:effors/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
      final AuthService _auth=AuthService();
  TabController _tabController;
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dev_height =
        MediaQuery.of(context).size.height; //height of device screen
    final dev_width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: TabBar(
          labelPadding: EdgeInsets.symmetric(horizontal: 15.0),
          labelColor: Colors.black87,
          indicatorColor: Colors.black87,
          unselectedLabelColor: Colors.grey,
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: [
            Container(
              height: 25.0,
              child: Text(
                "Sign Up",
                style: GoogleFonts.lato(
                    fontSize: 17.0, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              height: 25.0,
              child: Text(
                "Login",
                style: GoogleFonts.lato(
                    fontSize: 17.0, fontWeight: FontWeight.w600),
              ),
            )
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        children: [
          SignUpPage(),
          LoginFormPage()
        ],
        controller: _tabController,
      ),
    );
  }
}
