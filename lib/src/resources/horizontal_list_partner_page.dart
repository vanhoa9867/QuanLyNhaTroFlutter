import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/model/partner.dart';
import 'package:flutter_app/src/model/room.dart';
import 'package:flutter_app/src/resources/widget/partner_card_page.dart';
import 'package:flutter_app/src/resources/widget/room_card_page.dart';

class HorizontalListPartner extends StatefulWidget {
  @override
  _HorizontalListPartnerState createState() => _HorizontalListPartnerState();
}

class _HorizontalListPartnerState extends State<HorizontalListPartner> {
  double _height;
  double _width;
  List<PartnerData> trendingListPartner =[];

  @override
  void initState() {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    FirebaseAuth.instance.currentUser().then((user) {
      ref.child('partners').child(user.uid).once().then((DataSnapshot snap) {
        var keys = snap.value.keys;
        var data = snap.value;
        for (var key in keys) {
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
          trendingListPartner.add(d);
        }
        setState(() {
          print('list ListPartner count: ${trendingListPartner.length}');
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    return Container(
      child: trendingProducts(),
    );
  }

  Widget trendingProducts() {
    return Container(
      height: _height / 4.25,
      //width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        padding: EdgeInsets.all(5),
        shrinkWrap: true,
        itemCount: trendingListPartner.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, index) {
          return _buildTrendingEntries(context, index, trendingListPartner);
        },
      ),
    );
  }

  Widget _buildTrendingEntries(BuildContext context, int index, List<PartnerData> listItem) {
    return GestureDetector(
      onTap: () {
        print("Routing to trending list page");
      },
      child: PartnerCard(
        '${listItem[index].name}',
        '${listItem[index].partnerID}',
        '${listItem[index].phonenumber}',
        '${listItem[index].email}',
        '${listItem[index].birthday}',
        '${listItem[index].CMND}',
        '${listItem[index].address}',
        '${listItem[index].rent}',
      ),
    );
  }
}