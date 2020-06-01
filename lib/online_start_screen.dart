import 'package:flutter/material.dart';
import 'create_game.dart';
import 'join_game.dart';

class OnlineStartScreen extends StatelessWidget {
//  static const String id = "HomePage.id";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlineButton(
                child: Text("Create game"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateGame()),
                  );
                }),
            SizedBox(
              height: 30,
            ),
            OutlineButton(
                child: Text("Join game"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => JoinGame()),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
