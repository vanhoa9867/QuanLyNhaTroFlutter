import 'dart:async';
import 'package:flutter_app/src/fire_base/fire_base_auth.dart';
import 'package:flutter_app/src/fire_base/fire_base_house.dart';
import 'package:flutter_app/src/validators/validations.dart';

class CreateHouseBloc{
  var _firAuth = FirAuth();
  var _firAuthHouse = HouseService();

  StreamController _nameHouseController = new StreamController();
  StreamController _addressHouseController = new StreamController();
  StreamController _numberHouseController = new StreamController();
  StreamController _noteHouseController = new StreamController();

  Stream get nameHouseStream => _nameHouseController.stream;
  Stream get addressHouseStream => _addressHouseController.stream;
  Stream get numberHouseStream => _numberHouseController.stream;
  Stream get noteHouseStream => _noteHouseController.stream;



  bool isValid(String name,String address,String number,String note){
    if(!Validations.isValidFullname(name)){
      _nameHouseController.sink.addError("Nhập tên");
      return false;
    }
    _nameHouseController.sink.add("OK");

    if(!Validations.isValidAddress(address)){
      _addressHouseController.sink.addError("Nhập địa chỉ");
      return false;
    }
    _addressHouseController.add("OK");

    if(!Validations.isValidNumber(number)){
      _numberHouseController.sink.addError("Số lượng không hợp lệ (tối đa 20)");
      return false;
    }
    _numberHouseController.add("OK");

    if(!Validations.isValidNote(note)){
      _noteHouseController.sink.addError("Nhập note");
      return false;
    }
    _noteHouseController.add("OK");

  }
  void createHouse(String name, String address, String number, String note, Function onSuccess, Function(String)onRegisterError){
    _firAuthHouse.createHouse(name, address, number, note, onSuccess, onRegisterError);
  }

  void dispose(){
    _nameHouseController.close();
    _addressHouseController.close();
    _numberHouseController.close();
    _noteHouseController.close();
  }
}