import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/src/resources/dashboard_page.dart';
import 'package:flutter_app/src/resources/home_page_2.dart';
import 'package:flutter_app/src/resources/introduce/app_introduce.dart';
import 'package:flutter_app/src/resources/list_house_page.dart';
import 'package:flutter_app/src/resources/user_info_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future checkFirstSeen() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (!_seen){
      prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new IntroScreen()));
    }
  }
  DateTime currentBackPressTime;
  int selectedBar =0;
  @override
  void initState() {
    super.initState();
    new Timer(new Duration(milliseconds: 200), () {
      checkFirstSeen();
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          child: WillPopScope (child: _getBody(selectedBar), onWillPop: onWillPop)),
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
    NavigationItem(Icon(Icons.whatshot), Text('House'), Colors.blue),
    NavigationItem(Icon(Icons.dashboard), Text('Board'), Colors.blue),
    NavigationItem(Icon(Icons.person), Text('Infor'), Colors.blue),
  ];

  Widget _buildItem(NavigationItem item, bool isSelected) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 330),
      curve: Curves.ease,
      height: double.maxFinite,
      width: isSelected ? 120 : 50,
      padding: isSelected ? EdgeInsets.only(left: 16, right: 16) : null,
      decoration: BoxDecoration(
              color: isSelected ?  item.color : Colors.transparent ,
              borderRadius: BorderRadius.all(Radius.circular(50))) ,
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
      return DashboardPage();
    case 3:
      return UserInfo();
      break;
    default:
  }
}

