import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/app.dart';
import 'package:flutter_app/src/blocs/login_bloc.dart';
import 'package:flutter_app/src/resources/dialog/loading_dialog.dart';
import 'package:flutter_app/src/resources/dialog/msg_dialog.dart';
import 'package:flutter_app/src/resources/register_page.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc bloc = new LoginBloc();

  bool _showPass = false;
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                alignment: AlignmentDirectional.center,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: Container(
                      width: 70,
                      height: 70,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xffd8d8d8)),
                      child: FlutterLogo()),
                ),
              ),
              Container(
                alignment: AlignmentDirectional.center,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                  child: Text(
                    "GC - Manage",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 30),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
                child: StreamBuilder(
                  stream: bloc.userStream,
                  builder: (context, snapshot) => TextField(
                    controller: _userController,
                    obscureText: false,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "UserName",
                      /*prefixIcon: Container(
                              width: 50, child: Image.asset("ic_envelope.png"),
                            ),*/
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffCED0D2), width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      errorText: snapshot.hasError ? snapshot.error : null,
                      labelStyle:
                          TextStyle(color: Color(0xff888888), fontSize: 18),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                    StreamBuilder(
                      stream: bloc.passStream,
                      builder: (context, snapshot) => TextField(
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        controller: _passController,
                        obscureText: !_showPass,
                        decoration: InputDecoration(
                          labelText: "Password",
                          /*prefixIcon: Container(
                                width: 50, child: Image.asset("ic_gmail.png"),
                              ),*/
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffCED0D2), width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6))),
                          errorText: snapshot.hasError ? snapshot.error : null,
                          labelStyle:
                              TextStyle(color: Color(0xff888888), fontSize: 18),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: onToggleShowPass,
                      child: Text(
                        _showPass ? "HIDE   " : "SHOW  ",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                child: Container(
                  constraints: BoxConstraints.loose(Size(double.infinity, 30)),
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: RaisedButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    onPressed: _onSignInClicked,
                    child: Text(
                      "SIGNIN",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 40),
                child: Container(
                  alignment: AlignmentDirectional.center,
                  child: RichText(
                    text: TextSpan(
                        text: "New user? ",
                        style:
                            TextStyle(color: Color(0xff606470), fontSize: 16),
                        children: <TextSpan>[
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterPage()));
                                },
                              text: "Sign up for a new account",
                              style: TextStyle(
                                  color: Color(0xff3277D8), fontSize: 16))
                        ]),
                  ),
                ),
              )
            ]),
      ),
    );
  }

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  void _onSignInClicked() {
    String email = _userController.text;
    String pass = _passController.text;
    var authBloc = MyApp.of(context).authBloc;
    LoadingDialog.showLoadingDialog(context, "Loading...");
    authBloc.signIn(email, pass, (){
      LoadingDialog.hideLoadingDialog(context);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
    }, (msg){
      LoadingDialog.hideLoadingDialog(context);
      MsgDialog.showMsgDialog(context, "Sign_In", msg);
    });
    /*if (bloc.isValidInfo(_userController.text, _passController.text)) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }*/
  }

  Widget gotoHome(BuildContext context) {
    return HomePage();
  }
}
