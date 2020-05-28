import 'package:flutter/material.dart';
import 'home_page.dart';
import 'start_screen.dart';

void main() => runApp(TicTacToe());

class TicTacToe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xFF0A0D21),
          scaffoldBackgroundColor: Color(0xFF0A0D21),
        ),
//      home: HomePage(),
        home: StartScreen(),
        routes: {
          'start_screen': (BuildContext context) => StartScreen(),
          'offline': (BuildContext context) => HomePage(),
        });
  }
}
