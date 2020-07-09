import 'package:effors/constants/color.dart';
import 'package:effors/pages/second_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'dart:async';
import 'package:effors/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:effors/models/user.dart';

class MoreDetail extends StatefulWidget {
  @override
  _MoreDetailState createState() => _MoreDetailState();
}

class _MoreDetailState extends State<MoreDetail> {
  Country _selected;
  TimeOfDay _time = TimeOfDay.now();

  Future<Null> _selectTime() async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    final user = Provider.of<User>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Container(
            width: double.infinity,
            // height: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height / 5),
              child: Column(
                children: [
                  Text("Choose Country",
                      style: GoogleFonts.lato(
                          fontSize: 24.0, fontWeight: FontWeight.w600)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height / 25),
                    child: CountryPicker(
                      onChanged: (Country country) {
                        setState(() {
                          _selected = country;
                        });
                      },
                      selectedCountry: _selected,
                      nameTextStyle: GoogleFonts.lato(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height / 30),
                    child: Text(
                      "What time do you wake up?",
                      style: GoogleFonts.lato(
                          fontSize: 24.0, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 0.0),
                    child: Container(
                      decoration: BoxDecoration(),
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 20,
                      child: ListTile(
                        title: Text(
                          "${_time.format(context)}",
                          style: GoogleFonts.lato(),
                        ),
                        trailing: Icon(Icons.arrow_drop_down),
                        onTap: () async {
                          _selectTime();
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height / 3,
                        horizontal: MediaQuery.of(context).size.height / 20),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: 100.0,
                        child: FloatingActionButton.extended(
                          onPressed: () async {
                            _auth.updateDetails(user.uid, _selected.name,
                                _time.format(context));
                            Future.delayed(const Duration(milliseconds: 100),
                                () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SplashScreen()));
                            });
                          },
                          label: FaIcon(FontAwesomeIcons.arrowRight),
                          backgroundColor: AppTheme.beige,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          elevation: 0.0,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
