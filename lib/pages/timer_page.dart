import 'package:effors/constants/color.dart';
import 'package:effors/pages/breath_hold_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:effors/services/admob_service.dart';
import 'package:firebase_admob/firebase_admob.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final ams=AdMobService();
  @override
  Widget build(BuildContext context) {
    InterstitialAd timerAd=ams.getAds();
    timerAd.load();
    return Center(
      child: _TransitionListTile(
        title: "Tap To Play",
        subtitle: "",
        onTap: () async{
          timerAd.show(
            anchorType: AnchorType.bottom,
            anchorOffset: 0.0,
            horizontalCenterOffset: 0.0
          );
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return HeroAnimation();
              },
            ),
          );
        },
      ),
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
      padding: const EdgeInsets.only(left:60.0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15.0,
        ),
        leading: Container(
          width: 60.0,
          height: 60.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: AppTheme.darkBlue
          ),
          child: const Icon(
            Icons.play_arrow,
            size: 35,
            color: Colors.white,
          ),
        ),
        onTap: onTap,
        title: Text(title,style: GoogleFonts.lato(
          fontSize: 20.0,
          fontWeight: FontWeight.w700
        ),),
      ),
    );
  }
}