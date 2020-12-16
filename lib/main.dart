import 'package:flutter/material.dart';
import 'package:flutter_app_map_test01/pages/splash.dart';
import 'package:flutter_app_map_test01/my_home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'map test',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        'home' : (_)=> MyHomePage(),
      },

    );
  }
}


