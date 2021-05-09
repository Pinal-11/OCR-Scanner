import 'package:flutter/material.dart';
import 'package:ocr_scanner/HomePage.dart';
import 'package:ocr_scanner/services/auth.dart';

enum EmailSignInFormType {signIn, register}

class Email_pass_form extends StatefulWidget {
  Email_pass_form({@required this.auth});
  final AuthBase auth;
  @override
  _Email_pass_formState createState() => _Email_pass_formState();
}

class _Email_pass_formState extends State<Email_pass_form> {

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String get _email => _emailcontroller.text;
  String get _password => _passwordcontroller.text;

  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  void _submit() async {
    try{
      if(_formType == EmailSignInFormType.signIn) {
          await widget.auth.SignInWithEmailPassword(_email, _password);
        }
      else{
        await widget.auth.createUserWithEmailAndPassword(_email, _password);
        EmailSignInFormType _formType = EmailSignInFormType.signIn;
      }

    }
    catch(e)
    {
      print(e.toString());
    }
  }

  void _emailEditingComplete() {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  void _toggleFormType() {
    setState(() {
      _formType = _formType == EmailSignInFormType.signIn ? EmailSignInFormType.register : EmailSignInFormType.signIn;
    });
    _emailcontroller.clear();
    _passwordcontroller.clear();
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.signIn ? 'Login' : 'Register';
    final secondarytext = _formType == EmailSignInFormType.signIn ? 'Need an account ? Register' : 'Have an account? Sign In';

    bool submitEnabled = _email.isNotEmpty && _password.isNotEmpty;
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Row(
          children: [
            Text(
              "welcome user",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurpleAccent,
                  fontSize: 22),
              textAlign: TextAlign.left,
            ),
            SizedBox(width: 1.0),
            Icon(Icons.person,color: Colors.deepPurpleAccent,)
          ],
        ),
      ),

      SizedBox(height: 20.0),
      Padding(
        padding: EdgeInsets.only(left: 20.0),
        child: Text(
          'Email',
          style: TextStyle(
            color: Colors.deepPurpleAccent,
            fontSize: 16.0,
            fontFamily: 'OpenSans',
          ),
          textAlign: TextAlign.left,
        ),
      ),
      SizedBox(height: 10.0),
      Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            gradient: new LinearGradient(colors: [
              Color.fromARGB(255, 170, 57, 255),
              Color.fromARGB(255, 106, 95, 252)
            ]),
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 7.0,
                offset: Offset(-1, 1),
              ),
            ],
          ),
          height: 50.0,
          child: TextField(
            controller: _emailcontroller,
            focusNode: _emailFocusNode,
            onChanged: (email) =>_updateState(),
            onEditingComplete: _emailEditingComplete,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 20),
      Padding(
        padding: EdgeInsets.only(left: 20.0),
        child: Text(
          'Password',
          style: TextStyle(
            color: Colors.deepPurpleAccent,
            fontSize: 16.0,
            fontFamily: 'OpenSans',
          ),
          textAlign: TextAlign.left,
        ),
      ),
      SizedBox(height: 10.0),
      Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            gradient: new LinearGradient(colors: [
              Color.fromARGB(255, 170, 57, 255),
              Color.fromARGB(255, 106, 95, 252)
            ]),
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 7.0,
                offset: Offset(-1,1),
              ),
            ],
          ),
          height: 50.0,
          child: TextField(
            controller: _passwordcontroller,
            focusNode: _passwordFocusNode,
            onEditingComplete: _submit,
            onChanged: (password) =>_updateState(),
            obscureText: true,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 40),

    Center(
      child: RaisedButton(
      textColor: Color(0xFF2661FA),
      color: Color(0xffffffff),
      elevation: 10.0,
      child: Padding(
        padding:
        EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
        child: Text(
          primaryText,
          style: TextStyle(fontSize: 22),
        ),
      ),
      onPressed: submitEnabled ? _submit : null,
      shape: new RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(10.0),
      ),
      ),
    ),

      SizedBox(height: 10),
      Center(
        child: FlatButton(
            onPressed: _toggleFormType,
            child: Text(
              secondarytext,
              style: TextStyle(fontSize: 16.0, color: Colors.deepPurpleAccent),
            )),
      )
    ];
  }

  void _updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildChildren(),
    );
  }
}
