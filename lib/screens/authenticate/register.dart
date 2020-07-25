import 'package:bullscows/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:bullscows/shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String name = '';
  String email = '';
  String password = '';

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 70),
          child: Text(
            'SIGN UP',
            style: TextStyle(
              fontSize: MediaQuery
                  .of(context)
                  .size
                  .height / 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildEmailRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (val) => val.isEmpty ? 'Full Name' : null,
              keyboardType: TextInputType.text,
              onChanged: (val) {
                setState(() => name = val);
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.blueGrey[700],
                ),
                labelText: 'Full Name',
                labelStyle: TextStyle(color: Colors.orangeAccent[400]),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orangeAccent[400], width: 2.0),
                ),
              ),
            ),
            TextFormField(
              validator: (val) => val.isEmpty ? 'Enter an email' : null,
              keyboardType: TextInputType.emailAddress,
              onChanged: (val) {
                setState(() => email = val);
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.blueGrey[700],
                  ),
                  labelText: 'E-mail',
                labelStyle: TextStyle(color: Colors.orangeAccent[400]),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orangeAccent[400], width: 2.0),
                ),
              ),
            ),

            TextFormField(
              keyboardType: TextInputType.text,
              obscureText: true,
              validator: (val) =>
              val.length < 6
                  ? 'Password with six or more characters'
                  : null,
              onChanged: (val) {
                setState(() => password = val);
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.blueGrey[700],
                ),
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.orangeAccent[400]),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orangeAccent[400], width: 2.0),
                ),
              ),
            ),

            SizedBox(height: 10.0,),
            Text(
              error,
              style: TextStyle(color: Colors.orangeAccent[400], fontSize: 14.0),
            ),
            SizedBox(height: 10.0,),

            Container(
              height: 1.4 * (MediaQuery
                  .of(context)
                  .size
                  .height / 20),
              width: 5 * (MediaQuery
                  .of(context)
                  .size
                  .width / 10),
              margin: EdgeInsets.only(bottom: 20),
              child: RaisedButton(
                elevation: 5.0,
                color: Colors.blueGrey[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password, name);
                    if(result == null) {
                      setState(() {
                        loading = false;
                        error = ' Email id already used or No connection';
                      });
                    }
                  }
                },
                child: Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontSize: MediaQuery
                        .of(context)
                        .size
                        .height / 40,
                  ),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                '- OR -',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.orangeAccent[400],
                ),
              ),
            ),

            Container(
              height: 1.4 * (MediaQuery.of(context).size.height / 20),
              width: 5 * (MediaQuery.of(context).size.width / 10),
              margin: EdgeInsets.only(bottom: 20),
              child: RaisedButton(
                elevation: 5.0,
                color: Colors.blueGrey[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                onPressed: () => widget.toggleView(),
                child: Text(
                  "Sign in",
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontSize: MediaQuery.of(context).size.height / 40,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.6,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildEmailRow(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: loading ? Loading() : Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Color(0xfff2f3f7),
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.7,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[700],
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(70),
                    bottomRight: const Radius.circular(70),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildLogo(),
                  _buildContainer(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}