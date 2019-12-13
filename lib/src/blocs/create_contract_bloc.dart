import 'dart:async';
import 'package:flutter_app/src/fire_base/fire_base_auth.dart';
import 'package:flutter_app/src/fire_base/fire_base_contract.dart';
import 'package:flutter_app/src/fire_base/fire_base_house.dart';
import 'package:flutter_app/src/validators/validations.dart';

class CreateContractBloc{
  var _firAuth = FirAuth();
  var _firAuthContract = ContractService();

  //Thong tin hop dong
  StreamController _NgayVaoController = new StreamController();
  StreamController _ThoiHanController = new StreamController();
  StreamController _GiaPhongController = new StreamController();
  StreamController _TienCocController = new StreamController();
  StreamController _ChuKyTraTienController = new StreamController();
  StreamController _NgayThuTenController = new StreamController();

  //Thong tin khach thue
  StreamController _TenPartnerController = new StreamController();
  StreamController _PhoneNumberController = new StreamController();
  StreamController _EmailPartnerController = new StreamController();
  StreamController _BirthdayPartnerController = new StreamController();
  StreamController _CMNDController = new StreamController();
  StreamController _AddressPartnerController = new StreamController();

  //Stream hop dong
  Stream get ngayVaoStream => _NgayVaoController.stream;
  Stream get thoiHanStream => _ThoiHanController.stream;
  Stream get giaPhongStream => _GiaPhongController.stream;
  Stream get TienCocStream => _TienCocController.stream;
  Stream get chuKyTraTienStream => _ChuKyTraTienController.stream;
  Stream get ngayThuTienStream => _NgayThuTenController.stream;

  //Stream khach thue
  Stream get tenPartnerStream => _TenPartnerController.stream;
  Stream get phoneNumberStream => _PhoneNumberController.stream;
  Stream get emailPartnerStream => _EmailPartnerController.stream;
  Stream get birthDayPartnerStream => _BirthdayPartnerController.stream;
  Stream get CMNDpartnerStream => _CMNDController.stream;
  Stream get addressPartnerStream => _AddressPartnerController.stream;



  bool isValid(String ngayvao,String thoihan,String giaphong,String tiencoc,String chuky,String ngaythu,String namePartner,String phoneNumber,String cmnd,String addressPartner){
    if(!Validations.isValidFullname(ngayvao)){
      _NgayVaoController.sink.addError("Nhập đầy đủ thông tin");
      return false;
    }
    _NgayVaoController.sink.add("OK");

    if(!Validations.isValidFullname(thoihan)){
      _ThoiHanController.sink.addError("Nhập đầy đủ thông tin");
      return false;
    }
    _ThoiHanController.add("OK");

    if(!Validations.isValidFullname(giaphong)){
      _GiaPhongController.sink.addError("Nhập đầy đủ thông tin");
      return false;
    }
    _GiaPhongController.add("OK");

    if(!Validations.isValidFullname(tiencoc)){
      _TienCocController.sink.addError("Nhập đầy đủ thông tin");
      return false;
    }
    _TienCocController.add("OK");
    if(!Validations.isValidFullname(chuky)){
      _ChuKyTraTienController.sink.addError("Nhập đầy đủ thông tin");
      return false;
    }
    _ChuKyTraTienController.add("OK");
    if(!Validations.isValidFullname(ngaythu)){
      _NgayThuTenController.sink.addError("Nhập đầy đủ thông tin");
      return false;
    }
    _NgayThuTenController.add("OK");
    if(!Validations.isValidFullname(namePartner)){
      _TenPartnerController.sink.addError("Nhập đầy đủ thông tin");
      return false;
    }
    _TenPartnerController.add("OK");
    if(!Validations.isValidFullname(phoneNumber)){
      _PhoneNumberController.sink.addError("Nhập đầy đủ thông tin");
      return false;
    }
    _PhoneNumberController.add("OK");
    if(!Validations.isValidFullname(cmnd)){
      _CMNDController.sink.addError("Nhập đầy đủ thông tin");
      return false;
    }
    _CMNDController.add("OK");
    if(!Validations.isValidFullname(addressPartner)){
      _AddressPartnerController.sink.addError("Nhập đầy đủ thông tin");
      return false;
    }
    _AddressPartnerController.add("OK");

  }
  void createContract(String ngayvao,String thoihan,String giaphong,String tiencoc,String chuky,String ngaythu,String roomID,String tenPartner, String phoneNumber,String email,String birthday,String cmnd,String address,Function onSuccess, Function(String) onRegisterError){
    _firAuthContract.createContract(ngayvao,thoihan,giaphong,tiencoc,chuky,ngaythu,roomID,tenPartner, phoneNumber,email,birthday,cmnd,address, onSuccess, onRegisterError);
  }
  void createPartner(String roomID,String tenPartner, String phoneNumber,String email,String birthday,String cmnd,String address,Function onSuccess, Function(String) onRegisterError){
    _firAuthContract.createPartner(roomID, tenPartner, phoneNumber, email, birthday, cmnd, address, onSuccess, onRegisterError);
  }
  void dispose(){
    _NgayVaoController.close();
    _ThoiHanController.close();
    _GiaPhongController.close();
    _TienCocController.close();
    _ChuKyTraTienController.close();
    _NgayThuTenController.close();
    _TenPartnerController.close();
    _PhoneNumberController.close();
    _EmailPartnerController.close();
    _BirthdayPartnerController.close();
    _CMNDController.close();
    _AddressPartnerController.close();
  }
}