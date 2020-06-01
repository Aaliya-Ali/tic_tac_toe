import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/dialog_box.dart';
import 'package:tictactoe/reusable_card.dart';

String mode;

class OnlineGameBoard extends StatefulWidget {
  @override
  _OnlineGameBoardState createState() => new _OnlineGameBoardState();
}

class _OnlineGameBoardState extends State<OnlineGameBoard> {
  List<ReusableCard> buttonsList;
  String player;
  var player1;
  var player2;
  int wins = 0;
  int draw = 0;
  int loses = 0;
  var activePlayer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buttonsList = doInit();
  }

  List<ReusableCard> doInit() {
    player1 = new List();
    player2 = new List();
    activePlayer = 1;

    var gameButtons = <ReusableCard>[
      new ReusableCard(id: 1),
      new ReusableCard(id: 2),
      new ReusableCard(id: 3),
      new ReusableCard(id: 4),
      new ReusableCard(id: 5),
      new ReusableCard(id: 6),
      new ReusableCard(id: 7),
      new ReusableCard(id: 8),
      new ReusableCard(id: 9),
    ];
    return gameButtons;
  }

  var tile1;
  var tile2;
  var tile3;
  var tile4;
  var tile5;
  var tile6;
  var tile7;
  var tile8;
  var tile9;
  var winner = -1;

  void playGame(List<ReusableCard> gb, int i) {
    setState(() {
      winner = -1;
      if (activePlayer == 1) {
//        gb[i].text = "X";
//        gb[i].bg = Color(0xFFEB1555);
        activePlayer = 2;
        player1.add(gb[i].id);
        Firestore.instance
            .collection("game_board")
            .document("wAtsmnBWtbzHyhFdSB7g")
            .updateData({"${gb[i].id}": 'X'});
      } else {
//        gb[].text = "O";
//        gb[i].bg = Colors.black;
        activePlayer = 1;
        player2.add(gb[i].id);
        Firestore.instance
            .collection("game_board")
            .document("wAtsmnBWtbzHyhFdSB7g")
            .updateData({"${gb[i].id}": 'O'});
      }
      gb[i].enabled = false;
      updateUI(gb);

      var win = checkWinner();
      print(win);
      if (win.toString() == '-1') {
        if (buttonsList.every((p) => p.text != " ")) {
          draw++;
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => new DialogBox("It's a Draw!", restartGame));
        }
      }
    });
  }

  Future<int> checkWinner() async {
    winner = -1;
    await Firestore.instance
        .collection("game_board")
        .document("wAtsmnBWtbzHyhFdSB7g")
        .get()
        .then((value) {
      tile1 = value['1'];
      tile2 = value['2'];
      tile3 = value['3'];
      tile4 = value['4'];
      tile5 = value['5'];
      tile6 = value['6'];
      tile7 = value['7'];
      tile8 = value['8'];
      tile9 = value['9'];
    });
    if (tile1 == 'X' && tile2 == 'X' && tile3 == 'X') {
      winner = 1;
    }
    if (tile1 == 'O' && tile2 == 'O' && tile3 == 'O') {
      winner = 2;
    }

    // row 2
    if (tile4 == 'X' && tile5 == 'X' && tile6 == 'X') {
      winner = 1;
    }
    if (tile4 == 'O' && tile5 == 'O' && tile6 == 'O') {
      winner = 2;
    }

    // row 3
    if (tile7 == 'X' && tile8 == 'X' && tile9 == 'X') {
      winner = 1;
    }
    if (tile7 == 'O' && tile8 == 'O' && tile9 == 'O') {
      winner = 2;
    }

    // col 1
    if (tile1 == 'X' && tile4 == 'X' && tile7 == 'X') {
      winner = 1;
    }
    if (tile1 == 'O' && tile4 == 'O' && tile7 == 'O') {
      winner = 2;
    }

    // col 2
    if (tile2 == 'X' && tile5 == 'X' && tile8 == 'X') {
      winner = 1;
    }
    if (tile2 == 'O' && tile5 == 'O' && tile8 == 'O') {
      winner = 2;
    }

    // col 3
    if (tile3 == 'X1' && tile6 == 'X' && tile9 == 'X') {
      winner = 1;
    }
    if (tile3 == 'O' && tile6 == 'O' && tile9 == 'O') {
      winner = 2;
    }

    //diagonal
    if (tile1 == 'X' && tile5 == 'X' && tile9 == 'X') {
      winner = 1;
    }
    if (tile1 == 'O' && tile5 == 'O' && tile9 == 'O') {
      winner = 2;
    }

    if (tile3 == 'X' && tile5 == 'X' && tile7 == 'X') {
      winner = 1;
    }
    if (tile3 == 'O' && tile5 == 'O' && tile7 == 'O') {
      winner = 2;
    }
    Firestore.instance
        .collection("match_data")
        .document("xgZELxFiVFiXaLaOpwip")
        .updateData({"winner": '$winner'});

    if (winner != -1) {
      if (winner == 1) {
        wins++;
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => DialogBox("Player 1 Wins", restartGame));
      } else {
        loses++;
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => DialogBox("Player 2 Wins", restartGame));
      }
    }
    return winner;
  }

  void updateUI(List<ReusableCard> buttonList) {
    for (var button in buttonList) {
      Firestore.instance
          .collection('game_board')
          .document('wAtsmnBWtbzHyhFdSB7g')
          .get()
          .then((value) {
        button.text = value['${button.id}'];
        if (button.text == 'X') {
          button.bg = Color(0xFFEB1555);
        } else if (button.text == 'O') {
          button.bg = Colors.black;
        }
      });
    }
  }

  void restartGame() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttonsList = doInit();
      winner = -1;
      Firestore.instance
          .collection("match_data")
          .document("xgZELxFiVFiXaLaOpwip")
          .updateData({"winner": '$winner'});
    });
    for (int i = 1; i < 10; i++) {
      Firestore.instance
          .collection("game_board")
          .document("wAtsmnBWtbzHyhFdSB7g")
          .updateData({"$i": ' '});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tic Tac Toe"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 9.0,
                  mainAxisSpacing: 9.0),
              itemCount: buttonsList.length,
              itemBuilder: (context, i) => SizedBox(
                width: 100.0,
                height: 100.0,
//                child: StreamBuilder<QuerySnapshot>(
//                    stream:
//                        Firestore.instance.collection('game_board').snapshots(),
//                    builder: (context, snapshot) {
//                      var temp = snapshot.data.documents;
//                      print(temp[i].data);
                child: RaisedButton(
                  padding: const EdgeInsets.all(8.0),
                  onPressed: buttonsList[i].enabled
                      ? () => playGame(buttonsList, i)
                      : null,
                  child: Text(
                    buttonsList[i].text,
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  color: buttonsList[i].bg,
                  disabledColor: buttonsList[i].bg,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Scoreboard',
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                      height: 20.0,
                      child: Divider(
                        indent: 30.0,
                        color: Colors.grey[100],
                        endIndent: 30.0,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        mode == 'single' ? 'Wins' : 'Player 1',
                        style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 30.0,
                      ),
                      Text(
                        'Draw',
                        style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 30.0,
                      ),
                      Text(
                        mode == 'single' ? 'Loses' : 'Player 2',
                        style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        '$wins',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 30.0,
                      ),
                      Text(
                        '$draw',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 30.0,
                      ),
                      Text(
                        '$loses',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          RaisedButton(
            child: new Text(
              "Restart",
              style: new TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            color: Color(0xFFEB1555),
            padding: const EdgeInsets.all(20.0),
            onPressed: restartGame,
          )
        ],
      ),
    );
  }
}
