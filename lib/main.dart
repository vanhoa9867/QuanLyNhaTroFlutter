import 'package:flutter/material.dart';
import 'package:flutter_app/src/app.dart';
import 'package:flutter_app/src/resources/create_house.dart';
import 'package:flutter_app/src/resources/login_page.dart';
import 'src/blocs/Register_bloc.dart';

void main() => runApp(MyApp(
    new RegisterBloc(),
    MaterialApp(
      theme: ThemeData(fontFamily: 'Quicksand'),
      home: LoginPage(),
    )));
