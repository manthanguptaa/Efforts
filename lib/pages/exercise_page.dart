import 'package:effors/constants/color.dart';
import 'package:effors/pages/deep_breathing_exercise_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:effors/services/admob_service.dart';
import 'package:firebase_admob/firebase_admob.dart';

class ExercisePage extends StatefulWidget {
  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  final ams = AdMobService();
  @override
  Widget build(BuildContext context) {
    InterstitialAd timerAd = ams.getAds();
    timerAd.load();
    final dev_height =
        MediaQuery.of(context).size.height; //height of device screen
    final dev_width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          direction: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 15.0),
              child: Text(
                "Advised For COVID-19 Patients",
                style: GoogleFonts.lato(
                    fontSize: 23.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 25.0),
              child: Container(
                width: dev_width - 50,
                child: Text(
                  "1. Take a deep breath for 5secs",
                  style: GoogleFonts.lato(
                      fontSize: 18.0, fontWeight: FontWeight.w300),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 25.0),
              child: Container(
                width: dev_width - 50,
                child: Text(
                  "2. Hold your breath for 5secs",
                  style: GoogleFonts.lato(
                      fontSize: 18.0, fontWeight: FontWeight.w300),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 25.0),
              child: Container(
                width: dev_width - 50,
                child: Text(
                  "3. Exhale slowly",
                  style: GoogleFonts.lato(
                      fontSize: 18.0, fontWeight: FontWeight.w300),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 25.0),
              child: Container(
                width: dev_width - 50,
                child: Text(
                  "4. Repeat the process 5 times, at the 5th time instead of exhaling cough out",
                  style: GoogleFonts.lato(
                      fontSize: 18.0, fontWeight: FontWeight.w300),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 25.0),
              child: Container(
                width: dev_width - 50,
                child: Text(
                  "5. Now repeat the process twice",
                  style: GoogleFonts.lato(
                      fontSize: 18.0, fontWeight: FontWeight.w300),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 25.0),
              child: Container(
                width: dev_width - 50,
                child: Text(
                  "Be ready before tapping on play button",
                  style: GoogleFonts.lato(
                      fontSize: 18.0, fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: _TransitionListTile(
                title: "Tap On Play",
                subtitle: "",
                onTap: () async {
                  timerAd.show(
                      anchorType: AnchorType.bottom,
                      anchorOffset: 0.0,
                      horizontalCenterOffset: 0.0);
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return DeepBreathingPage();
                      },
                    ),
                  );
                },
              )),
        ),
      ],
    );
  }
}

class _TransitionListTile extends StatelessWidget {
  const _TransitionListTile({
    this.onTap,
    this.title,
    this.subtitle,
  });

  final GestureTapCallback onTap;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 60.0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15.0,
        ),
        leading: Container(
          width: 60.0,
          height: 60.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: AppTheme.darkBlue),
          child: const Icon(
            Icons.play_arrow,
            size: 35,
            color: Colors.white,
          ),
        ),
        onTap: onTap,
        title: Text(
          title,
          style: GoogleFonts.lato(fontSize: 20.0, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
