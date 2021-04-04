import 'package:flutter/material.dart';
import 'package:graphx/graphx.dart';

import 'scene/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fika Coffee',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        fontFamily: 'helveticanow',
      ),
      home: AppRoot(),
    );
  }
}

class AppRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xffBDA696), Color(0xffF8F8F8)],
        ),
      ),
      child: FittedBox(
        alignment: Alignment.center,
        child: Container(
          width: 375,
          height: 811,
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.0),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Color(0xffAE8D78).withOpacity(.35), offset: Offset(1, 10), blurRadius: 26, spreadRadius: -2)],
          ),
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.0),
            border: Border.all(color: Colors.black, width: 10),
          ),
          clipBehavior: Clip.antiAlias,
          child: SceneBuilderWidget(
            builder: () => SceneController(
              front: HomeScene(),
              config: SceneConfig.tools,
            ),
          ),
        ),
      ),
    );
  }
}
