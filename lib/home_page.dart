import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/dialog_box.dart';
import 'package:tictactoe/reusable_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ReusableCard> buttonsList;
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

  void playGame(ReusableCard gb) {
    setState(() {
      if (activePlayer == 1) {
        gb.text = "X";
        gb.bg = Color(0xFFEB1555);
        activePlayer = 2;
        player1.add(gb.id);
      } else {
        gb.text = "O";
        gb.bg = Colors.black;
        activePlayer = 1;
        player2.add(gb.id);
      }
      gb.enabled = false;
      int winner = checkWinner();
      if (winner == -1) {
        if (buttonsList.every((p) => p.text != "")) {
          draw++;
          showDialog(
              context: context,
              builder: (_) => new DialogBox("It's a Draw!", restartGame));
        } else {
          activePlayer == 2 ? autoPlay() : null;
        }
      }
    });
  }

  void autoPlay() {
//    sleep(const Duration(seconds: 5));
    var emptyCells = new List();
    var list = new List.generate(9, (i) => i + 1);
    for (var cellID in list) {
      if (!(player1.contains(cellID) || player2.contains(cellID))) {
        emptyCells.add(cellID);
      }
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      var r = new Random();
      var randIndex = r.nextInt(emptyCells.length - 1);
      var cellID = emptyCells[randIndex];
      int i = buttonsList.indexWhere((p) => p.id == cellID);
      playGame(buttonsList[i]);
    });
  }

  int checkWinner() {
    var winner = -1;
    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
      winner = 2;
    }

    // row 2
    if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
      winner = 1;
    }
    if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
      winner = 2;
    }

    // row 3
    if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
      winner = 2;
    }

    // col 1
    if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
      winner = 2;
    }

    // col 2
    if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
      winner = 1;
    }
    if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
      winner = 2;
    }

    // col 3
    if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(6) && player2.contains(9)) {
      winner = 2;
    }

    //diagonal
    if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
      winner = 2;
    }

    if (player1.contains(3) && player1.contains(5) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(5) && player2.contains(7)) {
      winner = 2;
    }

    if (winner != -1) {
      if (winner == 1) {
        wins++;
        showDialog(
            context: context,
            builder: (_) => new DialogBox("You Win", restartGame));
      } else {
        loses++;
        showDialog(
            context: context,
            builder: (_) => new DialogBox("You Lose", restartGame));
      }
    }

    return winner;
  }

  void restartGame() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttonsList = doInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Tic Tac Toe"),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: new GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 9.0,
                  mainAxisSpacing: 9.0),
              itemCount: buttonsList.length,
              itemBuilder: (context, i) => new SizedBox(
                width: 100.0,
                height: 100.0,
                child: new RaisedButton(
                  padding: const EdgeInsets.all(8.0),
                  onPressed: buttonsList[i].enabled
                      ? () => playGame(buttonsList[i])
                      : null,
                  child: new Text(
                    buttonsList[i].text,
                    style: new TextStyle(color: Colors.white, fontSize: 20.0),
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
                        'Wins',
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
                        'Loses',
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
          new RaisedButton(
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
