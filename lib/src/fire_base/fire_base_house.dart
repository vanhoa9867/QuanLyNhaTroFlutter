import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

class HouseService {
  String houseId;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void createHouse(String name, String address, String number,
      String note,Function onSuccess, Function(String) onRegisterError){
    _firebaseAuth.currentUser().then((user){
      _createHouse(name,address,number,note,user.uid, onSuccess, onRegisterError);
      print(user);
      var SL = int.parse(number);
      for(int i = 0; i< SL; i++){
        createRoom("Phong " + (i+1).toString(), "Customer " + (i+1).toString(), onSuccess);
      }
    }).catchError((err){
      onRegisterError("Create fail, please try again");
    });
  }

  _createHouse(String name, String address, String number,
      String note,String Creator,Function onSuccess, Function(String)onRegisterError) {
    var id = Uuid();
    houseId = id.v1();
    var house = {
      "houseID": houseId,
      "name": name,
      "address": address,
      "number": number,
      "note": note,
      "Creater": Creator
    };
    var ref = FirebaseDatabase.instance.reference().child("houses").child(Creator);
    ref.child(houseId).set(house).then((house) {
      onSuccess();
    }).catchError((err) {
      onRegisterError("Create fail");
    });
  }

  void createRoom(String name, String customer,Function onSuccess){
    _firebaseAuth.currentUser().then((user){
      _createRoom(name, customer,houseId, user.uid, onSuccess);
      print(user);
    });
  }

  _createRoom(String name, String customer,String houseId,String user_id, Function onSuccess){
    var id = Uuid();
    String roomId = id.v1();
    var room = {
      "roomId" : roomId,
      "name" : name,
      "customer": customer,
      "houseId": houseId,
      "status" : "Trống",
      "price" : '1500000'
    };
    var ref = FirebaseDatabase.instance.reference().child("room");
    ref.child(user_id).child(roomId).set(room).then((room){
      onSuccess();
    });
  }

  void updateRoom(String name,String price,String roomId, Function onSuccess){
    _firebaseAuth.currentUser().then((user){
      _updateRoom(name,price,roomId,user.uid,onSuccess);
      print(user);
    });
  }
  _updateRoom(String name,String price,String roomId,String user_id, Function onSuccess){
    var ref = FirebaseDatabase.instance.reference().child("room");
    ref.child(user_id).child(roomId).update({
      'name': name,
      'price': price,
    });
  }
}