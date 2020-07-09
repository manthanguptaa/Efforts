import 'dart:typed_data';

import 'package:animated_splash/animated_splash.dart';
import 'package:effors/services/admob_service.dart';
import 'package:effors/services/auth.dart';
import 'package:effors/wrapper.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseAdMob.instance.initialize(appId: AdMobService().getAdMobAppId());
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthService().user,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Efforts",
          home: AnimatedSplash(
            imagePath: 'assets/logo.png',
            duration: 2500,
            home: Wrapper(),
          )),
    );
  }
}
