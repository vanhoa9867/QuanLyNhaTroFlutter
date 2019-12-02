import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/model/house.dart';
import 'package:flutter_app/src/model/room.dart';
import 'package:flutter_app/src/resources/roomInfo.dart';

class ListRoom extends StatefulWidget {
  HouseData house;

  ListRoom(this.house, {Key key}) : super(key: key);

  @override
  _ListRoomState createState() => _ListRoomState();
}

class _ListRoomState extends State<ListRoom> {
  List<RoomData> allData = [];
  List<RoomData> emptyData = [];
  List<RoomData> leasedData = [];

  @override
  void initState() {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    FirebaseAuth.instance.currentUser().then((user) {
      ref.child('room').once().then((DataSnapshot snap) {
        var keys = snap.value.keys;
        var data = snap.value;
        for (var key in keys) {
          if (data[key]['houseId'].toString() ==
              widget.house.houseID.toString()) {
            RoomData d = new RoomData(
              data[key]['customer'],
              data[key]['name'],
              data[key]['price'],
              data[key]['status'],
              data[key]['roomId'],
              data[key]['houseId'],
            );
            allData.add(d);
          }
          if (data[key]['houseId'].toString() ==
              widget.house.houseID.toString()) {
            if (data[key]['status'].toString() == "Trống") {
              RoomData empty = new RoomData(
                data[key]['customer'],
                data[key]['name'],
                data[key]['price'],
                data[key]['status'],
                data[key]['roomId'],
                data[key]['houseId'],
              );
              emptyData.add(empty);
            }
          }
          if (data[key]['houseId'].toString() ==
              widget.house.houseID.toString()) {
            if (data[key]['status'].toString() == "Đã thuê") {
              RoomData leased = new RoomData(
                data[key]['customer'],
                data[key]['name'],
                data[key]['price'],
                data[key]['status'],
                data[key]['roomId'],
                data[key]['houseId'],
              );
              leasedData.add(leased);
            }
          }
        }
        setState(() {
          print('length: ${allData.length}');
          print('houseId: ${widget.house.houseID}');
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
                color: Colors.black,
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.of(context).pop()),
            title: Text(
              '${widget.house.name}',
              style: TextStyle(color: Colors.black),
            ),
            elevation: 0,
            bottom: TabBar(
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              tabs: [
                Tab(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.menu),
                          Text('Tất cả'),
                        ],
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.bookmark),
                          Text('Đã thuê'),
                        ],
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.bookmark_border),
                          Text('Trống'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: allData.length == 0
                    ? new Text('No data Available')
                    : new ListView.builder(
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.symmetric(horizontal: 14.0),
                        itemCount: allData.length,
                        itemBuilder: (_, index) {
                          return UI(
                            allData[index].name,
                            allData[index].customer,
                            allData[index].price,
                            allData[index].status,
                            allData[index].roomId,
                            allData[index].houseId,
                          );
                        }),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: leasedData.length == 0
                    ? new Text('No data Available')
                    : new ListView.builder(
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.symmetric(horizontal: 14.0),
                        itemCount: leasedData.length,
                        itemBuilder: (_, index) {
                          return UI(
                            leasedData[index].name,
                            leasedData[index].customer,
                            leasedData[index].price,
                            leasedData[index].status,
                            leasedData[index].roomId,
                            leasedData[index].houseId,
                          );
                        }),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: emptyData.length == 0
                    ? new Text('No data Available')
                    : new ListView.builder(
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.symmetric(horizontal: 14.0),
                        itemCount: emptyData.length,
                        itemBuilder: (_, index) {
                          return UI(
                            emptyData[index].name,
                            emptyData[index].customer,
                            emptyData[index].price,
                            emptyData[index].status,
                            emptyData[index].roomId,
                            emptyData[index].houseId,
                          );
                        }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget UI(String customer, String nameRoom, String priceRoom, String status,
      String roomId, String houseId) {
    RoomData newRoom =
        new RoomData(nameRoom, customer, priceRoom, status, roomId, houseId);
    bool setColor = true;
    if (status.toString() == 'Đã thuê') {
      setColor = false;
    }

    /// Item card
    return new Container(
      child: Padding(
        padding: EdgeInsets.only(bottom: 16.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: SizedBox.fromSize(
              size: Size.fromHeight(132.0),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  /// Item description inside a material
                  Container(
                    margin: EdgeInsets.only(top: 14.0),
                    child: Material(
                      elevation: 14.0,
                      borderRadius: BorderRadius.circular(12.0),
                      shadowColor: Color(0x802196F3),
                      color: Colors.white,
                      child: InkWell(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => RoomInfo(newRoom))),
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              /// Title and rating
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('$houseId',
                                      style:
                                          TextStyle(color: Colors.blueAccent)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text('$customer',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 24.0)),
                                    ],
                                  ),
                                ],
                              ),

                              /// Infos
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text('Giá phòng ', style: TextStyle()),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    child: Text('${priceRoom.toString()}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700)),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    child: Container(
                                      child: Material(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: setColor
                                            ? Colors.green
                                            : Colors.red,
                                        child: Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Text('${status.toString()}',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// Item image
                  /*Align(
                    alignment: Alignment.topRight,
                    child: Padding
                      (
                      padding: EdgeInsets.only(right: 16.0),
                      child: SizedBox.fromSize
                        (
                        size: Size.fromRadius(54.0),
                        child: Material
                          (
                          elevation: 20.0,
                          shadowColor: Color(0x802196F3),
                          shape: CircleBorder(),
                          child: Image.asset('assets/images/ic_house_error.png'),
                        ),
                      ),
                    ),
                  ),*/
                ],
              )),
        ),
      ),
    );
  }

  bool setColor(String status) {
    if (status.toString() == 'Đã thuê') {
      return true;
    }
    return false;
  }
}
