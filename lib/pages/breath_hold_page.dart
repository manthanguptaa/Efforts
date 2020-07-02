import 'dart:math';
import 'package:effors/constants/color.dart';
import 'package:effors/models/user.dart';
import 'package:effors/services/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:circular_countdown/circular_countdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

int timer = 0;
String description = "Relax";

class HeroAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new HeroAnimationScreen(
        screenSize: MediaQuery.of(context).size,
      ),
    );
  }
}

class HeroAnimationScreen extends StatefulWidget {
  final Size screenSize;

  HeroAnimationScreen({Key key, @required this.screenSize}) : super(key: key);

  @override
  State createState() => HeroAnimationScreenState();
}

class HeroAnimationScreenState extends State<HeroAnimationScreen>
    with TickerProviderStateMixin {
  static const double kMinRadius = 32.0;
  static const double kMaxRadius = 128.0;
  static const double durationSlowMode = 2.0;

  Color gradientStartFrom = Colors.deepPurple;
  Color gradientStartTo = Colors.purple;
  Color gradientEndFrom = new Color(0xff483475);
  Color gradientEndTo = new Color(0xff070B34);

  AnimationController animControlStar, animControlPlanet, animControlBg;
  Animation fadeAnimStar1,
      fadeAnimStar2,
      fadeAnimStar3,
      fadeAnimStar4,
      sizeAnimStar,
      rotateAnimStar;
  Animation fadeAnimPlanet1, fadeAnimPlanet2, fadeAnimPlanet3, fadeAnimPlanet4;
  Animation sizeAnimPlanet1, sizeAnimPlanet2, sizeAnimPlanet3, sizeAnimPlanet4;
  Animation colorAnimBgStart, colorAnimBgEnd;
  Size screenSize;
  List<Star> listStar;
  int numStars;

  RectTween createRectTween(Rect begin, Rect end) {
    return new MaterialRectArcTween(begin: begin, end: end);
  }

  Widget buildStar(
      double left, double top, double extraSize, double angle, int typeFade) {
    return new Positioned(
      child: new Container(
        child: new Transform.rotate(
          child: new Opacity(
            child: new Icon(
              Icons.star,
              color: Colors.white,
              size: sizeAnimStar.value + extraSize,
            ),
            opacity: (typeFade == 1)
                ? fadeAnimStar1.value
                : (typeFade == 2)
                    ? fadeAnimStar2.value
                    : (typeFade == 3)
                        ? fadeAnimStar3.value
                        : fadeAnimStar4.value,
          ),
          angle: angle,
        ),
        alignment: FractionalOffset.center,
        width: 10.0,
        height: 10.0,
      ),
      left: left,
      top: top,
    );
  }

  Widget buildGroupStar() {
    List<Widget> list = new List();
    for (int i = 0; i < numStars; i++) {
      list.add(buildStar(listStar[i].left, listStar[i].top,
          listStar[i].extraSize, listStar[i].angle, listStar[i].typeFade));
    }

    return new Stack(
      children: <Widget>[
        list[0],
        list[1],
        list[2],
        list[3],
        list[4],
        list[5],
        list[6],
        list[7],
        list[8],
        list[9],
        list[10],
        list[11],
        list[12],
        list[13],
        list[14],
        list[15],
        list[16],
        list[17],
        list[18],
        list[19],
        list[20],
        list[21],
        list[22],
        list[23],
        list[24],
        list[25],
        list[26],
        list[27],
        list[28],
        list[29],
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    screenSize = widget.screenSize;
    listStar = new List();
    numStars = 30;

    // Star
    animControlStar = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 2000));
    fadeAnimStar1 = new Tween(begin: 0.0, end: 1.0).animate(new CurvedAnimation(
        parent: animControlStar, curve: new Interval(0.0, 0.5)));
    fadeAnimStar1.addListener(() {
      setState(() {});
    });
    fadeAnimStar2 = new Tween(begin: 0.0, end: 1.0).animate(new CurvedAnimation(
        parent: animControlStar, curve: new Interval(0.5, 1.0)));
    fadeAnimStar2.addListener(() {
      setState(() {});
    });
    fadeAnimStar3 = new Tween(begin: 1.0, end: 0.0).animate(new CurvedAnimation(
        parent: animControlStar, curve: new Interval(0.0, 0.5)));
    fadeAnimStar3.addListener(() {
      setState(() {});
    });
    fadeAnimStar4 = new Tween(begin: 1.0, end: 0.0).animate(new CurvedAnimation(
        parent: animControlStar, curve: new Interval(0.5, 1.0)));
    fadeAnimStar4.addListener(() {
      setState(() {});
    });
    sizeAnimStar = new Tween(begin: 0.0, end: 5.0).animate(new CurvedAnimation(
        parent: animControlStar, curve: new Interval(0.0, 0.5)));
    sizeAnimStar.addListener(() {
      setState(() {});
    });
    rotateAnimStar = new Tween(begin: 0.0, end: 1.0).animate(
        new CurvedAnimation(
            parent: animControlStar, curve: new Interval(0.0, 0.5)));
    rotateAnimStar.addListener(() {
      setState(() {});
    });

    animControlStar.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animControlStar.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animControlStar.forward();
      }
    });

    for (int i = 0; i < numStars; i++) {
      listStar.add(new Star(
          left: new Random().nextDouble() * screenSize.width,
          top: Random().nextDouble() * screenSize.height,
          extraSize: Random().nextDouble() * 2,
          angle: Random().nextDouble(),
          typeFade: Random().nextInt(4)));
    }

    // Planet
    animControlPlanet = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 2000));
    fadeAnimPlanet1 = new Tween(begin: 0.0, end: 1.0).animate(
        new CurvedAnimation(
            parent: animControlPlanet, curve: new Interval(0.0, 0.5)));
    fadeAnimPlanet1.addListener(() {
      setState(() {});
    });
    fadeAnimPlanet2 = new Tween(begin: 0.0, end: 1.0).animate(
        new CurvedAnimation(
            parent: animControlPlanet, curve: new Interval(0.2, 0.7)));
    fadeAnimPlanet2.addListener(() {
      setState(() {});
    });
    fadeAnimPlanet3 = new Tween(begin: 0.0, end: 1.0).animate(
        new CurvedAnimation(
            parent: animControlPlanet, curve: new Interval(0.4, 0.9)));
    fadeAnimPlanet3.addListener(() {
      setState(() {});
    });
    fadeAnimPlanet4 = new Tween(begin: 0.0, end: 1.0).animate(
        new CurvedAnimation(
            parent: animControlPlanet, curve: new Interval(0.6, 1.0)));
    fadeAnimPlanet4.addListener(() {
      setState(() {});
    });
    sizeAnimPlanet1 = new Tween(begin: 0.0, end: 100.0).animate(
        new CurvedAnimation(
            parent: animControlPlanet, curve: new Interval(0.0, 0.5)));
    sizeAnimPlanet1.addListener(() {
      setState(() {});
    });
    sizeAnimPlanet2 = new Tween(begin: 0.0, end: 100.0).animate(
        new CurvedAnimation(
            parent: animControlPlanet, curve: new Interval(0.2, 0.7)));
    sizeAnimPlanet2.addListener(() {
      setState(() {});
    });
    sizeAnimPlanet3 = new Tween(begin: 0.0, end: 100.0).animate(
        new CurvedAnimation(
            parent: animControlPlanet, curve: new Interval(0.4, 0.9)));
    sizeAnimPlanet3.addListener(() {
      setState(() {});
    });
    sizeAnimPlanet4 = new Tween(begin: 0.0, end: 100.0).animate(
        new CurvedAnimation(
            parent: animControlPlanet, curve: new Interval(0.6, 1.0)));
    sizeAnimPlanet4.addListener(() {
      setState(() {});
    });

    // Background
    animControlBg = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 5000));
    animControlBg.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animControlBg.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animControlBg.forward();
      }
    });
    colorAnimBgStart =
        new ColorTween(begin: gradientStartFrom, end: gradientStartTo)
            .animate(animControlBg);
    colorAnimBgEnd = new ColorTween(begin: gradientEndFrom, end: gradientEndTo)
        .animate(animControlBg);

    // Let's go
    animControlStar.forward();
    animControlPlanet.forward();
    animControlBg.forward();
  }

  @override
  void dispose() {
    animControlStar.dispose();
    animControlPlanet.dispose();
    animControlBg.dispose();
    super.dispose();
  }

  String _formatTime(CountdownUnit unit, int remainingTime) =>
      '$remainingTime ${describeEnum(unit)}${remainingTime > 1 ? 's' : ''}';

  @override
  Widget build(BuildContext context) {
    timeDilation = durationSlowMode;

    return Stack(
      children: <Widget>[
        new Container(
            width: double.infinity,
            height: double.infinity,
            color: AppTheme.darkBlue,
            child: buildGroupStar()),
        Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 120.0),
                child: Text(
                  description,
                  style: GoogleFonts.lato(color: Colors.white, fontSize: 40.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: timer == 0 ? Relax() : timer == 1 ? Inhale() : Hold(),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class RadialExpansion extends StatelessWidget {
  RadialExpansion({
    Key key,
    this.maxRadius,
    this.child,
  })  : clipRectSize = 2.0 * (maxRadius / sqrt2),
        super(key: key);

  final double maxRadius;
  final clipRectSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new SizedBox(
        width: clipRectSize,
        height: clipRectSize,
        child: child,
      ),
    );
  }
}

class Photo extends StatelessWidget {
  Photo({Key key, this.photo, this.color, this.onTap}) : super(key: key);

  final String photo;
  final Color color;
  final VoidCallback onTap;

  Widget build(BuildContext context) {
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        onTap: onTap,
        child: new Image.asset(
          photo,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class Star {
  // angle should be value 0.0 -> 1.0
  // left 0.0 -> 360.0
  // height 0.0 -> 640.0
  // typeFade 1 -> 4

  double left;
  double top;
  double extraSize;
  double angle;
  int typeFade;

  Star(
      {@required this.left,
      @required this.top,
      @required this.extraSize,
      @required this.angle,
      @required this.typeFade});
}

class Relax extends StatefulWidget {
  @override
  _RelaxState createState() => _RelaxState();
}

class _RelaxState extends State<Relax> {
  // String _formatTime(CountdownUnit unit, int remainingTime) =>
  //     '$remainingTime ${describeEnum(unit)}${remainingTime > 1 ? 's' : ''}';
  @override
  Widget build(BuildContext context) {
    return TimeCircularCountdown(
      unit: CountdownUnit.second,
      countdownTotal: 5,
      diameter: 200,
      strokeWidth: 2.0,
      countdownCurrentColor: Colors.redAccent,
      // onUpdated: (unit, remainingTime) {
      //   setState(() {
      //     description = 'Updated: ${_formatTime(unit, remainingTime)}';
      //   });
      // },
      onFinished: () {
        setState(() {
          timer++;
          description = "Inhale";
        });
      },
      onCanceled: (unit, remainingTime) {
        setState(() {
          timer = 0;
          description = "Relax";
        });
      },
      textStyle: const TextStyle(
        color: AppTheme.beige,
        fontSize: 90,
      ),
    );
  }
}

class Inhale extends StatefulWidget {
  @override
  _InhaleState createState() => _InhaleState();
}

class _InhaleState extends State<Inhale> {
  // String _formatTime(CountdownUnit unit, int remainingTime) =>
  //     '$remainingTime ${describeEnum(unit)}${remainingTime > 1 ? 's' : ''}';
  @override
  Widget build(BuildContext context) {
    return TimeCircularCountdown(
      strokeWidth: 2.0,
      unit: CountdownUnit.second,
      countdownTotal: 5,
      diameter: 200,
      countdownCurrentColor: Colors.amber,
      onFinished: () {
        setState(() {
          timer++;
          description = 'Hold';
        });
      },
      onCanceled: (unit, remainingTime) {
        setState(() {
          timer = 0;
          description = "Relax";
        });
      },
      textStyle: const TextStyle(
        color: AppTheme.beige,
        fontSize: 90,
      ),
    );
  }
}

class Hold extends StatefulWidget {
  @override
  _HoldState createState() => _HoldState();
}

class _HoldState extends State<Hold> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    onChange: (value) => print('onChange $value'),
    onChangeSecond: (value) => print('onChangeSecond $value'),
    onChangeMinute: (value) => print('onChangeMinute $value'),
  );

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    _stopWatchTimer.rawTime.listen((value) =>
        print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
    _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
    _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
    _stopWatchTimer.records.listen((value) => print('records $value'));
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  // String _formatTime(CountdownUnit unit, int remainingTime) =>
  //     '$remainingTime ${describeEnum(unit)}${remainingTime > 1 ? 's' : ''}';
  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    final user = Provider.of<User>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: StreamBuilder<int>(
              stream: _stopWatchTimer.secondTime,
              initialData: _stopWatchTimer.secondTime.value,
              builder: (context, snap) {
                final value = snap.data;
                print('Listen every second. $value');
                return Column(
                  children: [
                    Stack(children: [
                      Center(
                        child: Opacity(
                          opacity: 0.8,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                              border:Border.all(color: Colors.white,width: 2.0),
                                borderRadius: BorderRadius.all(Radius.circular(
                                    MediaQuery.of(context).size.width / 2)),
                                ),
                          ),
                        ),
                      ),
                      Center(
                          child:
                              Padding(
                                padding:EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height/12),
                                child: Text(value.toString(), style: GoogleFonts.lato(
                                  fontSize: 45.0,
                                  fontWeight: FontWeight.bold,
                                  color:AppTheme.beige
                                )),
                              ))
                    ]),
                    // Padding(
                    //     padding: const EdgeInsets.all(8),
                    //     child: Container(
                    //       height: MediaQuery.of(context).size.height / 4,
                    //       width: MediaQuery.of(context).size.width / 1.5,
                    //       decoration: BoxDecoration(
                    //           shape: BoxShape.circle, color: Colors.white),
                    //       child: Text(value.toString(),
                    //           style: GoogleFonts.lato(
                    //               fontSize: 30,
                    //               color: Colors.redAccent,
                    //               fontWeight: FontWeight.bold)),
                    //     )),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height / 4.52),
                      child: SizedBox(
                          height: 60.0,
                          width: 60.0,
                          child: RaisedButton(
                            onPressed: () async {
                              setState(() {
                                timer = 0;
                              });
                              _stopWatchTimer.onExecute
                                  .add(StopWatchExecute.stop);
                              _auth.storeRecord(user.uid, value);
                              Navigator.pop(context);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60.0)),
                            color: AppTheme.beige,
                            child: Icon(Icons.close,
                                color: Colors.white, size: 30.0),
                          )),
                    ),
                  ],
                );
              },
            )),
      ],
    );
    // TimeCircularCountdown(
    //   strokeWidth: 2.0,
    //   unit: CountdownUnit.second,
    //   countdownTotal: 40,
    //   diameter: 200,
    //   countdownCurrentColor: Colors.amber,
    //   onFinished: () {
    //     description = 'Finished';
    //     setState(() {
    //       timer = 0;
    //     });
    //     Navigator.of(context).pop();
    //   },
    //   onCanceled: (unit, remainingTime) {
    //     print('Canceled at ${_formatTime(unit, remainingTime)}');
    //     setState(() {
    //       timer = 0;
    //       description="Relax";
    //     });
    //   },
    //   textStyle: const TextStyle(
    //     color: AppTheme.beige,
    //     fontSize: 90,
    //   ),
    // );
  }
}
