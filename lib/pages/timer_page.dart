import 'package:admob_flutter/admob_flutter.dart';
import 'package:effors/constants/color.dart';
import 'package:effors/pages/breath_hold_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:effors/services/admob_service.dart';
import 'package:firebase_admob/firebase_admob.dart';

const testDevice = "Your_DEVICE_ID";
int coins = 0;

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      testDevices: testDevice != null ? <String>['testDevices'] : null,
      keywords: <String>['Ad', 'Reward'],
      nonPersonalizedAds: true);
  final ams = AdMobService();
  RewardedVideoAd videoAd = RewardedVideoAd.instance;
  @override
  void initState() {
    super.initState();
    Admob.initialize(ams.getAdMobAppId());
    FirebaseAdMob.instance.initialize(appId: ams.getRewardAd());
    videoAd.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      if (event == RewardedVideoAdEvent.closed) {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return HeroAnimation();
            },
          ),
        );
      }
    };
    videoAd.load(
        adUnitId: ams.getRewardAd(), targetingInfo: targetingInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height / 5),
            child: Center(
              child: _TransitionListTile(
                title: "Tap On Play",
                subtitle: "",
                onTap: () {
                  if (coins == 0) {
                    videoAd.show();
                    setState(() {
                      coins++;
                    });
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return HeroAnimation();
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          AdmobBanner(
              adUnitId: ams.getBannerAd(), adSize: AdmobBannerSize.FULL_BANNER)
        ],
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
      padding: EdgeInsets.only(left: 60.0),
      child: ListTile(
        leading: Container(
          width: 60.0,
          height: 60.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: AppTheme.darkBlue),
          child: Icon(
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
