import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

class ContractService {
  String contractId;
  String partnerId;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void createContract(String ngayvao,String thoihan,String giaphong,String tiencoc,String chuky,String ngaythu,String roomID,String tenPartner, String phoneNumber,Function onSuccess, Function(String) onRegisterError){
    _firebaseAuth.currentUser().then((user){
      _createPartner(tenPartner, user.uid, phoneNumber, onSuccess, onRegisterError);
      _createContract(ngayvao,thoihan,giaphong,tiencoc,chuky,ngaythu,roomID,user.uid,tenPartner, onSuccess, onRegisterError);
      print(user);
    }).catchError((err){
      onRegisterError("Create fail, please try again");
    });
  }

  _createContract(String ngayvao,String thoihan,String giaphong,String tiencoc,String chuky,String ngaythu,String roomID,String Creator,String tenPartner,Function onSuccess, Function(String)onRegisterError) {
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
      "contractID": contractId
    };
    var ref = FirebaseDatabase.instance.reference().child("contracts").child(Creator).child(roomID);
    ref.child(contractId).set(contract).then((contract) {
      _updateStatusRoom(roomID);
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
  _createPartner(String ten,String creater, String phoneNumber,Function onSuccess, Function(String)onRegisterError){
    var id = Uuid();
    partnerId = id.v1();
    var partner = {
      "name": ten,
      "partnerID": partnerId,
      "phone number": phoneNumber,
    };
    var ref = FirebaseDatabase.instance.reference().child("partners").child(creater);
    ref.child(partnerId).set(partner).then((partner) {
      onSuccess();
    }).catchError((err) {
      onRegisterError("Create fail");
    });
  }
  _updateStatusRoom(String roomId){
    var ref = FirebaseDatabase.instance.reference().child("room").child(roomId);
    ref.child('status').set('Đã thuê');
  }
}