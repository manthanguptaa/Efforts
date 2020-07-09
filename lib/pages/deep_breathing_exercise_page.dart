import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

int timer = 0;
String description = "Inhale";
BorderRadiusGeometry _borderRadius = BorderRadius.circular(20.0);
int times = 1;

class DeepBreathingPage extends StatefulWidget {
  @override
  _DeepBreathingPageState createState() => _DeepBreathingPageState();
}

class _DeepBreathingPageState extends State<DeepBreathingPage> {
  void initState() {
    setState(() {
      description = "Inhale";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            const Color(0xFFFFE577),
            const Color(0xFFFEC051),
            const Color(0xFFFF8866),
            const Color(0xFFFD6051),
            const Color(0xFF392033)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        ),
        // Center(
        //   child: Opacity(
        //     opacity: 0.3,
        //     child: Container(
        //       width: dev_width - 60,
        //       height: dev_height / 2.6,
        //       decoration: BoxDecoration(
        //           color: Colors.white,
        //           borderRadius: BorderRadius.all(Radius.circular(500.0))),
        //     ),
        //   ),
        // ),
        Center(
          child: Inhale(),
        ),
      ]),
    );
  }
}

class Relax extends StatefulWidget {
  @override
  _RelaxState createState() => _RelaxState();
}

class _RelaxState extends State<Relax> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    animation = Tween(begin: 1.0, end: 2.0).animate(animationController);
    animationController.addStatusListener(animationStatusListener);
    animationController.forward();
  }

  void animationStatusListener(AnimationStatus status) async {
    if (status == AnimationStatus.completed) {
      setState(() {
        timer += 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget child) {
        return Text(
          "Relax",
          style: GoogleFonts.lato(
              fontSize: 30.0,
              fontWeight: FontWeight.w700,
              color: Colors.black26),
        );
      },
    );
  }
}

class Inhale extends StatefulWidget {
  @override
  _InhaleState createState() => _InhaleState();
}

class _InhaleState extends State<Inhale> with SingleTickerProviderStateMixin {
  double _width = 50.0;
  double _height = 50.0;
  Color _color = Colors.white;
  AnimationController animationController;
  Animation animation;

  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );
    animation = Tween(begin: 1.0, end: 2.0).animate(animationController);
    animationController.addStatusListener(animationStatusListener);
    animationController.forward();
  }

  void animationStatusListener(AnimationStatus status) async {
    if (status == AnimationStatus.completed) {
      await Future.delayed(Duration(seconds: 5));
      animationController.reverse();
    } else if (status == AnimationStatus.dismissed) {
      setState(() {
        times++;
      });
      if (times > 10) {
        setState(() {
          times = 0;
          timer = 0;
        });
        await Future.delayed(Duration(seconds: 3));
        Navigator.of(context).pop();
      } else {
        await Future.delayed(Duration(seconds: 1));
        animationController.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
        child: Opacity(
          opacity: 0.7,
          child: AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget child) {
              final size = 100 * (animation.value + 1);
              return Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(size / 2)),
                  color: _color,
                ),
              );
            },
          ),
        ),
      ),
      Center(child: TextAnimation())
    ]);
  }
}

class TextAnimation extends StatefulWidget {
  @override
  _TextAnimationState createState() => _TextAnimationState();
}

class _TextAnimationState extends State<TextAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );
    setState(() {
      description = "Inhale";
    });
    animation = Tween(begin: 1.0, end: 2.0).animate(animationController);
    animationController.addStatusListener(animationStatusListener);
    animationController.forward();
  }

  void animationStatusListener(AnimationStatus status) async {
    if (status == AnimationStatus.completed) {
      setState(() {
        description = "Hold";
      });

      await Future.delayed(Duration(seconds: 5));
      if (times % 5 == 0 && times != 0) {
        setState(() {
          description = "Cough Out";
        });
      } else {
        setState(() {
          description = "Exhale";
        });
      }

      animationController.reverse();
    } else if (status == AnimationStatus.dismissed) {
      description = "Inhale";

      await Future.delayed(Duration(seconds: 1));
      animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget child) {
        return Text(
          description,
          style: GoogleFonts.lato(
              fontSize: 30.0,
              fontWeight: FontWeight.w700,
              color: Colors.black26),
        );
      },
    );
  }
}
