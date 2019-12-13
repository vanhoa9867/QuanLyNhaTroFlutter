import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  double _height;
  double _width;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      height: 90.0,
      child: ListView(
        // This next line does the trick.
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            child: GestureDetector(
              onTap: (){
                print('Do action Tạo hợp đồng');
              },
              child: Container(
                width: 160.0,
                child: Column(
                   children: <Widget>[
                     Image.asset(
                       'assets/ic_house_writing.png',scale: 9.0,
                     ),
                     Padding(
                       padding: const EdgeInsets.only(top: 10.0),
                       child: Text("Tạo hợp đồng",style: TextStyle(fontSize: 13),),
                     )
                   ],
                ),
              ),
            ),
            width: 90.0,
          ),
          Container(
            child: GestureDetector(
              onTap: (){
                print('Do action Hóa đơn');
              },
              child: Container(
                width: 160.0,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/ic_house_notebook.png',scale: 9.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text("Hóa đơn",style: TextStyle(fontSize: 13),),
                    )
                  ],
                ),
              ),
            ),
            width: 90.0,
          ),
          Container(
            child: GestureDetector(
              onTap: (){
                print('Do action Chốt điện nước');
              },
              child: Container(
                width: 160.0,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/ic_house_calculation.png',scale: 9.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text("Chốt điện nước",style: TextStyle(fontSize: 13),),
                    )
                  ],
                ),
              ),
            ),
            width: 90.0,
          ),
          Container(
            child: GestureDetector(
              onTap: (){
                print('Do action Cọc giữ chỗ');
              },
              child: Container(
                width: 160.0,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/ic_house_cash.png',scale: 9.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text("Cọc giữ chỗ",style: TextStyle(fontSize: 13),),
                    )
                  ],
                ),
              ),
            ),
            width: 90.0,
          ),
          Container(
            child: GestureDetector(
              onTap: (){
                print('Do action Dịch vụ');
              },
              child: Container(
                width: 160.0,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/ic_house_rocket.png',scale: 9.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text("Dịch vụ",style: TextStyle(fontSize: 13),),
                    )
                  ],
                ),
              ),
            ),
            width: 90.0,
          ),
          Container(
            child: GestureDetector(
              onTap: (){
                print('Do action Thống kê');
              },
              child: Container(
                width: 160.0,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/ic_house_presentation.png',scale: 9.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text("Thống kê",style: TextStyle(fontSize: 13),),
                    )
                  ],
                ),
              ),
            ),
            width: 90.0,
          ),
        ],
      ),
    );
  }
}
