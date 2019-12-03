import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class MsgDialog {
  static void showMsgDialog(BuildContext context, String title, String msg) {
    showDialog(
        context: context,
        builder: (_) => FlareGiffyDialog(
              flarePath: 'assets/Space-Demo.flr',
              flareAnimation: 'loading',
              title: Text(title,
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
              ),
              description: Text(
                msg,
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
              onOkButtonPressed: () {
                Navigator.of(context).pop(MsgDialog);
              },
            ));
    ;
  }
}
