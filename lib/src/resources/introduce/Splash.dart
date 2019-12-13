import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/resources/login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: new Color(0xff622F74),
                gradient: LinearGradient(
                  colors: [new Color(0xff6094e8), new Color(0xffde5cbc)],
                  begin: Alignment.centerRight,
                  end: new Alignment(-1.0, -1.0),
                )),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/ic_house_planning.png',scale: 4.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        'E-House manager',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      "Quản lí phòng trọ \n của chính bạn",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
