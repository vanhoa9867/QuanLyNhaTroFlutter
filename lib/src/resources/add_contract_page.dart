import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_app/src/blocs/create_contract_bloc.dart';
import 'package:flutter_app/src/model/room.dart';
import 'package:flutter_app/src/resources/dialog/loading_dialog.dart';
import 'package:flutter_app/src/resources/dialog/msg_dialog.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class AddContractPage extends StatefulWidget {
  RoomData roomData;
  AddContractPage(this.roomData, {Key key}) : super(key: key);

  @override
  _AddContractPageState createState() => _AddContractPageState();
}

class _AddContractPageState extends State<AddContractPage> {
  final format = DateFormat("dd-MM-yyyy");

  CreateContractBloc bloc = new CreateContractBloc();
  TextEditingController _NgayVaoController = new TextEditingController();
  TextEditingController _ThoiHanController = new TextEditingController();
  TextEditingController _GiaPhongController = new TextEditingController();
  TextEditingController _TienCocController = new TextEditingController();
  TextEditingController _ChuKyTraTienController = new TextEditingController();
  TextEditingController _NgayThuTenController = new TextEditingController();
  TextEditingController _TenPartnerController = new TextEditingController();
  TextEditingController _phoneNumberController = new TextEditingController();
  TextEditingController _emailPartnerController = new TextEditingController();
  TextEditingController _CMNDpartnerController = new TextEditingController();
  TextEditingController _birthdayPartnerController = new TextEditingController();
  TextEditingController _addressPartnerController = new TextEditingController();

  get refreshRoomData => null;

