import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peak_brain/constants/colors.dart';
import 'package:peak_brain/screens/game1.dart';
import 'package:peak_brain/screens/game2.dart';
import 'package:peak_brain/screens/game3.dart';
import 'package:peak_brain/screens/game4.dart';
import 'package:peak_brain/screens/game5.dart';
import 'package:peak_brain/screens/game6.dart';
import 'package:peak_brain/screens/game7.dart';
import 'package:peak_brain/screens/game8.dart';
import 'package:peak_brain/screens/game9.dart';
import 'package:peak_brain/screens/game10.dart';
import 'package:peak_brain/screens/game11.dart';
import 'package:peak_brain/screens/game12.dart';
import 'package:peak_brain/screens/game13.dart';
import 'package:peak_brain/screens/game14.dart';
import 'package:peak_brain/screens/game15.dart';
import 'package:peak_brain/screens/game16.dart';
import 'package:peak_brain/screens/game17.dart';
import 'package:peak_brain/screens/game18.dart';
import 'package:peak_brain/screens/game19.dart';
import 'package:peak_brain/screens/game20.dart';
import 'package:peak_brain/screens/game21.dart';
import 'package:peak_brain/screens/game22.dart';
import 'package:peak_brain/screens/game23.dart';
import 'package:peak_brain/screens/game24.dart';
import 'package:peak_brain/screens/game25.dart';
import 'package:peak_brain/screens/game26.dart';

import 'package:peak_brain/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //     statusBarColor: primaryColor, systemNavigationBarColor: primaryColor));
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/game1': (context) => Game1(),
        '/game2': (context) => Game2(),
        '/game3': (context) => Game3(),
        '/game4': (context) => Game4(),
        '/game5': (context) => Game5(),
        '/game6': (context) => Game6(),
        '/game7': (context) => Game7(),
        '/game8': (context) => Game8(),
        '/game9': (context) => Game9(),
        '/game10': (context) => Game10(),
        '/game11': (context) => Game11(),
        '/game12': (context) => Game12(),
        '/game13': (context) => Game13(),
        '/game14': (context) => Game14(),
        '/game15': (context) => Game15(),
        '/game16': (context) => Game16(),
        '/game17': (context) => Game17(),
        '/game18': (context) => Game18(),
        '/game19': (context) => Game19(),
        '/game20': (context) => Game20(),
        '/game21': (context) => Game21(),
        '/game22': (context) => Game22(),
        '/game23': (context) => Game23(),
        '/game24': (context) => Game24(),
        '/game25': (context) => Game25(),
        '/game26': (context) => Game26(),
      },
      home: Home(),
    );
  }

  // void callStaticMethodOnClass(String className, String methodName) {
  //   final classSymbol = Symbol(className);
  //   final methodSymbol = Symbol(methodName);

  //   (currentMirrorSystem().isolate.rootLibrary.declarations[classSymbol]
  //           as ClassMirror)
  //       .invoke(methodSymbol, <dynamic>[]);
  // }
}
