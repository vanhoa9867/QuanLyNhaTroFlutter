import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/src/blocs/create_house_bloc.dart';
import 'package:flutter_app/src/resources/home_page.dart';

import 'dialog/loading_dialog.dart';
import 'dialog/msg_dialog.dart';

class CreateHouse extends StatefulWidget {
  @override
  _CreateHouseState createState() => _CreateHouseState();
}

class _CreateHouseState extends State<CreateHouse> {
  CreateHouseBloc authBloc = new CreateHouseBloc();
  TextEditingController _nameHouseController = new TextEditingController();
  TextEditingController _addressHouseController = new TextEditingController();
  TextEditingController _numberHouseController = new TextEditingController();
  TextEditingController _noteHouseController = new TextEditingController();

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
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 1,
        title: new Text('Tạo mới nhà trọ',style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
        centerTitle: true,
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
                      controller: _nameHouseController,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Tên nhà trọ',
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
                      controller: _addressHouseController,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                          labelText: 'Địa chỉ',
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
                    return TextField(
                      controller: _numberHouseController,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                          labelText: 'Số lượng phòng',
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
                  stream: authBloc.noteHouseStream,
                  builder: (context, snapshot) {
                    return TextField(
                      controller: _noteHouseController,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                          labelText: 'Miêu tả',
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
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: RaisedButton(
                    onPressed: _onCreateHouseClicked,
                    child: Text(
                      "HOÀN THÀNH",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    color: Colors.blue,
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
  _onCreateHouseClicked() {
    var isValidHouse = authBloc.isValid(_nameHouseController.text,_addressHouseController.text,_numberHouseController.text,_noteHouseController.text);
    LoadingDialog.showLoadingDialog(context, 'Loading...');
    authBloc.createHouse(_nameHouseController.text, _addressHouseController.text,_numberHouseController.text,_noteHouseController.text, (){
      LoadingDialog.hideLoadingDialog(context);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
    },(msg){
      LoadingDialog.hideLoadingDialog(context);
      MsgDialog.showMsgDialog(context, "Create house", msg);
    });
  }
}