  @override
  void initState() {
    _NgayVaoController.text = format.format(DateTime.now()).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var now = new DateTime.now();
    var nowformated = format.format(now);
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Colors.black,
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: Text('Tạo hợp đồng',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                alignment: Alignment.center,
                child: Text(
                  'THÔNG TIN HỢP ĐỒNG',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: StreamBuilder(
                    //stream: bloc.NameHouseStream ,
                    builder: (context, snapshot) => TextField(
                          //controller: _nameHouseController,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "Mã tham chiếu(Nhập mã nếu có)",
                            errorText:
                                snapshot.hasError ? snapshot.error : null,
                            labelStyle: TextStyle(
                                color: Color(0xff888888), fontSize: 14),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffCED0D2), width: 1),),
                          ),
                        )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Container(
                  child: StreamBuilder(
                    stream: bloc.ngayVaoStream,
                    builder: (context, snapshot) => DateTimeField(
                      format: format,
                      controller: _NgayVaoController,
                      initialValue: new DateTime.now(),
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2025));
                      },
                      decoration: InputDecoration(
                          labelText: "Ngày tạo hợp đồng",hintStyle: TextStyle(color: Color(0xff888888), fontSize: 14) ,
                          errorText: snapshot.hasError ? snapshot.error : null,
                          labelStyle:
                              TextStyle(color: Color(0xff888888), fontSize: 12),
                          icon: Icon(Icons.date_range),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xffCED0D2), width: 1),),),

                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Container(
                  child: StreamBuilder(
                    stream: bloc.thoiHanStream,
                    builder: (context, snapshot) => DateTimeField(
                      format: format,
                      controller: _ThoiHanController,
                      initialValue: new DateTime.now(),
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2025));
                      },
                      decoration: InputDecoration(
                          labelText: "Thời hạn hợp đồng",hintStyle: TextStyle(color: Color(0xff888888), fontSize: 14) ,
                          errorText: snapshot.hasError ? snapshot.error : null,
                          labelStyle:
                              TextStyle(color: Color(0xff888888), fontSize: 12),
                          icon: Icon(Icons.date_range),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xffCED0D2), width: 1),)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: StreamBuilder(
                    stream: bloc.giaPhongStream,
                    builder: (context, snapshot) => TextField(
                          controller: _GiaPhongController,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                              helperText:
                                  "Giá phòng hiện tại: ${widget.roomData.price} đ",
                              labelText: "Tiền phòng (*)",
                              errorText:
                                  snapshot.hasError ? snapshot.error : null,
                              labelStyle: TextStyle(
                                  color: Color(0xff888888), fontSize: 12),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffCED0D2), width: 1),)),
                        )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: StreamBuilder(
                    stream: bloc.TienCocStream,
                    builder: (context, snapshot) => TextField(
                          controller: _TienCocController,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                              labelText: "Tiền cọc",
                              errorText:
                                  snapshot.hasError ? snapshot.error : null,
                              labelStyle: TextStyle(
                                  color: Color(0xff888888), fontSize: 12),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffCED0D2), width: 1),)),
                        )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: StreamBuilder(
                    stream: bloc.chuKyTraTienStream,
                    builder: (context, snapshot) => TextField(
                          controller: _ChuKyTraTienController,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                              labelText: "Chu kỳ trả tiền phòng",
                              errorText:
                                  snapshot.hasError ? snapshot.error : null,
                              labelStyle: TextStyle(
                                  color: Color(0xff888888), fontSize: 12),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffCED0D2), width: 1),)),
                        )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: StreamBuilder(
                    stream: bloc.ngayThuTienStream,
                    builder: (context, snapshot) => TextField(
                          controller: _NgayThuTenController,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                              labelText: "Ngày thu tiền",
                              errorText:
                                  snapshot.hasError ? snapshot.error : null,
                              labelStyle: TextStyle(
                                  color: Color(0xff888888), fontSize: 12),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffCED0D2), width: 1),)),
                        )),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 25),
                alignment: Alignment.center,
                child: Text(
                  'THÔNG TIN KHÁCH HÀNG',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: StreamBuilder(
                    stream: bloc.tenPartnerStream,
                    builder: (context, snapshot) => TextField(
                          controller: _TenPartnerController,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                              labelText: "Tên khách thuê (*)",
                              errorText:
                                  snapshot.hasError ? snapshot.error : null,
                              labelStyle: TextStyle(
                                  color: Color(0xff888888), fontSize: 12),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffCED0D2), width: 1),)),
                        )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: StreamBuilder(
                    stream: bloc.phoneNumberStream,
                    builder: (context, snapshot) => TextField(
                          controller: _phoneNumberController,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                              labelText: "Số điện thoại (*)",
                              errorText:
                                  snapshot.hasError ? snapshot.error : null,
                              labelStyle: TextStyle(
                                  color: Color(0xff888888), fontSize: 12),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffCED0D2), width: 1),)),
                        )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: StreamBuilder(
                    stream: bloc.emailPartnerStream,
                    builder: (context, snapshot) => TextField(
                          controller: _emailPartnerController,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                              labelText: "Email",
                              errorText:
                                  snapshot.hasError ? snapshot.error : null,
                              labelStyle: TextStyle(
                                  color: Color(0xff888888), fontSize: 12),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffCED0D2), width: 1),)),
                        )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: StreamBuilder(
                    stream: bloc.birthDayPartnerStream,
                    builder: (context, snapshot) => TextField(
                          controller: _birthdayPartnerController,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                              labelText: "Ngày sinh (*)",
                              errorText:
                                  snapshot.hasError ? snapshot.error : null,
                              labelStyle: TextStyle(
                                  color: Color(0xff888888), fontSize: 12),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffCED0D2), width: 1),)),
                        )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: StreamBuilder(
                    stream: bloc.CMNDpartnerStream,
                    builder: (context, snapshot) => TextField(
                          controller: _CMNDpartnerController,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                              labelText: "Số căn cước (*)",
                              errorText:
                                  snapshot.hasError ? snapshot.error : null,
                              labelStyle: TextStyle(
                                  color: Color(0xff888888), fontSize: 12),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffCED0D2), width: 1),)),
                        )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: StreamBuilder(
                    stream: bloc.addressPartnerStream,
                    builder: (context, snapshot) => TextField(
                          controller: _addressPartnerController,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                              labelText: "Nguyên quán (*)",
                              errorText:
                                  snapshot.hasError ? snapshot.error : null,
                              labelStyle: TextStyle(
                                  color: Color(0xff888888), fontSize: 12),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffCED0D2), width: 1),)),
                        )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: RaisedButton(
                    onPressed: onCreateContractClick,
                    child: Text(
                      "HOÀN THÀNH",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onCreateContractClick() {
    /*var isValid = bloc.isValid(_NgayVaoController.text, _ThoiHanController.text,_GiaPhongController.text,_TienCocController.text,_ChuKyTraTienController.text,_NgayThuTenController.text);
    if(isValid){
      //LoadingDialog.showLoadingDialog(context, "Loading...");
      bloc.createContract(_NgayVaoController.text, _ThoiHanController.text,_GiaPhongController.text,_TienCocController.text,_ChuKyTraTienController.text,_NgayThuTenController.text,widget.roomData.roomId, (){
        LoadingDialog.hideLoadingDialog(context);
        Navigator.of(context).pop();
      },(msg){
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, "Create contract fail", msg);
      });
    }*/
    LoadingDialog.showLoadingDialog(context, "Loading...");
    bloc.createContract(
        _NgayVaoController.text,
        _ThoiHanController.text,
        _GiaPhongController.text,
        _TienCocController.text,
        _ChuKyTraTienController.text,
        _NgayThuTenController.text,
        widget.roomData.roomId,
        _TenPartnerController.text,
        _phoneNumberController.text,
        _emailPartnerController.text,
        _birthdayPartnerController.text,
        _CMNDpartnerController.text,
        _addressPartnerController.text, () {
      LoadingDialog.hideLoadingDialog(context);
      MsgDialog.showMsgDialog(context, "Create contract", 'Tạo thành công');
    }, (msg) {
      LoadingDialog.hideLoadingDialog(context);
      MsgDialog.showMsgDialog(context, "Create contract", msg);
    });
  }
}

