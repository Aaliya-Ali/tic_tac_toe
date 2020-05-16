import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final title;
  final content = "Press the restart button to start again.";
  final VoidCallback callback;
  final actionText;

  DialogBox(this.title, this.callback, [this.actionText = "Restart"]);
  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: new Text(title),
      content: new Text(content),
      actions: <Widget>[
        new FlatButton(
          onPressed: callback,
          color: Colors.white,
          child: new Text(actionText),
        )
      ],
    );
  }
}
