import 'dart:async';

import 'package:flutter_app/src/validators/validations.dart';

class LoginBloc{
  StreamController _userController = new StreamController();
  StreamController _passController = new StreamController();

  Stream get userStream => _userController.stream;
  Stream get passStream => _passController.stream;

  bool isValidInfo(String username, String pass){
    if(!Validations.isValidUser(username)){
      _userController.sink.addError("Tài khoản không hợp lệ");
      return false;
    }
    _userController.sink.add("Ok");

    if(!Validations.isValidPass(pass)){
      _passController.sink.addError("Mật khẩu phải trên 6 kí tự");
      return false;
    }
    _passController.sink.add("Ok");
    return true;
  }
  void dispose(){
    _userController.close();
    _passController.close();
  }
}