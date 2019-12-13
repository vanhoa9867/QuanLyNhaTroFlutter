import 'package:flutter/material.dart';
import 'package:flutter_app/src/app.dart';
import 'package:flutter_app/src/resources/introduce/Splash.dart';
import 'package:flutter_app/src/resources/service_locator.dart';
import 'src/blocs/Register_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MyApp(
      new RegisterBloc(),
    new MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.lightBlue, accentColor: Colors.blueAccent),
        debugShowCheckedModeBanner: false,
        home: new SplashScreen(),
    ),
  ));
}

