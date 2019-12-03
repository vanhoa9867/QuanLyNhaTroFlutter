import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/blocs/Register_bloc.dart';
import 'package:flutter_app/src/resources/dialog/loading_dialog.dart';
import 'package:flutter_app/src/resources/dialog/msg_dialog.dart';
import 'package:flutter_app/src/resources/home_page.dart';
import 'package:flutter_app/src/resources/login_page.dart';

import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterBloc authBloc = new RegisterBloc();
  TextEditingController _fullnameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  int _state = 0;
  @override
  void dispose(){
    authBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop()),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Image.asset('assets/ic_house_planning.png',scale: 10.0,),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 6),
                child: Text(
                  "Welcome",
                  style: TextStyle(
                      fontSize: 22,
                      color: Color(0xff333333),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "Signup with E-House in simple steps",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff606470),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 10),
                child: StreamBuilder(
                    stream: authBloc.FullNameStream,
                    builder: (context, snapshot) =>
                        TextField(
                          controller: _fullnameController,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                              labelText: "Name",
                              prefixIcon: Container(
                                child: Icon(Icons.person_outline),
                              ),
                              border: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xffCED0D2),
                                      width: 1),
                                  borderRadius: BorderRadius.all(Radius
                                      .circular(6))),
                              errorText: snapshot.hasError ? snapshot.error : null,
                              labelStyle:
                              TextStyle(color: Color(0xff888888),
                                  fontSize: 15)
                          ),
                        )
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: StreamBuilder(
                    stream: authBloc.EmailStream,
                    builder: (context, snapshot) =>
                        TextField(
                          controller: _emailController,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                              labelText: "Email",
                              prefixIcon: Container(
                                width: 50,
                                child: Icon(Icons.mail_outline),
                              ),
                              border: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xffCED0D2),
                                      width: 1),
                                  borderRadius: BorderRadius.all(Radius
                                      .circular(6))),
                              errorText: snapshot.hasError ? snapshot.error : null,
                              labelStyle:
                              TextStyle(color: Color(0xff888888),
                                  fontSize: 15)
                          ),
                        )
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: StreamBuilder(
                    stream: authBloc.PhoneStream,
                    builder: (context, snapshot) =>
                        TextField(
                          controller: _phoneController,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                              labelText: "Phone number",
                              prefixIcon: Container(
                                width: 50,
                                child: Icon(Icons.phone),
                              ),
                              border: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xffCED0D2),
                                      width: 1),
                                  borderRadius: BorderRadius.all(Radius
                                      .circular(6))),
                              errorText: snapshot.hasError ? snapshot.error : null,
                              labelStyle:
                              TextStyle(color: Color(0xff888888),
                                  fontSize: 15)
                          ),
                        )
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 60),
                child: StreamBuilder(
                    stream: authBloc.PassStream,
                    builder: (context, snapshot) =>
                        TextField(
                          obscureText: true,
                          controller: _passwordController,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon: Container(
                                width: 50,
                                child: Icon(Icons.lock_outline),
                              ),
                              border: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xffCED0D2),
                                      width: 1),
                                  borderRadius: BorderRadius.all(Radius
                                      .circular(6))),
                              errorText: snapshot.hasError ? snapshot.error : null,
                              labelStyle:
                              TextStyle(color: Color(0xff888888),
                                  fontSize: 15)
                          ),
                        )
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: MaterialButton(
                    onPressed: _onSignUpClicked,
                    child: setUpButtonChild(),
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 40),
                child: RichText(
                  text: TextSpan(
                      text: "Already a User? ",
                      style: TextStyle(color: Color(0xff606470), fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              },
                            text: "Login now",
                            style: TextStyle(
                                color: Color(0xff3277D8), fontSize: 16))
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onSignUpClicked() {
    setState(() {
      if (_state == 0) {
        animateButton();
      }
    });
  }
  Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text(
        "SIGN UP",
        style: const TextStyle(
          color: Colors.white,
        ),
      );
    } else if (_state == 1) {
      return new CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else if( _state == 2) {
      return new Icon(Icons.check, color: Colors.white);
    }
  }
  void animateButton() {
    setState(() {
      _state = 1;
    });
    var isValid = authBloc.isValid(_fullnameController.text,_emailController.text,_phoneController.text,_passwordController.text);
    if(isValid){
      Timer(Duration(milliseconds: 2300), () {
        authBloc.signUp(_emailController.text, _passwordController.text,_fullnameController.text,_phoneController.text, (){
          setState(() {
            _state = 2;
          });
          //Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterPage()));
        },(msg){
          setState(() {
            _state = 0;
          });
          MsgDialog.showMsgDialog(context, "Sign-up", msg);
        });
      });
    }
    else{
      setState(() {
        _state = 0;
      });
    }
  }
}
