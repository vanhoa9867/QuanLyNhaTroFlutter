import 'package:flutter/material.dart';
import 'package:flutter_app/src/model/house.dart';

class ListRoom extends StatefulWidget {
  HouseData house;
  ListRoom(this.house, {Key key}) : super (key: key);
  @override
  _ListRoomState createState() => _ListRoomState();
}

class _ListRoomState extends State<ListRoom> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: 'All',),
                Tab(text: 'Leased',),
                Tab(text: 'Empty',),
              ],
            ),
            title: Text('List Room'),
            elevation: 0,
            iconTheme: IconThemeData(),
          ),
          body: TabBarView(
            children: [
              Container(

              ),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
