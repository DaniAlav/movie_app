import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/src/pages/home_page.dart';
import 'package:movie_app/src/pages/search_page.dart';
import 'package:movie_app/src/pages/ver_todos_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Color.fromRGBO(28, 28, 38, 1)));

    return MaterialApp(
      title: 'Movie Viewer',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'verMas': (BuildContext context) => VerMasPage(),
        'search': (BuildContext context) => ShowSearch(),
        },
    );
  }
}
