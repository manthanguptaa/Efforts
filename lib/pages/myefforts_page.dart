import 'package:effors/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MyEffortsPage extends StatefulWidget {
  @override
  _MyEffortsPageState createState() => _MyEffortsPageState();
}

class _MyEffortsPageState extends State<MyEffortsPage> {
  @override
  Widget build(BuildContext context) {
    var dt = DateTime.now();
    var dayFormat = DateFormat("d");
    var monthFormath = DateFormat("MMMM");
    var yearFormat = DateFormat("y");
    var weekdayFormat = DateFormat("EEEE");
    String day = dayFormat.format(dt);
    String month = monthFormath.format(dt);
    String year = yearFormat.format(dt);
    String weekday = weekdayFormat.format(dt);
    List<Color> c = [AppTheme.darkBlue, AppTheme.turquoise];
    final dev_height =
        MediaQuery.of(context).size.height; //height of device screen
    final dev_width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 20.0),
          child: Row(
            children: [
              Text(day,
                  style: GoogleFonts.lato(
                      fontSize: 35.0, fontWeight: FontWeight.w600)),
              Column(children: [
                Text(
                  month.substring(0, 3),
                  style: GoogleFonts.lato(fontWeight: FontWeight.w400),
                ),
                Text(
                  year,
                  style: GoogleFonts.lato(fontWeight: FontWeight.w300),
                )
              ]),
              Padding(
                padding: const EdgeInsets.only(left: 180.0),
                child: Row(
                  children: [
                    Text(
                      weekday,
                      style: GoogleFonts.lato(fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              width: dev_width * 0.78,
              height: dev_height * 0.73,
              child: ListView(
                children: [
                  SizedBox(
                    width: 80.0,
                    height: 100.0,
                    child: Card(
                      elevation: 20.0,
                      shadowColor: Colors.black,
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Gargel",
                                    style: GoogleFonts.lato(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Wrap(children: [
                                  Text("Remember",
                                      style:
                                          GoogleFonts.lato(color: Colors.red)),
                                  Text(" to do warm water gargel,",
                                      style: GoogleFonts.lato()),
                                  Text(" when I come home after work",
                                      style: GoogleFonts.lato())
                                ]),
                              )
                            ],
                          )),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  SizedBox(
                    width: 80.0,
                    height: 100.0,
                    child: Card(
                      elevation: 20.0,
                      shadowColor: Colors.black,
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Turmeric Milk",
                                    style: GoogleFonts.lato(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Wrap(children: [
                                  Text("Remember",
                                      style:
                                          GoogleFonts.lato(color: Colors.red)),
                                  Text(" to drink turmeric milk at night",
                                      style: GoogleFonts.lato()),
                                  Text(" once in a week",
                                      style: GoogleFonts.lato())
                                ]),
                              )
                            ],
                          )),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  SizedBox(
                    width: 80.0,
                    height: 100.0,
                    child: Card(
                      elevation: 20.0,
                      shadowColor: Colors.black,
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Sanitiser",
                                    style: GoogleFonts.lato(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Wrap(children: [
                                  Text("Remember",
                                      style:
                                          GoogleFonts.lato(color: Colors.red)),
                                  Text(" to buy sanitiser before running",
                                      style: GoogleFonts.lato()),
                                  Text(" out of them",
                                      style: GoogleFonts.lato())
                                ]),
                              )
                            ],
                          )),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  SizedBox(
                    width: 80.0,
                    height: 100.0,
                    child: Card(
                      elevation: 20.0,
                      shadowColor: Colors.black,
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Help",
                                    style: GoogleFonts.lato(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Wrap(children: [
                                  Text("Remember",
                                      style:
                                          GoogleFonts.lato(color: Colors.red)),
                                  Text(" to help your peers in society",
                                      style: GoogleFonts.lato()),
                                  Text(" once in a week",
                                      style: GoogleFonts.lato())
                                ]),
                              )
                            ],
                          )),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  SizedBox(
                    width: 80.0,
                    height: 100.0,
                    child: Card(
                      elevation: 20.0,
                      shadowColor: Colors.black,
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "MultiVitamins",
                                    style: GoogleFonts.lato(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Wrap(children: [
                                  Text("Remember",
                                      style:
                                          GoogleFonts.lato(color: Colors.red)),
                                  Text(" to take multivitamins",
                                      style: GoogleFonts.lato()),
                                ]),
                              )
                            ],
                          )),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
