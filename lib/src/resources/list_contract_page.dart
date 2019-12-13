import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/model/contract.dart';
import 'package:flutter_app/src/model/house.dart';
import 'package:flutter_app/src/model/partner.dart';
import 'package:flutter_app/src/model/room.dart';
import 'package:flutter_app/src/resources/dialog/alert_delete_dialog.dart';
import 'package:flutter_app/src/resources/roomInfo.dart';

class ListContract extends StatefulWidget {
  
  RoomData roomData;
  ListContract(this.roomData, {Key key}) : super(key: key);

  @override
  _ListContractState createState() => _ListContractState();
}

class _ListContractState extends State<ListContract> {
  List<ContractData> allData = [];

  @override
  void initState() {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    FirebaseAuth.instance.currentUser().then((user) {
      ref.child('contracts').child(user.uid).child(widget.roomData.roomId).once().then((DataSnapshot snap) {
        var keys = snap.value.keys;
        var data = snap.value;
        for (var key in keys) {
          ContractData d = new ContractData(
            data[key]['ngaykhachvao'],
            data[key]['thoihan'],
            data[key]['giaphong'],
            data[key]['tiencoc'],
            data[key]['chuky'],
            data[key]['ngaythu'],
            data[key]['khachID'],
            data[key]['contractID'],
            data[key]['status'],
          );
          allData.add(d);
        }
        setState(() {
          print('list contract length: ${allData.length}');
        });
      });
    });
    super.initState();
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
            title: Text('Lịch sử hợp đồng', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            centerTitle: true,
            elevation: 1.0,
          ),
          body: new Container(
            padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
            child: allData.length == 0
                ? new Text('No data Available')
                : new ListView.builder(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(horizontal: 14.0),
                itemCount: allData.length,
                itemBuilder: (_, index) {
                  return UI(
                    allData[index].ChuKyTraTien,
                    allData[index].contractID,
                    allData[index].GiaPhong,
                    allData[index].khachID,
                    allData[index].NgayVao,
                    allData[index].NgayThuTien,
                    allData[index].ThoiHan,
                    allData[index].TienCoc,
                    allData[index].status,
                  );
                }),
          ),
        ),
      ),
    );
  }

  Widget UI(String chuky, String contractID, String giaphong, String khachID,
      String ngayvao, String ngaythutien,String thoihan,String tiencoc,String status) {
    ContractData newContract = new ContractData(chuky,contractID, giaphong, khachID, ngayvao, ngaythutien,thoihan,tiencoc,status);
    /// Item card
    return new Container(
      child: Padding(
        padding: EdgeInsets.only(bottom: 16.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: SizedBox.fromSize(
              size: Size.fromHeight(150.0),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  /// Item description inside a material
                  Container(
                    margin: EdgeInsets.only(top: 2.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(12.0),
                      shadowColor: Color(0x802196F3),
                      color: Colors.white,
                      child: InkWell(
                        onTap: null /*() => Navigator.of(context).push(MaterialPageRoute(builder: (_) => RoomInfo(newRoom)))*/,
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
                                  Padding(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                    child: Container(
                                      child: Material(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                        color: Colors.green,
                                        child: Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Text('$status',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text('Ngày tạo: ${ngayvao}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 24.0)),
                                    ],
                                  ),
                                  Text('Tiền thuê: ${giaphong}/1 tháng'),
                                ],
                              ),

                              /// Infos
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text('Thời hạn: ', style: TextStyle()),
                                    Padding(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Text('${thoihan.toString()}',
                                          style: TextStyle(
                                            color: Colors.blue,
                                              fontWeight: FontWeight.w700)),
                                    ),
                                  ],
                                ),
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
