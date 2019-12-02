import 'package:flutter/material.dart';

//import 'color.dart';

FlatButton froyoFlatBtn(String text, onPressed) {
  return FlatButton(
    onPressed: onPressed,
    child: Text(text),
    textColor: Colors.white,
    color: Color(0xff44c662),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  );
}

OutlineButton froyoOutlineBtn(String text, onPressed) {
  return OutlineButton(
    onPressed: onPressed,
    child: Text(text),
    textColor: Color(0xff44c662),
    highlightedBorderColor: Colors.green,
    borderSide: BorderSide(color: Color(0xff44c662)),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  );
}