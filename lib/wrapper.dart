import 'package:effors/models/user.dart';
import 'package:effors/pages/home_page.dart';
import 'package:effors/pages/intro_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user =Provider.of<User>(context);
    if(user==null){
      return OnBoardingPage();
    }
    else{
      return MyHomePage();
    }
  }
}