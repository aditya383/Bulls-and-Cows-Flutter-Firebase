import 'dart:ui';
import 'package:bullscows/game/single/single.dart';
import 'package:bullscows/game/two/two.dart';
import 'package:bullscows/screens/home/setting_form.dart';
import 'package:bullscows/services/auth.dart';
import 'package:bullscows/services/database.dart';
import 'package:flutter/material.dart';
import 'package:bullscows/game/two/withAndroid.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:bullscows/game/two/withPlayerTwo.dart';
import 'package:provider/provider.dart';
import 'package:bullscows/models/user.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  final FirebaseMessaging _fcm = FirebaseMessaging();
  String _currentName = 'Settings';
  String _receiverID = '';

  @override
  void initState(){

    super.initState();
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async{
        print('onMessage $message');
        handleMessage(message);
      },
      onLaunch: (Map<String, dynamic> message) async{
        print('onLaunch $message');
        handleMessage(message);
      },
      onResume: (Map<String, dynamic> message) async{
        print('onResume $message');
        handleMessage(message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

      return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            UserData userData = snapshot.data;
            _currentName = userData.name;
            _receiverID = user.uid;
          }
          return Scaffold(
            backgroundColor: Colors.blueGrey[700],
            appBar: AppBar(
              backgroundColor: Colors.blueGrey[700],
              elevation: 0.0,
              actions: <Widget>[

                FlatButton.icon(
                  icon: Icon(Icons.account_circle, color: Colors.orangeAccent[400],),
                  label: Text(_currentName, style: TextStyle(color: Colors.white),),
                  onPressed: () => _showSettingsPanel(),
                ),

                FlatButton.icon(
                  icon: Icon(Icons.exit_to_app, color: Colors.orangeAccent[400],),
                  label: Text('Logout', style: TextStyle(color: Colors.white),),
                  onPressed: () async {
                    await _auth.signOut();
                  },
                ),
              ],
            ),

            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 1.4 * (MediaQuery.of(context).size.height / 20),
                      width: 5 * (MediaQuery.of(context).size.width / 10),
                      margin: EdgeInsets.only(bottom: 20),
                      child: RaisedButton(
                        elevation: 5.0,
                        color: Colors.blueGrey[500],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SinglePlayer()),
                          );
                        },
                        child: Text(
                          "Single Player",
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontSize: MediaQuery.of(context).size.height / 40,
                          ),
                        ),
                      ),
                    ),

                    Container(
                      height: 1.4 * (MediaQuery.of(context).size.height / 20),
                      width: 5 * (MediaQuery.of(context).size.width / 10),
                      margin: EdgeInsets.only(bottom: 20),
                      child: RaisedButton(
                        elevation: 5.0,
                        color: Colors.blueGrey[500],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Two()),
                          );
                        },
                        child: Text(
                          "vs Player",
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontSize: MediaQuery.of(context).size.height / 40,
                          ),
                        ),
                      ),
                    ),

                    Container(
                      height: 1.4 * (MediaQuery.of(context).size.height / 20),
                      width: 5 * (MediaQuery.of(context).size.width / 10),
                      margin: EdgeInsets.only(bottom: 20),
                      child: RaisedButton(
                        elevation: 5.0,
                        color: Colors.blueGrey[500],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => WithAndroid()),
                          );
                        },
                        child: Text(
                          "vs Android",
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontSize: MediaQuery.of(context).size.height / 40,
                          ),
                        ),
                      ),
                    ),

                    Container(
                      height: 1.4 * (MediaQuery.of(context).size.height / 20),
                      width: 5 * (MediaQuery.of(context).size.width / 10),
                      margin: EdgeInsets.only(bottom: 20),
                      child: RaisedButton(
                        elevation: 5.0,
                        color: Colors.orangeAccent[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        onPressed: () {
                          showAboutDialog(
                            context: context,
                            applicationIcon: FlutterLogo(),
                            applicationName: 'Bulls & Cows',
                            applicationVersion: 'June 2020',
                            children: <Widget>[
                              Text('The aim is to guess opponents secret number',
                                  style: TextStyle( fontSize: 20.0, color: Colors.blueGrey[700])),
                              SizedBox(height: 5.0,),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(color: Colors.blueGrey[700], fontSize: 16.0),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Example if opponents secret number is: '),
                                    TextSpan(text: '6309',
                                        style: TextStyle(color: Colors.orangeAccent[400])),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5.0,),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(color: Colors.blueGrey[700], fontSize: 16.0),
                                  children: <TextSpan>[
                                    TextSpan(text: 'Your guess is: '),
                                    TextSpan(text: '1360 ',
                                        style: TextStyle(color: Colors.blueAccent[400])),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(color: Colors.blueGrey[700], fontSize: 16.0),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Then values of Bulls and Cows are: '),
                                    TextSpan(text: '1 bull and 2 cow ',
                                        style: TextStyle(color: Colors.greenAccent[400])),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5.0,),
                              Text(
                                '(since 6 and 0 are in wrong position and 3 is in correct position)',
                                style: TextStyle(fontSize: 14.0, color: Colors.blueGrey[700]),),
                              SizedBox(height: 5.0,),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.blueGrey[700], fontSize: 16.0),
                                  children: <TextSpan>[
                                    TextSpan(text: 'Your second guess is: '),
                                    TextSpan(text: '6905',
                                        style: TextStyle(color: Colors.blueAccent[400])),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(color: Colors.blueGrey[700], fontSize: 16.0),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Then values of Bulls and Cows are: '),
                                    TextSpan(text: '2 bull and 1 cow ',
                                        style: TextStyle(color: Colors.greenAccent[400])),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5.0,),
                              Text(
                                '(since 6 and 0 are in correct position and 9 is in wrong position)',
                                style: TextStyle(fontSize: 14.0, color: Colors.blueGrey[700]),),

                            ],
                          );
                        },
                        child: Text(
                          "How to Play",
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
            ),
          );
        }
      );
  }

  void _showSettingsPanel() {
    showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: new BoxDecoration(
          color: Colors.blueGrey[700],
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
        child: SettingsForm(),
      );
    });
  }

  void handleMessage(Map<String, dynamic> message) async {
    String senderName = getValueFromMap(message, 'senderName');
    String senderNumber = getValueFromMap(message, 'senderNumber');
    String gameID = getValueFromMap(message, 'gameID');
    String receiverNumber = '';
    final _formKey = GlobalKey<FormState>();
    showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: new BoxDecoration(
          color: Colors.blueGrey[700],
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Invite from $senderName',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                maxLength: 4,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Enter your 4 digit number',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orangeAccent[400], width: 2.0),
                  ),
                ),
                validator: (val) => val.isEmpty ? 'Enter your 4 digit number' : null,
                onChanged: (val) => setState(() =>  receiverNumber = val),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10.0),

              RaisedButton(
                  color: Colors.orangeAccent[400],
                  child: Text(
                    'Accept',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if(_formKey.currentState.validate()){
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WithPlayerTwo(gameID: gameID, senderName: senderName, senderNumber: senderNumber, receiverName: _currentName, receiverNumber: receiverNumber, receiverID: _receiverID,)),
                      );
                    }
                  }
              ),
              SizedBox(height: 20.0),

              RaisedButton(
                  color: Colors.orangeAccent[400],
                  child: Text(
                    'Reject',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }
              ),
            ],
          ),
        ),
      );
    });

  }
  dynamic getValueFromMap(Map<String, dynamic> map, String key) {
   var result = map['data'][key];
    return result;
  }

}