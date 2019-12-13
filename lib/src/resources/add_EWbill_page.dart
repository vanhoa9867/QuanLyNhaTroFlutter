import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_app/src/blocs/create_contract_bloc.dart';
import 'package:flutter_app/src/model/room.dart';
import 'package:flutter_app/src/resources/dialog/loading_dialog.dart';
import 'package:flutter_app/src/resources/dialog/msg_dialog.dart';
import 'package:intl/intl.dart';

class AddEWBillPage extends StatefulWidget {
  //RoomData roomData;

  //AddEWBillPage(this.roomData, {Key key}) : super(key: key);

  @override
  _AddEWBillPageState createState() => _AddEWBillPageState();
}

class _AddEWBillPageState extends State<AddEWBillPage> {
  CreateContractBloc bloc = new CreateContractBloc();
  /*TextEditingController _NgayVaoController = new TextEditingController();
  TextEditingController _ThoiHanController = new TextEditingController();
  TextEditingController _GiaPhongController = new TextEditingController();
  TextEditingController _TienCocController = new TextEditingController();
  TextEditingController _ChuKyTraTienController = new TextEditingController();
  TextEditingController _NgayThuTenController = new TextEditingController();
  TextEditingController _TenPartnerController = new TextEditingController();
  TextEditingController _phoneNumberController = new TextEditingController();*/

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("dd-MM-yyyy");
    var now = new DateTime.now();
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: Text('Tạo hóa đơn',
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
                child: Text('THÔNG TIN ĐIỆN NƯỚC', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Container(
                  child: StreamBuilder(
                    //stream: bloc.ngayVaoStream,
                    builder: (context, snapshot) => DateTimeField(
                      format: format,
                      //controller: _NgayVaoController,
                      initialValue: new DateTime.now(),
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2025));
                      },
                      decoration: InputDecoration(
                          labelText: now.toString(),
                          helperText: "Ngày tạo hóa đơn",
                          errorText: snapshot.hasError ? snapshot.error : null,
                          labelStyle:
                          TextStyle(color: Color(0xff888888), fontSize: 12),
                          icon: Icon(Icons.date_range)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: StreamBuilder(
                    //stream: bloc.giaPhongStream,
                    builder: (context, snapshot) => TextField(
                      //controller: _GiaPhongController,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                          helperText:
                          "Chỉ số cũ là: 123W",
                          labelText: "Chỉ số điện (*)",
                          errorText:
                          snapshot.hasError ? snapshot.error : null,
                          labelStyle: TextStyle(
                              color: Color(0xff888888), fontSize: 12)),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: StreamBuilder(
                    //stream: bloc.giaPhongStream,
                    builder: (context, snapshot) => TextField(
                      //controller: _GiaPhongController,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                          helperText:
                          "Chỉ số cũ là: 234 khối",
                          labelText: "Chỉ số nước (*)",
                          errorText:
                          snapshot.hasError ? snapshot.error : null,
                          labelStyle: TextStyle(
                              color: Color(0xff888888), fontSize: 12)),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: StreamBuilder(
                    //stream: bloc.TienCocStream,
                    builder: (context, snapshot) => TextField(
                      //controller: _TienCocController,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                          labelText: "Giá tiền điện",
                          errorText:
                          snapshot.hasError ? snapshot.error : null,
                          labelStyle: TextStyle(
                              color: Color(0xff888888), fontSize: 12)),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: StreamBuilder(
                    //stream: bloc.chuKyTraTienStream,
                    builder: (context, snapshot) => TextField(
                      //controller: _ChuKyTraTienController,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                          labelText: "Giá tiền nước",
                          errorText:
                          snapshot.hasError ? snapshot.error : null,
                          labelStyle: TextStyle(
                              color: Color(0xff888888), fontSize: 12)),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: RaisedButton(
                    onPressed: onCreateBillClick,
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

  void onCreateBillClick() {
    return null;
  }
    /*bloc.createContract(
        _NgayVaoController.text,
        _ThoiHanController.text,
        _GiaPhongController.text,
        _TienCocController.text,
        _ChuKyTraTienController.text,
        _NgayThuTenController.text,
        widget.roomData.roomId,
        _TenPartnerController.text,
        _phoneNumberController.text, () {
      LoadingDialog.hideLoadingDialog(context);
      Navigator.of(context).pop();
    }, (msg) {
      LoadingDialog.hideLoadingDialog(context);
      MsgDialog.showMsgDialog(context, "Create contract fail", msg);
    });
  }*/
}
