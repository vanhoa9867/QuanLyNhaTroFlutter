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
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Create House', style: TextStyle(color: Colors.black),),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
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
                        labelText: 'Name house',
                        labelStyle: TextStyle(color: Color(0xff888888),fontSize: 20),
                          errorText: snapshot.hasError ? snapshot.error : null
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
                          labelText: 'Address',
                          labelStyle: TextStyle(color: Color(0xff888888),fontSize: 20),
                          errorText: snapshot.hasError ? snapshot.error : null,
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
                          labelStyle: TextStyle(color: Color(0xff888888),fontSize: 20),
                          errorText: snapshot.hasError ? snapshot.error : null,
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
                          labelText: 'Note',
                          labelStyle: TextStyle(color: Color(0xff888888),fontSize: 20),
                          errorText: snapshot.hasError ? snapshot.error : null,
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
                      "CREATE",
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
