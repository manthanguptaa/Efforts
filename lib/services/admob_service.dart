import 'dart:io';
import 'package:firebase_admob/firebase_admob.dart';

class AdMobService{
  String getAdMobAppId(){
    if(Platform.isAndroid){
      return 'ca-app-pub-3434622702232169~3054200957';
    }
    return null;
  }

  String getInterstitialAd(){
    if(Platform.isAndroid){
      //return 'ca-app-pub-3434622702232169/5167382495';
      return 'ca-app-pub-3940256099942544/1033173712';
    }
    return null;
  }

  InterstitialAd getAds(){
    return InterstitialAd(
      adUnitId: getInterstitialAd(),
      listener: (MobileAdEvent event){
        print("Ads displayed");
      }
    );
  }
}