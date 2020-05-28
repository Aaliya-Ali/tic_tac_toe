import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              color: Color(0xFFEB1555),
              onPressed: () {
                mode = 'single';
                Navigator.pushNamed(context, 'offline');
                print('Pressed Single player');
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text('Single Player'),
              ),
            ),
            FlatButton(
              color: Color(0xFFEB1555),
              onPressed: () {
                mode = 'double';
                Navigator.pushNamed(context, 'offline');
                print('Pressed Double player');
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                child: Text('Double Player'),
              ),
            ),
            FlatButton(
              color: Color(0xFFEB1555),
              onPressed: () {
                mode:
                'online';
                print('Pressed Play Online');
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text('Play Online'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
