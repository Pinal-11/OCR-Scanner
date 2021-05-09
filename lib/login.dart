import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocr_scanner/background_login.dart';
import 'package:ocr_scanner/email_password_UI.dart';
import 'package:ocr_scanner/services/auth.dart';
import 'package:ocr_scanner/services/phone_auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    Key key,
    @required this.auth,
  }) : super(key: key);
  final AuthBase auth;

  Future<void> _signInAnonumously() async {
    try {
      await auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  /*Future<void> _signInWithFacebook() async {
    try {
      await auth.signInWithFacebook();
    } catch (e) {
      print(e.toString());
    }
  }*/

  Future<void> _signInWithGoogle() async {
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  Widget _buildSignInWithText() {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            'OR',
            style: TextStyle(
              color: Colors.blueAccent[700],
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Sign in with',
            style: TextStyle(
              color: Colors.blueAccent[700],
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildSocialBtnRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton(
            backgroundColor: Color(0xff3377ff),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> PhoneLoginScreen()));
            },
            child: Icon(Icons.phone),
          ),
          RaisedButton(
            textColor: Colors.white,
            color: Colors.deepPurpleAccent,
            child: Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Text(
                  "GO Anonymous",
                  style: TextStyle(fontSize: 16),
                )),
            onPressed: _signInAnonumously,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
          ),
          FloatingActionButton(
            onPressed: _signInWithGoogle,
            backgroundColor: Color(0xffffffff),
            child: Image(image: AssetImage('assets/images/google-logo.png')),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Background(
          child: Padding(
            padding: EdgeInsets.only(top: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 80),
                Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: Card(
                      color: Colors.white,
                        shadowColor: Colors.grey,
                        elevation: 10.0,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Email_pass_form(auth: auth,),
                        )
                    )
                ),

                SizedBox(height: 10),
                _buildSignInWithText(),
                _buildSocialBtnRow(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
