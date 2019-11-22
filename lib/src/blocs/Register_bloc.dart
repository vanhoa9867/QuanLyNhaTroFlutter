import 'package:flutter_app/src/fire_base/fire_base_auth.dart';
import 'package:flutter_app/src/validators/validations.dart';
import 'dart:async';

class RegisterBloc {
  var _firAuth = FirAuth();

  StreamController _fullnameController = new StreamController();
  StreamController _phoneController = new StreamController();
  StreamController _emailController = new StreamController();
  StreamController _passwordController = new StreamController();

  Stream get FullNameStream  => _fullnameController.stream;
  Stream get PassStream  => _passwordController.stream;
  Stream get PhoneStream  => _phoneController.stream;
  Stream get EmailStream  => _emailController.stream;

  bool isValid(String name, String email,String phone,String pass){

    if(!Validations.isValidFullname(name)){
      _fullnameController.sink.addError("Nhập tên");
      return false;
    }
    _fullnameController.sink.add("");

    if(!Validations.isValidEmail(email)){
      _emailController.sink.addError("Nhập email");
      return false;
    }
    _emailController.sink.add("");

    if(!Validations.isValidPhone(phone)){
      _phoneController.sink.addError("Nhập số điện thoại");
      return false;
    }
    _phoneController.sink.add("");

    if(!Validations.isValidPass(pass)){
      _passwordController.sink.addError("Nhập mật khẩu");
      return false;
    }
    _passwordController.sink.add("");

    return true;
  }

  void signUp(String email, String pass, String name, String phone,Function onSuccess, Function(String)onRegisterError){
    _firAuth.signUp(email, pass, name, phone, onSuccess, onRegisterError);
  }

  void signIn (String email, String pass, Function onSuccess, Function(String) onSignInError){
    _firAuth.signIn(email, pass, onSuccess, onSignInError);
  }

  void dispose(){
    _fullnameController.close();
    _passwordController.close();
    _phoneController.close();
    _emailController.close();
  }
}

