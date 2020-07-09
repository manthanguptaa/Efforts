import 'dart:io';

class AdMobService {
  String getAdMobAppId() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-9516774257197035~2389654847';
    }
    return null;
  }

  String getBannerAd() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-9516774257197035/9693429796';
    }
    return null;
  }

  String getRewardAd() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-9516774257197035/4237923136';
    }
    return null;
  }
}
