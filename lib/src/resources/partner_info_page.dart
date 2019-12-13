import 'package:flutter/material.dart';
import 'package:flutter_app/src/model/partner.dart';
import 'package:flutter_app/src/resources/call_message_page.dart';
import 'package:flutter_app/src/resources/dialog/alert_delete_dialog.dart';
import 'package:flutter_app/src/resources/service_locator.dart';

class PartnerInfo extends StatefulWidget {
  PartnerData partnerData;

  PartnerInfo(this.partnerData, {Key key}) : super(key: key);

  @override
  _PartnerInfoState createState() => _PartnerInfoState();
}

class _PartnerInfoState extends State<PartnerInfo> {
  /*final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();*/
  var _height, _width;
  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();

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
          'Thông tin khách thuê',
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
              print('do delete partner method');
              AlertDeleteDialog.showMsgDialog(context, 'XÓA BỎ',
                  'Bạn có chắc muốn xóa bỏ khách này khỏi phòng này!');
            },
          ),
        ],
      ),
      body: new Container(
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Icon(Icons.insert_emoticon,
                                  color: const Color(0xFF000000), size: 48.0),
                              new Text(
                                "${widget.partnerData.name}",
                                style: new TextStyle(
                                    fontSize: 24.0,
                                    color: const Color(0xFF000000),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Roboto"),
                              )
                            ]),
                        alignment: Alignment.center,
                        width: _width / 2,
                        height: _height / 5,
                      ),
                      new Container(
                        child: new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                child: new Container(
                                  child: new Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        new Icon(Icons.call,
                                            color: const Color(0xFFFFFFFF),
                                            size: 24.0),
                                        new Text(
                                          "Gọi điện",
                                          style: new TextStyle(
                                              fontSize: 18.0,
                                              color: const Color(0xFFFFFFFF),
                                              fontFamily: "Roboto"),
                                        )
                                      ]),
                                  color: const Color(0xFF64dd17),
                                  padding: const EdgeInsets.all(0.0),
                                  alignment: Alignment.center,
                                  width: _width / 2,
                                  height: _height / 12,
                                ),
                                onTap:() => _service.call(widget.partnerData.phonenumber),
                              ),
                              _buildTile(
                                new Container(
                                  child: new Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        new Icon(Icons.chat,
                                            color: const Color(0xFFFFFFFF),
                                            size: 24.0),
                                        new Text(
                                          "Nhắn tin",
                                          style: new TextStyle(
                                              fontSize: 18.0,
                                              color: const Color(0xFFFFFFFF),
                                              fontFamily: "Roboto"),
                                        )
                                      ]),
                                  color: const Color(0xFFf57c00),
                                  padding: const EdgeInsets.all(0.0),
                                  alignment: Alignment.center,
                                  width: _width / 2,
                                  height: _height / 12,
                                ),
                                onTap: () => _service.sendSms(widget.partnerData.phonenumber),
                              ),
                            ]),
                        padding: const EdgeInsets.all(0.0),
                        alignment: Alignment.center,
                        width: _width,
                        height: _height / 12,
                      )
                    ]),
                padding: const EdgeInsets.all(0.0),
                alignment: Alignment.center,
                width: _width,
                height: _height / 3,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: new Container(
                  child: new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        new Text(
                          "Số điên thoại:",
                          style: new TextStyle(
                              fontSize: 18.0,
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.w200,
                              fontFamily: "Roboto"),
                        ),
                        new Text(
                          "${widget.partnerData.phonenumber}",
                          style: new TextStyle(
                              fontSize: 20.0,
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto"),
                        ),
                        new Text(
                          "Email:",
                          style: new TextStyle(
                              fontSize: 18.0,
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.w200,
                              fontFamily: "Roboto"),
                        ),
                        new Text(
                          "${widget.partnerData.email}",
                          style: new TextStyle(
                              fontSize: 20.0,
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto"),
                        ),
                        new Text(
                          "Ngày sinh:",
                          style: new TextStyle(
                              fontSize: 18.0,
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.w200,
                              fontFamily: "Roboto"),
                        ),
                        new Text(
                          "${widget.partnerData.birthday}",
                          style: new TextStyle(
                              fontSize: 20.0,
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto"),
                        ),
                        new Text(
                          "Nguyên quán:",
                          style: new TextStyle(
                              fontSize: 18.0,
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.w200,
                              fontFamily: "Roboto"),
                        ),
                        new Text(
                          "${widget.partnerData.address}",
                          style: new TextStyle(
                              fontSize: 20.0,
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto"),
                        ),
                        new Text(
                          "Căn cước:",
                          style: new TextStyle(
                              fontSize: 18.0,
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.w200,
                              fontFamily: "Roboto"),
                        ),
                        new Text(
                          "${widget.partnerData.CMND}",
                          style: new TextStyle(
                              fontSize: 20.0,
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto"),
                        )
                      ]),
                  padding: const EdgeInsets.all(0.0),
                  alignment: Alignment.center,
                  width: _width,
                  height: _height / 2,
                ),
              )
            ]),
        padding: const EdgeInsets.all(0.0),
        alignment: Alignment.center,
      ),
    );
  }

  void buttonPressed() {
    print('press button THEM');
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
        color: Colors.white,
        shadowColor: Color(0xFFFFFFFF),
        child: InkWell(
          // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null
                ? () => onTap()
                : () {
              print('Not set yet');
            },
            child: child));
  }
}
