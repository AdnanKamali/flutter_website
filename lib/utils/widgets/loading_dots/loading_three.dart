import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shop_app/utils/widgets/loading_dots/circle.dart';

class ThreeDotLoading extends StatefulWidget {
  ThreeDotLoading({Key? key}) : super(key: key);

  @override
  State<ThreeDotLoading> createState() => _ThreeDotLoadingState();
}

class _ThreeDotLoadingState extends State<ThreeDotLoading> {
  late Timer timer;
  int counter = 0;
  @override
  void didChangeDependencies() {
    timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        if (counter == 0) {
          dot1 = 2;
          dot2 = 1;
          dot3 = 1;
        } else if (counter == 1) {
          dot2 = 2;
        } else if (counter == 2) {
          dot1 = 1;
          dot3 = 2;
        }
        counter++;
        if (counter > 2) {
          counter = 0;
        }
      });
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  double dot1 = 1;
  double dot2 = 1;
  double dot3 = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: dot1),
              duration: Duration(milliseconds: 500),
              builder: (_, val, child) => Transform.scale(
                scale: val,
                child: child,
              ),
              child: Circle(),
            ),
            SizedBox(
              width: 10,
            ),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: dot2),
              duration: Duration(milliseconds: 500),
              builder: (_, val, child) => Transform.scale(
                scale: val,
                child: child,
              ),
              child: Circle(),
            ),
            SizedBox(
              width: 10,
            ),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: dot3),
              duration: Duration(milliseconds: 500),
              builder: (_, val, child) => Transform.scale(
                scale: val,
                child: child,
              ),
              child: Circle(),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
