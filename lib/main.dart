import 'package:flutter/material.dart';
import 'package:tictactoe/online_start_screen.dart';
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
        debugShowCheckedModeBanner: false,
        home: StartScreen(),
//        home: OnlineStartScreen(),
        routes: {
          'start_screen': (context) => StartScreen(),
          'offline': (context) => HomePage(),
          'online': (context) => OnlineStartScreen()
        });
  }
}
