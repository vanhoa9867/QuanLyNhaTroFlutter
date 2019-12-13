import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/model/partner.dart';
import 'package:flutter_app/src/model/room.dart';
import 'package:flutter_app/src/resources/add_partner_page.dart';
import 'package:flutter_app/src/resources/create_house.dart';
import 'package:flutter_app/src/resources/partner_info_page.dart';

class ListPartner extends StatefulWidget {
  RoomData roomData;
  ListPartner(this.roomData, {Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ListPartnerState();
  }
}

class ListPartnerState extends State<ListPartner>{
  List<PartnerData> allData = [];
  @override
  void initState() {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    FirebaseAuth.instance.currentUser().then((user){
      ref.child('partners').child(user.uid).once().then((DataSnapshot snap){
        var keys = snap.value.keys;
        var data = snap.value;
        for(var key in keys){
          if(data[key]['rent'].toString() == widget.roomData.roomId){
            PartnerData d = new PartnerData(
              data[key]['name'],
              data[key]['partnerID'],
              data[key]['phone number'],
              data[key]['email'],
              data[key]['birthday'],
              data[key]['CMND'],
              data[key]['address'],
              data[key]['rent'],
            );
            allData.add(d);
          }
        }
        setState(() {
          print('list partner length: ${allData.length}');
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              color: Colors.black,
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.of(context).pop()),
          title: new Text(
            'Khách thuê',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddPartnerPage(widget.roomData))),
          child: Icon(Icons.add,color: Colors.white),
          backgroundColor: Colors.blue,
        ),
        body: new Container(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: allData.length == 0 ? UIempty():
          new ListView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(horizontal: 14.0),
              itemCount: allData.length,
              itemBuilder: (_,index){
                return UI(
                  allData[index].name,
                  allData[index].partnerID,
                  allData[index].phonenumber,
                  allData[index].email,
                  allData[index].birthday,
                  allData[index].CMND,
                  allData[index].address,
                  allData[index].rent,
                );
              }),
        )
    );
  }

  Widget UI(String name,String partnerID,String phonenumber,String email, String birthday,String CMND,String address,String rent){
    PartnerData newPartner = new PartnerData(name, partnerID, phonenumber, email, birthday,CMND,address,rent);
    /// Item card
    return new Container(
      child: Padding
        (
        padding: EdgeInsets.only(bottom: 16.0),
        child: Align
          (
          alignment: Alignment.topCenter,
          child: SizedBox.fromSize
            (
              size: Size.fromHeight(190.0),
              child: Stack
                (
                fit: StackFit.expand,
                children: <Widget>
                [
                  /// Item description inside a material
                  Container
                    (
                    margin: EdgeInsets.only(top: 24.0),
                    child: Material
                      (
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(12.0),
                      shadowColor: Color(0x802196F3),
                      color: Colors.white,
                      child: InkWell(
                        onTap:  ()=>Navigator.of(context).push(MaterialPageRoute(builder: (_) => PartnerInfo(newPartner))),
                        child: Padding
                          (
                          padding: EdgeInsets.all(24.0),
                          child: Column
                            (
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>
                            [
                              /// Title and rating
                              Column
                                (
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>
                                [
                                  Text('$name', style: TextStyle(color: Colors.blueAccent)),
                                  Row
                                    (
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>
                                    [
                                      Text('$phonenumber', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24.0)),
                                    ],
                                  ),
                                  Text('$birthday', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w200, fontSize: 18.0)),
                                  Text('$email', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w200, fontSize: 18.0)),
                                ],
                              ),
                              /// Infos
                              Row
                                (
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>
                                [
                                  Text('Căn cước số: ', style: TextStyle(fontSize: 18.0)),
                                  Padding
                                    (
                                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                                    child: Text('${CMND.toString()}', style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18.0)),
                                  ),
                                  Padding
                                    (
                                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                                    child: Material
                                      (
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.green,
                                      child: Padding
                                        (
                                        padding: EdgeInsets.all(4.0),
                                        child: Text('Đã đăng ký', style: TextStyle(color: Colors.white)),
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
                  Align
                    (
                    alignment: Alignment.topRight,
                    child: Padding
                      (
                      padding: EdgeInsets.fromLTRB(0,5,10,0),
                      child: SizedBox.fromSize
                        (
                        size: Size.fromRadius(44.0),
                        child: Material
                          (
                          elevation: 4.0,
                          shadowColor: Color(0x802196F3),
                          shape: CircleBorder(),
                          child: Image.asset('assets/ic_profile.png',scale: 9.0,),
                        ),
                      ),
                    ),
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }

  Widget UIempty(){
    return new Container(
        alignment: Alignment.center,
        child: new Stack(
          children: <Widget>[
            Image.asset('assets/ic_house_increase.png',scale: 5.0,),
          ],
        )
    );
  }
}
