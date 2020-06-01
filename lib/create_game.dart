import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tictactoe/temp.dart';
import 'online_homepage.dart';

class CreateGame extends StatefulWidget {
//  static const String id = "CreateGame.id";
  @override
  _CreateGameState createState() => _CreateGameState();
}

class _CreateGameState extends State<CreateGame> {
  void getdata() {
    Firestore.instance
        .collection("user 1")
        .document("FbrBJ9fjZuzNmgH5I4lb")
        .updateData({"name": "$playername", "gameid": "$unqcode1"});
  }

  void getname() {
    Firestore.instance
        .collection('user 1')
        .document('FbrBJ9fjZuzNmgH5I4lb')
        .get()
        .then(
      (data) {
        var name1 = data['name'].toString();
        var ucode = data['gameid'].toString();
        print(name1);
        print(ucode);

        setState(() {
          pname = name1;
          uncode = ucode;
        });
        print(pname);
        print(uncode);
      },
    );
  }

  final _firestore = Firestore.instance;
  var playername;
  var unqcode1;
  var pname;
  var uncode;
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
                playername = value;
                print(playername);
              },
            ),
            TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter any Unique code of your choice'),
              onChanged: (value) {
                unqcode1 = value;
                print(unqcode1);
              },
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
            SizedBox(
              height: 30,
            ),
//            OutlineButton(onPressed: (){
//              getname();},child: Text("save data locally")),
            SizedBox(
              height: 30,
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
              child: Text("call friend"),
            ),
          ],
        ),
      ),
    );
  }
}
