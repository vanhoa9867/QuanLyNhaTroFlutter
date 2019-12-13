import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class AlertDeleteDialog {
  static void showMsgDialog(BuildContext context, String title, String msg) {
    showDialog(
        context: context,
        builder: (_) => AssetGiffyDialog(
          image: Image.asset('assets/loading.gif',),
          title: Text(title,
            style: TextStyle(fontSize: 22.0,color: Colors.red, fontWeight: FontWeight.w600),
          ),
          description: Text(
            msg,
            textAlign: TextAlign.center,
            style: TextStyle(),
          ),
          entryAnimation: EntryAnimation.BOTTOM,
          onOkButtonPressed: () {
            print('do delete successful!');
            Navigator.of(context).pop(AlertDeleteDialog);
          },
        ));
    ;
  }
}
