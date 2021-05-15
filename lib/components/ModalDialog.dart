import 'package:flutter/material.dart';

class ModalDialog extends StatelessWidget {

  String title;
  String content;
  String textBtn;
  VoidCallback btnAction;

  ModalDialog(this.title, this.content, this.textBtn, this.btnAction);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(this.title),
      content: Text(this.content),
      actions: <Widget>[
        TextButton(
            onPressed: this.btnAction,
            child: Text(this.textBtn))
      ],
    );
  }
}
