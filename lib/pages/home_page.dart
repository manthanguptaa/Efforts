import 'package:effors/constants/color.dart';
import 'package:effors/pages/charts_page.dart';
import 'package:effors/pages/exercise_page.dart';
import 'package:effors/pages/myefforts_page.dart';
import 'package:effors/pages/timer_page.dart';
import 'package:effors/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circular Bottom Navigation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'circular_bottom_navigation'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedPos = 0;

  double bottomNavBarHeight = 60;

  List<TabItem> tabItems = List.of([
    new TabItem(Icons.timer, "Timer", AppTheme.turquoise,
        labelStyle: TextStyle(fontWeight: FontWeight.bold)),
    new TabItem(Icons.show_chart, "Chart", AppTheme.turquoise,
        labelStyle: TextStyle(fontWeight: FontWeight.bold)),
    new TabItem(Icons.fitness_center, "Exercise", AppTheme.turquoise,
        labelStyle: TextStyle(fontWeight: FontWeight.bold)),
    new TabItem(Icons.edit, "My Efforts", AppTheme.turquoise,
        labelStyle: TextStyle(fontWeight: FontWeight.bold)),
  ]);

  CircularBottomNavigationController _navigationController;

  @override
  void initState() {
    super.initState();
    _navigationController = new CircularBottomNavigationController(selectedPos);
  }

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<User>(context);
    final AuthService _auth = AuthService();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black26),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0, top: 15.0),
            child: GestureDetector(
              onTap: () async{
                await _auth.signOut();
              },
              child: Text(
                "Sign Out",
                style: GoogleFonts.lato(color: Colors.red,fontSize: 18.0),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            child: bodyContainer(),
            padding: EdgeInsets.only(bottom: bottomNavBarHeight),
          ),
          Align(alignment: Alignment.bottomCenter, child: bottomNav())
        ],
      ),
    );
  }

  Widget bodyContainer() {
    Widget screen;
    switch (selectedPos) {
      case 0:
        screen = TimerPage();
        break;
      case 1:
        screen = ChartsPage();
        break;
      case 2:
        screen = ExercisePage();
        break;
      case 3:
        screen = MyEffortsPage();
        break;
    }

    return GestureDetector(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: screen,
      ),
      onTap: () {
        if (_navigationController.value == tabItems.length - 1) {
          _navigationController.value = 0;
        } else {
          _navigationController.value++;
        }
      },
    );
  }

  Widget bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      barHeight: bottomNavBarHeight,
      barBackgroundColor: Colors.white,
      animationDuration: Duration(milliseconds: 300),
      selectedCallback: (int selectedPos) {
        setState(() {
          this.selectedPos = selectedPos;
          print(_navigationController.value);
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _navigationController.dispose();
  }
}
