import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/model/room.dart';

class refreshRoomData extends InheritedWidget {

  refreshRoomData({Key key,@required Widget child,this.roomData}): super(key: key, child: child);

  final RoomData roomData;

  initState(RoomData data){
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    FirebaseAuth.instance.currentUser().then((user) {
      ref.child('room').child(user.uid).child(data.roomId).once().then((DataSnapshot snap) {
        roomData.name = snap.value["name"];
        roomData.price = snap.value["price"];
        roomData.status = snap.value["status"];
        roomData.customer = snap.value["customer"];
        roomData.houseId = snap.value["houseId"];
      });
    });
  }

  static refreshRoomData of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(refreshRoomData) as refreshRoomData;
  }

  @override
  bool updateShouldNotify(refreshRoomData oldWidget) =>
      roomData != oldWidget.roomData;
}