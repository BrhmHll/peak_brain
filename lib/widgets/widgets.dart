import 'package:flutter/material.dart';

class Widgets {
  static Center buildRestartButton(
      {required Function restartFunc, required double size}) {
    return Center(
      child: Container(
          height: size,
          width: size,
          child: IconButton(
            padding: EdgeInsets.all(8.0),
            onPressed: () {
              restartFunc();
            },
            icon: Image.asset(
              "assets/images/restart.png",
              width: (size - 16),
              height: (size - 16),
            ),
            iconSize: (size - 16) * 0.7,
          )),
    );
  }
}
