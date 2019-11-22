import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UserInfo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UserInfoState();
  }
}

class UserInfoState extends State<UserInfo>{
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String name;
  String phone;
  String email;

  @override
  void initState() {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    FirebaseAuth.instance.currentUser().then((user){
      ref.child('users').child(user.uid).once().then((DataSnapshot snap){
        name = snap.value["name"];
        phone = snap.value["phone"];
        email = snap.value["email"];
        setState(() {
          print('Data: $name,$phone,$email');
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF4F7FA),
        appBar: AppBar
          (
          elevation: 2.0,
          backgroundColor: Colors.white,
          title: Text('Me', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 30.0)),
          /*actions: <Widget>
          [
            Container
              (
              margin: EdgeInsets.only(right: 8.0),
              child: Row
                (
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>
                [
                  Text('com.tuandiep', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700, fontSize: 14.0)),
                  Icon(Icons.arrow_drop_down, color: Colors.black54)
                ],
              ),
            )
          ],*/
        ),
        body: Container(
          alignment: AlignmentDirectional.bottomCenter,
          child: ListView(
            children: <Widget>[
              Container(
                alignment: AlignmentDirectional.center,
                margin: EdgeInsets.only(top: 20),
                child: Center(
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.only(top: 100, bottom: 100),
                          padding: EdgeInsets.only(top: 100, bottom: 50),
                          width: MediaQuery.of(context).size.width * 0.92,
                          child: Container(
                            alignment: AlignmentDirectional.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text('Welcome!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                                Text('$name', style: TextStyle(fontSize: 24),),
                                Text('$phone', style: TextStyle(fontSize: 24),),
                                Text('$email', style: TextStyle(fontSize: 24),),

                                /*Container(
                                  padding: EdgeInsets.only(top: 20),
                                  width: 180,
                                  child: froyoOutlineBtn('Update info', (){}),
                                ),
                                Container(
                                  width: 180,
                                  child: froyoOutlineBtn('Change Password', () {}),
                                ),
                                Container(
                                  width: 180,
                                  child: froyoFlatBtn('LogOut', () {
                                    _logOut();
                                  }),
                                )*/
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
                                    color: Color.fromRGBO(0, 0, 0, .05))
                              ]),
                        ),
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 200,
                            height: 160,
                            child: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Color(0xdfd8d8d8)
                              ),
                              child: Container(
                                  padding: EdgeInsets.all(15),
                                  child: Image.asset("ic_user_avartar_error.png")),
                            ),
                          )
                      )],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void _logOut() {}
}