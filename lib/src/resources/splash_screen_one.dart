import 'package:flutter/material.dart';

class SplashScreenOne extends StatefulWidget{
  @override
  _SplashScreenOneState createState() => _SplashScreenOneState();
}

class _SplashScreenOneState extends State<SplashScreenOne>{
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
              )
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 75.0,
                child: Icon(
                  Icons.beach_access,
                  color: Colors.deepOrange,
                  size: 50.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              Text(
                'This is a Sample Text',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}