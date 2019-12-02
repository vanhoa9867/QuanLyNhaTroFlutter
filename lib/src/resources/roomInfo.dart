import 'package:flutter/material.dart';
import 'package:flutter_app/src/model/room.dart';
import 'package:flutter_app/src/resources/add_contract_page.dart';

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
                  padding: EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 54.0),
                      child: Material(
                        elevation: 8.0,
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(32.0),
                        child: InkWell(
                          onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddContractPage(widget.roomData))),
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.add, color: Colors.white,),
                                Padding(padding: EdgeInsets.only(right: 16.0)),
                                Text('Tạo hợp đồng', style: TextStyle(color: Colors.white),)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
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
