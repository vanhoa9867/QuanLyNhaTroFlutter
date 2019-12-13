import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/blocs/create_house_bloc.dart';
import 'package:flutter_app/src/model/room.dart';
import 'dialog/msg_dialog.dart';

class UpdateRoomInfor extends StatefulWidget {
  RoomData roomData;
  UpdateRoomInfor(this.roomData, {Key key}) : super(key: key);
  @override
  _UpdateRoomInforState createState() => _UpdateRoomInforState();
}

class _UpdateRoomInforState extends State<UpdateRoomInfor> {
  bool _enabled = false;

  CreateHouseBloc authBloc = new CreateHouseBloc();
  TextEditingController _nameRoomController = new TextEditingController();
  TextEditingController _priceRoomController = new TextEditingController();
  TextEditingController _statusRoomController = new TextEditingController();

  @override
  void initState() {
    _nameRoomController.text = widget.roomData.name;
    _statusRoomController.text = widget.roomData.status;
    _priceRoomController.text = widget.roomData.price;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: new Text('Cập nhật phòng',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0 , 15, 0, 15),
                child: StreamBuilder(
                    stream: authBloc.nameHouseStream,
                    builder: (context, snapshot) {
                      return TextField(
                        controller: _nameRoomController,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        decoration: InputDecoration(
                            labelText: 'Tên phòng',
                            labelStyle: TextStyle(color: Color(0xff888888),fontSize: 18),
                            errorText: snapshot.hasError ? snapshot.error : null,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffCED0D2), width: 1),)
                        ),
                      );
                    }
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0 , 15, 0, 15),
                child: StreamBuilder(
                    stream: authBloc.addressHouseStream,
                    builder: (context, snapshot) {
                      return TextField(
                        controller: _priceRoomController,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Giá phòng (VNĐ)',
                          labelStyle: TextStyle(color: Color(0xff888888),fontSize: 18),
                          errorText: snapshot.hasError ? snapshot.error : null,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffCED0D2), width: 1),)
                        ),
                      );
                    }
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0 , 15, 0, 15),
                child: StreamBuilder(
                    stream: authBloc.numberHouseStream,
                    builder: (context, snapshot) {
                      return _enabled ?  TextField(
                        controller: _statusRoomController,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Trạng thái',
                          labelStyle: TextStyle(color: Color(0xff888888),fontSize: 18),
                          errorText: snapshot.hasError ? snapshot.error : null,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffCED0D2), width: 1),)
                        ),
                      ) : new FocusScope(
                          node: new FocusScopeNode(),
                          child: new TextFormField(
                            enabled: false,
                            controller: _statusRoomController,
                            decoration: new InputDecoration(
                              labelText: 'Trạng thái',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffCED0D2), width: 1),)
                            ),
                          ),
                      );
                    }
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: RaisedButton(
                    onPressed: _onUpdateRoomClicked,
                    child: Text(
                      "LƯU",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    color: Colors.greenAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  _onUpdateRoomClicked() {
    authBloc.updateRoom(_nameRoomController.text, _priceRoomController.text, widget.roomData.roomId , (){});
    print('update successfully');
    MsgDialog.showMsgDialog(context, 'Cập nhật phòng', 'Cập nhật thành công!');
  }
}
