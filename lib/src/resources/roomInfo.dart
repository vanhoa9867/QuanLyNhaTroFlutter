import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/model/room.dart';
import 'package:flutter_app/src/resources/add_contract_page.dart';
import 'package:flutter_app/src/resources/add_partner_page.dart';
import 'package:flutter_app/src/resources/dialog/alert_delete_dialog.dart';
import 'package:flutter_app/src/resources/list_contract_page.dart';
import 'package:flutter_app/src/resources/list_partner_page.dart';
import 'package:flutter_app/src/resources/update_roominfor.dart';

class RoomInfo extends StatefulWidget {
  RoomData roomData;
  RoomInfo(this.roomData, {Key key}) : super(key: key);
  @override
  _RoomInfoState createState() => _RoomInfoState();
}

class _RoomInfoState extends State<RoomInfo> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  var _height, _width;
  var _RoomUsed = false;

  @override
  void initState() {
    if (widget.roomData.status == 'Đã thuê') {
      _RoomUsed = true;
    }
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    FirebaseAuth.instance.currentUser().then((user) {
      ref.child('room').child(user.uid).child(widget.roomData.roomId).once().then((DataSnapshot snap) {
        widget.roomData.name = snap.value["name"];
        widget.roomData.price = snap.value["price"];
        widget.roomData.status = snap.value["status"];
        setState(() {
          print('RoomData loaded');
        });
      });
    });
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop()),
        title: new Text(
          '${widget.roomData.name}',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.red,
            ),
            onPressed: () {
              print('do delete room method');
              AlertDeleteDialog.showMsgDialog(
                  context, 'XÓA BỎ', 'Bạn có chắc muốn xóa bỏ phòng này!');
            },
          ),
          new IconButton(
              icon: const Icon(Icons.refresh,color: Colors.black,),
              tooltip: 'Refresh',
              onPressed: () {
                _refreshIndicatorKey.currentState.show();
              }),
        ],
      ),
      body: new RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: new Container(
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints viewportConstraints){
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                            child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new GestureDetector(
                                    onTap: (){
                                      _routingListPartner();
                                    },
                                    child: new Container(
                                      child: new Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            new Image.asset(
                                              'assets/ic_room_partner.png',
                                              scale: 10.0,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 10.0),
                                              child: new Text(
                                                "Khách thuê",
                                                style: new TextStyle(
                                                    fontSize: 18.0,
                                                    color: _RoomUsed ? const Color(0xFFFFFFFF) : const Color(0xFF000000),
                                                    fontWeight: _RoomUsed ? null : FontWeight.w200,
                                                    fontFamily: "Roboto"),
                                              ),
                                            )
                                          ]),
                                      padding: const EdgeInsets.all(0.0),
                                      alignment: Alignment.center,
                                      width: _width / 3,
                                      height: _height / 4,
                                    ),
                                  ),
                                  new Container(
                                    child: new Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          new Image.asset(
                                            'assets/ic_room_insurance.png',
                                            scale: 10.0,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10.0),
                                            child: new Text(
                                              '${widget.roomData.status}',
                                              style: new TextStyle(
                                                  fontSize: 18.0,
                                                  color: _RoomUsed ? const Color(0xFFFFFFFF) : const Color(0xFF000000),
                                                  fontWeight: _RoomUsed ? null : FontWeight.w200,
                                                  fontFamily: "Roboto"),
                                            ),
                                          )
                                        ]),
                                    padding: const EdgeInsets.all(0.0),
                                    alignment: Alignment.center,
                                    width: _width / 3,
                                    height: _height / 4,
                                  ),
                                  new GestureDetector(
                                    onTap: (){
                                      _updateInfor();
                                    },
                                    child: new Container(
                                      child: new Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            new Image.asset(
                                              'assets/ic_room_pencil.png',
                                              scale: 10.0,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 10.0),
                                              child: new Text(
                                                "Thông tin",
                                                style: new TextStyle(
                                                    fontSize: 18.0,
                                                    color: _RoomUsed ? const Color(0xFFFFFFFF) : const Color(0xFF000000),
                                                    fontWeight: _RoomUsed ? null : FontWeight.w200,
                                                    fontFamily: "Roboto"),
                                              ),
                                            )
                                          ]),
                                      padding: const EdgeInsets.all(0.0),
                                      alignment: Alignment.center,
                                      width: _width / 3,
                                      height: _height / 4,
                                    ),
                                  )
                                ]),
                            color: _RoomUsed ? Color(0xff00e676) : null,
                            padding: const EdgeInsets.all(0.0),
                            alignment: Alignment.center,
                            width: _width,
                            height: _height / 5,
                          ),
                          _RoomUsed ? UIused() : UIempty(),
                        ]),
                  ),
                );
              }
          ),
          padding: const EdgeInsets.all(0.0),
          alignment: Alignment.center,
        ),
      ),
    );
  }

  Widget UIused() {
    return new Container(
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Container(
              child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _buildTile(
                      new Container(
                        child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Image.asset(
                                'assets/ic_room_file.png',
                                scale: 9.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: new Text(
                                  "Hợp đồng",
                                  style: new TextStyle(
                                      fontSize: 18.0,
                                      color: const Color(0xFF000000),
                                      fontWeight: FontWeight.w200,
                                      fontFamily: "Roboto"),
                                ),
                              )
                            ]),
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        width: _width / 3,
                        height: _height / 4,
                        decoration: const BoxDecoration(
                          border: Border(
                            right: BorderSide(width: 1.0, color: Color(0xFFeeeeee)),
                            bottom: BorderSide(width: 1.0, color: Color(0xFFeeeeee)),
                          ),
                        ),
                      ),
                      onTap: (){
                        _viewListContract();
                      },
                    ),
                    _buildTile(
                      new Container(
                        child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Image.asset(
                                'assets/ic_room_userheart.png',
                                scale: 9.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: new Text(
                                  "Thêm khách",
                                  style: new TextStyle(
                                      fontSize: 18.0,
                                      color: const Color(0xFF000000),
                                      fontWeight: FontWeight.w200,
                                      fontFamily: "Roboto"),
                                ),
                              )
                            ]),
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        width: _width / 3,
                        height: _height / 4,
                        decoration: const BoxDecoration(
                          border: Border(
                            right: BorderSide(width: 1.0, color: Color(0xFFeeeeee)),
                            bottom: BorderSide(width: 1.0, color: Color(0xFFeeeeee)),
                          ),
                        ),
                      ),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddPartnerPage(widget.roomData))),
                    ),
                    _buildTile(
                        new Container(
                          child: new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Image.asset(
                                  'assets/ic_room_medals.png',
                                  scale: 9.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: new Text(
                                    "Dịch vụ",
                                    style: new TextStyle(
                                        fontSize: 18.0,
                                        color: const Color(0xFF000000),
                                        fontWeight: FontWeight.w200,
                                        fontFamily: "Roboto"),
                                  ),
                                )
                              ]),
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          width: _width / 3,
                          height: _height / 4,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 1.0, color: Color(0xFFeeeeee)),
                            ),
                          ),
                        )
                    ),
                  ]),
              padding: const EdgeInsets.all(0.0),
              alignment: Alignment.center,
              width: _width,
              height: _height / 5,
            ),
            new Container(
              child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _buildTile(
                      new Container(
                        child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Image.asset(
                                'assets/ic_room_calculator.png',
                                scale: 9.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: new Text(
                                  "Điện nước",
                                  style: new TextStyle(
                                      fontSize: 18.0,
                                      color: const Color(0xFF000000),
                                      fontWeight: FontWeight.w200,
                                      fontFamily: "Roboto"),
                                ),
                              )
                            ]),
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        width: _width / 3,
                        height: _height / 4,
                        decoration: const BoxDecoration(
                          border: Border(
                            right: BorderSide(width: 1.0, color: Color(0xFFeeeeee)),
                            bottom: BorderSide(width: 1.0, color: Color(0xFFeeeeee)),
                          ),
                        ),
                      ),
                    ),
                    _buildTile(
                      new Container(
                        child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Image.asset(
                                'assets/ic_room_calendar.png',
                                scale: 9.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: new Text(
                                  "Ghi chú",
                                  style: new TextStyle(
                                      fontSize: 18.0,
                                      color: const Color(0xFF000000),
                                      fontWeight: FontWeight.w200,
                                      fontFamily: "Roboto"),
                                ),
                              )
                            ]),
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        width: _width / 3,
                        height: _height / 4,
                        decoration: const BoxDecoration(
                          border: Border(
                            right: BorderSide(width: 1.0, color: Color(0xFFeeeeee)),
                            bottom: BorderSide(width: 1.0, color: Color(0xFFeeeeee)),
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      child: new RaisedButton(
                          key: null,
                          onPressed: buttonPressed,
                          color: const Color(0xFFe0e0e0),
                          child: new Text(
                            "THÊM",
                            style: new TextStyle(
                                fontSize: 18.0,
                                color: const Color(0xFF000000),
                                fontWeight: FontWeight.w200,
                                fontFamily: "Roboto"),
                          )),
                      padding: const EdgeInsets.all(0.0),
                      alignment: Alignment.center,
                      width: _width / 3,
                      height: _height / 4,
                    )
                  ]),
              padding: const EdgeInsets.all(0.0),
              alignment: Alignment.center,
              width: _width,
              height: _height / 5,
            )
          ]),
      padding: const EdgeInsets.all(0.0),
      alignment: Alignment.center,
      width: _width,
      height: _height / 2,
    );
  }

  Widget UIempty() {
    return new Container(
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Container(
                margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 54.0),
                child: Material(
                  elevation: 5.0,
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(32.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> AddContractPage(widget.roomData)));
                    },
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.add, color: Colors.white),
                          Padding(padding: EdgeInsets.only(right: 10.0)),
                          Text('Tạo hợp đồng',
                              style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),
                  ),
                )),
            new Text(
              "Phòng hiện đang trống, tạo hợp đồng để sử dụng dịch vụ!",
              style: new TextStyle(
                  fontSize: 16.0,
                  color: const Color(0xFF000000),
                  fontWeight: FontWeight.w200,
                  fontFamily: "Roboto"),
            )
          ]),
      padding: const EdgeInsets.all(0.0),
      alignment: Alignment.center,
      width: 1.7976931348623157e+308,
      height: 120.0,
    );
  }

  void buttonPressed() {
    print('press button THEM');
  }
  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
        color: Colors.white,
        shadowColor: Color(0xFFFFFFFF),
        child: InkWell
          (
          // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null ? () => onTap() : () { print('Not set yet'); },
            child: child
        )
    );
  }

  void _updateInfor(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateRoomInfor(widget.roomData)));
  }
  void _viewListContract(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> ListContract(widget.roomData)));
  }
  void _routingListPartner(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> ListPartner(widget.roomData)));
  }
  Future<Null> _refresh() async {
    await Future.delayed(Duration(milliseconds: 2000));
    setState(() {
      initState();
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show(atTop: true));
    });
    return null;
  }
}
