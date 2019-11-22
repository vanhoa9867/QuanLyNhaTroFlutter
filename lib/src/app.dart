import 'package:flutter/material.dart';
import 'package:flutter_app/src/blocs/Register_bloc.dart';

class MyApp extends InheritedWidget {
  final RegisterBloc authBloc;
  final Widget child;
  MyApp (this.authBloc, this.child) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
  static MyApp of(BuildContext context){
    return context.inheritFromWidgetOfExactType(MyApp);
  }
}