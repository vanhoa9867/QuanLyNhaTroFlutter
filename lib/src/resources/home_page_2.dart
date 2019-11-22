import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_app/src/resources/horizontal_list_page.dart';

class HomePage2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePage2State();
  }
}

class HomePage2State extends State<HomePage2> {
  final carousel = Carousel(
    boxFit: BoxFit.cover,
    images: [
      AssetImage('assets/aaa.png'),
      AssetImage('assets/smart_house.png'),
      AssetImage('assets/touch_cell.png'),
    ],
    dotSize: 4.0,
    indicatorBgPadding: 3.0,
    animationCurve: Curves.fastOutSlowIn,
    animationDuration: Duration(milliseconds: 2000),
  );

  @override
  Widget build(BuildContext context) {
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
                      height: 340.0,
                      child: Container(
                        margin: EdgeInsets.only(top: 180, bottom: 10),
                        padding: EdgeInsets.only(top: 10, bottom: 10),
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
                                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  child: Container(
                                    child: TextField(
                                      style: TextStyle(fontSize: 18, color: Colors.black),
                                      decoration: InputDecoration(
                                        labelText: 'Search',
                                        labelStyle: TextStyle(color: Color(0xff888888),fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              HorizontalList(),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 15,
                                  spreadRadius: 5,
                                  color: Color.fromRGBO(0, 0, 0, .3))
                            ]),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15.0,top: 360.0),
                    child: Text('Room emtpy',style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 380, 15, 0),
                    child: Text('aaaa'),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
