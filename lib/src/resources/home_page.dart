import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/src/resources/contact_page.dart';
import 'package:flutter_app/src/resources/create_house.dart';
import 'package:flutter_app/src/resources/home_page_2.dart';
import 'package:flutter_app/src/resources/list_house_page.dart';
import 'package:flutter_app/src/resources/user_info_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  DateTime currentBackPressTime;
  int selectedBar =0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: WillPopScope (child: _getBody(selectedBar), onWillPop: onWillPop),
        bottomNavigationBar: BottomNavyBar(
            onBarTap: (index){
              setState(() {
                selectedBar = index;
              });
            }
        ),
    );
  }
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Press back again to leave');
      return Future.value(false);
    }
    exit(0);
    return Future.value(true);
  }
}

class BottomNavyBar extends StatefulWidget {
  final Function onBarTap;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BottomNavyBarState();
  }

  BottomNavyBar({
    this.onBarTap});
}

class BottomNavyBarState extends State<BottomNavyBar> {
  int _selectedIndex = 0;
  Color backgroundColor = Colors.white;

  List<NavigationItem> items = [
    NavigationItem(Icon(Icons.home), Text('Home'), Colors.blue),
    NavigationItem(Icon(Icons.account_balance), Text('List House'), Colors.blue),
    NavigationItem(Icon(Icons.contacts), Text('Contacts'), Colors.blue),
    NavigationItem(Icon(Icons.account_circle), Text('Information'), Colors.blue),
  ];

  Widget _buildItem(NavigationItem item, bool isSelected) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 270),
      height: double.maxFinite,
      width: isSelected ? 125 : 50,
      padding: isSelected ? EdgeInsets.only(left: 16, right: 16) : null,
      decoration: isSelected
          ? BoxDecoration(
              color: item.color,
              borderRadius: BorderRadius.all(Radius.circular(50)))
          : null,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            children: <Widget>[
              IconTheme(
                data: IconThemeData(
                  size: 24,
                  color: isSelected ? backgroundColor : Colors.black,
                ),
                child: item.icon,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: isSelected
                    ? DefaultTextStyle.merge(
                        style: TextStyle(
                          color: backgroundColor,
                        ),
                        child: item.title)
                    : Container(),
              ),
            ],
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 56,
      padding: EdgeInsets.only(left: 8, top: 4, bottom: 4, right: 8),
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.map((item) {
          var itemIndex = items.indexOf(item);
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = itemIndex;
                widget.onBarTap(_selectedIndex);
              });
            },
            child: _buildItem(item, _selectedIndex == itemIndex),
          );
        }).toList(),
      ),
    );
  }
}

class NavigationItem {
  final Icon icon;
  final Text title;
  final Color color;

  NavigationItem(this.icon, this.title, this.color);
}

Widget _getBody(int index) {
  switch (index) {
    case 0:
      return HomePage2();
    case 1:
      return ListHouse();
    case 2:
      return Contact();
    case 3:
      return UserInfo();
      break;
    default:
  }
}

