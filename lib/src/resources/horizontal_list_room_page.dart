import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/model/room.dart';
import 'package:flutter_app/src/resources/widget/room_card_page.dart';

class HorizontalListRoom extends StatefulWidget {
  @override
  _HorizontalListRoomState createState() => _HorizontalListRoomState();
}

class _HorizontalListRoomState extends State<HorizontalListRoom> {
  double _height;
  double _width;
  List<RoomData> trendingListItems =[];

  @override
  void initState() {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    FirebaseAuth.instance.currentUser().then((user) {
      ref.child('room').child(user.uid).once().then((DataSnapshot snap) {
        var keys = snap.value.keys;
        var data = snap.value;
        for (var key in keys) {
          if(data[key]['status'].toString() == "Đã thuê"){
            RoomData d = new RoomData(
              data[key]['customer'],
              data[key]['name'],
              data[key]['price'],
              data[key]['status'],
              data[key]['roomId'],
              data[key]['houseId'],
            );
            trendingListItems.add(d);
          }
        }
        setState(() {
          print('list roomTrending length: ${trendingListItems.length}');
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    return Container(
      child: trendingProducts(),
    );
  }

  Widget trendingProducts() {
    return Container(
      height: _height / 4.25,
      //width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        padding: EdgeInsets.all(5),
        shrinkWrap: true,
        itemCount: trendingListItems.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, index) {
          return _buildTrendingEntries(context, index, trendingListItems);
        },
      ),
    );
  }

  Widget _buildTrendingEntries(BuildContext context, int index, List<RoomData> listItem) {
    return GestureDetector(
      onTap: () {
        print("Routing to trending list page");
      },
      child: RoomCard(
        '${listItem[index].customer}',
        '${listItem[index].name}',
        '${listItem[index].price}',
        '${listItem[index].status}',
        '${listItem[index].roomId}',
        '${listItem[index].houseId}',
      ),
    );
  }
}