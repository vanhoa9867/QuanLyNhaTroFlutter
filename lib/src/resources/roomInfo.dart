import 'package:flutter/material.dart';
import 'package:flutter_app/src/model/room.dart';

class RoomInfo extends StatefulWidget {
  RoomData roomData;
  RoomInfo(this.roomData, {Key key}) : super (key: key);
  @override
  _RoomInfoState createState() => _RoomInfoState();
}

class _RoomInfoState extends State<RoomInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 170.0,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Room info'),
              background: SizedBox.expand(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Image.asset('assets/ic_avatar.png'),
                    Container(color: Colors.blue,)
                  ],
                ),
              ),
            ),
            elevation: 2.0,
            forceElevated: true,
            pinned: true,
          ),
          SliverList(
              delegate: SliverChildListDelegate(<Widget>[
                Container(
                  padding: EdgeInsets.only(top: 25.0),
                  child: Center(
                    child: Text('adaaa', style: TextStyle(fontSize: 20.0),),
                  ),
                ),
                Divider(),
              ])
          ),
        ],
      ),
    );
  }
}
