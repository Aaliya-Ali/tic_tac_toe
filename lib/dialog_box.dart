import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final title;
  final VoidCallback callback;
  final actionText;
  final content = "Press the restart button to start again.";

  DialogBox(this.title, this.callback, [this.actionText = "Restart"]);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        title: new Text(title),
        content: new Text(content),
        actions: <Widget>[
          new FlatButton(
            onPressed: callback,
            color: Colors.white,
            child: new Text(actionText),
          )
        ],
      ),
    );
  }
}

class EnterPlayerNamePopUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String matchID;
    return AlertDialog(
      title: Text('Match Details'),
      content: TextField(
          autofocus: true,
          decoration:
              InputDecoration(hintText: 'Enter a match ID of your choice'),
          onChanged: (newText) {
            matchID = newText;
            print(matchID);
          }),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            print(matchID);
          },
          color: Colors.white,
          child: Text('Go'),
        )
      ],
    );
  }
}
