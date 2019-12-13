import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/src/resources/horizontal_list_page.dart';
import 'package:flutter_app/src/resources/horizontal_list_partner_page.dart';
import 'package:flutter_app/src/resources/horizontal_list_room_page.dart';

class HomePage2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePage2State();
  }
}

class HomePage2State extends State<HomePage2> {
  bool isExpanded = false;
  double _height;
  double _width;

  void _expand() {
    setState(() {
      isExpanded ? isExpanded = false : isExpanded = true;
    });
  }

  final carousel = Carousel(
    boxFit: BoxFit.cover,
    images: [
      AssetImage('assets/ic_slide_1.png'),
      AssetImage('assets/ic_slide_2.png'),
      AssetImage('assets/touch_cell.png'),
    ],
    dotSize: 4.0,
    indicatorBgPadding: 3.0,
    animationCurve: Curves.fastLinearToSlowEaseIn,
    animationDuration: Duration(milliseconds: 4000),
  );

  @override
  Widget build(BuildContext context) {
   /* SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ));*/
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      body: new ListView(
        children: <Widget>[
          Container(
            child: Center(
              child: Stack(
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.all(0.0),
                    height: screenHeight / 3,
                    child: carousel,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 360.0,
                      child: Container(
                        margin: EdgeInsets.only(top: 180, bottom: 5),
                        padding: EdgeInsets.only(top: 10, bottom: 0),
                        width: MediaQuery.of(context).size.width * 0.92,
                        child: Container(
                          alignment: AlignmentDirectional.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 40.0,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                    child: TextField(
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                      decoration: InputDecoration(
                                        labelText: 'Tìm kiếm',
                                        labelStyle: TextStyle(
                                            color: Color(0xff888888),
                                            fontSize: 20),
                                        prefixIcon: Icon(Icons.search),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: HorizontalList(),
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                  color: Color.fromRGBO(0, 0, 0, .3))
                            ]),
                      ),
                    ),
                  ),
                  //////
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15.0, top: 20.0),
            child: Stack(
              children: <Widget>[
                Text(
                  'Phòng đã thuê',
                  style: TextStyle(
                      fontSize: 22.0, fontWeight: FontWeight.bold),
                ),
                Container(
                  alignment: AlignmentDirectional.centerEnd,
                  padding: EdgeInsets.fromLTRB(0, 5, 15, 0),
                  child: Text(
                    'Xem chi tiết',
                    style: TextStyle(
                      color: Colors.blue,
                        fontSize: 16.0, fontWeight: FontWeight.bold),),
                )
              ],
            ),
          ),
          Container(
            width: _width,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              children: <Widget>[
                HorizontalListRoom(),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15.0, top: 20.0),
            child: Stack(
              children: <Widget>[
                Text(
                  'Khách thuê',
                  style: TextStyle(
                      fontSize: 22.0, fontWeight: FontWeight.bold),
                ),
                Container(
                  alignment: AlignmentDirectional.centerEnd,
                  padding: EdgeInsets.fromLTRB(0, 5, 15, 0),
                  child: Text(
                    'Xem chi tiết',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16.0, fontWeight: FontWeight.bold),),
                )
              ],
            ),
          ),
          Container(
            width: _width,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              children: <Widget>[
                HorizontalListPartner(),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
