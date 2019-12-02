import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/model/house.dart';
import 'package:flutter_app/src/resources/create_house.dart';
import 'package:flutter_app/src/resources/list_room_page.dart';

class ListHouse extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ListHouseState();
  }
}

class ListHouseState extends State<ListHouse>{
  List<HouseData> allData = [];
  @override
  void initState() {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    FirebaseAuth.instance.currentUser().then((user){
      ref.child('houses').child(user.uid).once().then((DataSnapshot snap){
        var keys = snap.value.keys;
        var data = snap.value;
        for(var key in keys){
          HouseData d = new HouseData(
            data[key]['address'],
            data[key]['name'],
            data[key]['number'],
            data[key]['note'],
            data[key]['houseID']
          );
          allData.add(d);
        }
        setState(() {
          print('length: ${allData.length}');
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CreateHouse())),
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
        body: new Container(
          padding: EdgeInsets.fromLTRB(5, 30, 5, 0),
          child: allData.length == 0 ? new Text('No data Available'):
          new ListView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(horizontal: 14.0),
              itemCount: allData.length,
              itemBuilder: (_,index){
                return UI(
                  allData[index].name,
                  allData[index].address,
                  allData[index].number,
                  allData[index].note,
                  allData[index].houseID,
                );
              }),
        )
    );
  }

  Widget UI(String addressHouse,String nameHouse,String numberHouse,String floorHouse, String houseId){
    HouseData newHouse = new HouseData(nameHouse, addressHouse, numberHouse, floorHouse, houseId);
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
              size: Size.fromHeight(172.0),
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
                      elevation: 14.0,
                      borderRadius: BorderRadius.circular(12.0),
                      shadowColor: Color(0x802196F3),
                      color: Colors.white,
                      child: InkWell(
                        onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (_) => ListRoom(newHouse))),
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
                                  Text('$nameHouse', style: TextStyle(color: Colors.blueAccent)),
                                  Row
                                    (
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>
                                    [
                                      Text('$addressHouse', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24.0)),
                                    ],
                                  ),
                                ],
                              ),
                              /// Infos
                              Row
                                (
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>
                                [
                                  Text('Số phòng: ', style: TextStyle()),
                                  Padding
                                    (
                                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                                    child: Text('${numberHouse.toString()}', style: TextStyle(fontWeight: FontWeight.w700)),
                                  ),
                                  Text('Ghi chú: ${floorHouse.toString()}', style: TextStyle()),
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
                                        child: Text('Tốt', style: TextStyle(color: Colors.white)),
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
                      padding: EdgeInsets.only(right: 16.0),
                      child: SizedBox.fromSize
                        (
                        size: Size.fromRadius(50.0),
                        child: Material
                          (
                          elevation: 16.0,
                          shadowColor: Color(0x802196F3),
                          shape: CircleBorder(),
                          child:
                          Image.asset('assets/ic_house_thump.png'),
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
}
