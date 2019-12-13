import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

class ContractService {
  String contractId;
  String partnerId;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void createContract(String ngayvao,String thoihan,String giaphong,String tiencoc,String chuky,String ngaythu,String roomID,String tenPartner, String phoneNumber,String email,String birthday,String cmnd,String address,Function onSuccess, Function(String) onRegisterError){
    _firebaseAuth.currentUser().then((user){
      _createPartner(tenPartner, user.uid, phoneNumber,email,birthday,cmnd,address,roomID,onSuccess, onRegisterError);
      _createContract(ngayvao,thoihan,giaphong,tiencoc,chuky,ngaythu,roomID,user.uid,tenPartner,user.uid, onSuccess, onRegisterError);
      print(user);
    }).catchError((err){
      onRegisterError("Create fail, please try again");
    });
  }

  _createContract(String ngayvao,String thoihan,String giaphong,String tiencoc,String chuky,String ngaythu,String roomID,String Creator,String tenPartner,String user_id,Function onSuccess, Function(String)onRegisterError) {
    var id = Uuid();
    contractId = id.v1();
    var contract = {
      "ngaykhachvao": ngayvao,
      "thoihan": thoihan,
      "giaphong": giaphong,
      "tiencoc": tiencoc,
      "chuky": chuky,
      "ngaythu": ngaythu,
      "khachID": partnerId,
      "contractID": contractId,
      "status" : 'Còn hiệu lực'
    };
    var ref = FirebaseDatabase.instance.reference().child("contracts").child(Creator).child(roomID);
    ref.child(contractId).set(contract).then((contract) {
      _updateStatusRoom(roomID,user_id);
      onSuccess();
    }).catchError((err) {
      onRegisterError("Create fail");
    });
  }
  /*void createPartner(tenPartner,Creator, onSuccess, onRegisterError){
    _firebaseAuth.currentUser().then((user){
      _createPartner(tenPartner,user.uid, onSuccess, onRegisterError);
      print(user);
    }).catchError((err){
      onRegisterError("Create fail, please try again");
    });
  }*/
  void createPartner(String roomID,String tenPartner, String phoneNumber,String email,String birthday,String cmnd,String address,Function onSuccess, Function(String) onRegisterError){
    _firebaseAuth.currentUser().then((user){
      _createPartner(tenPartner, user.uid, phoneNumber,email,birthday,cmnd,address,roomID,onSuccess, onRegisterError);
      print(user);
    }).catchError((err){
      onRegisterError("Create fail, please try again");
    });
  }
  _createPartner(String ten,String creater, String phoneNumber,String email,String birhday,String cmnd,String address,String roomId,Function onSuccess, Function(String)onRegisterError){
    var id = Uuid();
    partnerId = id.v1();
    var partner = {
      "name": ten,
      "partnerID": partnerId,
      "phone number": phoneNumber,
      "email": email,
      "birthday": birhday,
      "CMND": cmnd,
      "address": address,
      "rent": roomId,
    };
    var ref = FirebaseDatabase.instance.reference().child("partners").child(creater);
    ref.child(partnerId).set(partner).then((partner) {
      onSuccess();
    }).catchError((err) {
      onRegisterError("Create fail");
    });
  }
  _updateStatusRoom(String roomId,String user_id){
    var ref = FirebaseDatabase.instance.reference().child("room").child(user_id).child(roomId);
    ref.child('status').set('Đã thuê');
  }
}