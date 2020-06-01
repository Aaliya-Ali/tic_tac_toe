import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tictactoe/temp.dart';
import 'online_homepage.dart';

class JoinGame extends StatefulWidget {
//  static const String id = "CreateGame.id";
  @override
  _JoinGameState createState() => _JoinGameState();
}

class _JoinGameState extends State<JoinGame> {
  void getdata() {
    Firestore.instance
        .collection("user 2")
        .document("KwsMhcJ8kOmI74feXV5h")
        .updateData({"name": "$playername2", "gameid": "$unqcode2"});
  }

  void getname() {
    Firestore.instance
        .collection('user 2')
        .document('KwsMhcJ8kOmI74feXV5h')
        .get()
        .then(
      (data) {
        var name1 = data['name'].toString();
        var ucode = data['gameid'].toString();
        print(name1);
        print(ucode);

        setState(() {
          pname2 = name1;
          uncode2 = ucode;
        });
        print(pname2);
        print(uncode2);
      },
    );
  }

  var pname2;
  var uncode2;
  final _firestore = Firestore.instance;
  var playername2;
  var unqcode2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Enter your name'),
              onChanged: (value) {
                playername2 = value;
                print(playername2);
              },
            ),
            TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter any Unique code of your choice'),
              onChanged: (value) {
                unqcode2 = value;
                print(unqcode2);
              },
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 30,
            ),
            OutlineButton(
              onPressed: () {
                getdata();
                getname();
              },
              child: Text("SAVE DATA"),
            ),
            OutlineButton(
                onPressed: () {
                  Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (BuildContext context) => OnlineGameBoard(),
                    ),
                  );
                  getname();
                },
                child: Text("connect")),
          ],
        ),
      ),
    );
  }
}
