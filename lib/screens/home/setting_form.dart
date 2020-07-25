import 'package:bullscows/models/user.dart';
import 'package:bullscows/services/database.dart';
import 'package:bullscows/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final FirebaseMessaging _fcm = FirebaseMessaging();

  // form values
  String _currentName;
  String _currentGames;
  String _currentWins;
  int _currentBestScore;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Profile Settings',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    initialValue: userData.name,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: Colors.orangeAccent[400],
                      ),
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent[400], width: 2.0),
                      ),
                    ),
                    validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    enabled: false,
                    style: TextStyle(color: Colors.white),
                    initialValue: userData.games.toString(),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.games,
                        color: Colors.orangeAccent[400],
                      ),
                      labelText: 'Games',
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent[400], width: 2.0),
                      ),
                    ),
                    validator: (val) => val.isEmpty ? 'Enter Games' : null,
                    onChanged: (val) => setState(() => _currentGames = val),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    enabled: false,
                    style: TextStyle(color: Colors.white),
                    initialValue: userData.wins.toString(),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.navigate_next,
                        color: Colors.orangeAccent[400],
                      ),
                      labelText: 'Wins',
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent[400], width: 2.0),
                      ),
                    ),
                    validator: (val) => val.isEmpty ? 'Enter Wins' : null,
                    onChanged: (val) => setState(() => _currentWins = val),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    enabled: false,
                    style: TextStyle(color: Colors.white),
                    initialValue: userData.bestScore.toString(),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.navigate_next,
                        color: Colors.orangeAccent[400],
                      ),
                      labelText: 'Best Score',
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent[400], width: 2.0),
                      ),
                    ),
                    validator: (val) => val.isEmpty ? 'Enter Best Score' : null,
                    onChanged: (val) => setState(() => _currentBestScore = int.parse(val)),
                  ),
                  SizedBox(height: 10.0),
                  RaisedButton(
                      color: Colors.orangeAccent[400],
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        String pushID = await _fcm.getToken();
                        if(_formKey.currentState.validate()){
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentName ?? userData.name,
                              _currentGames ?? userData.games,
                              _currentWins ?? userData.wins,
                              _currentBestScore ?? userData.bestScore,
                              pushID ?? userData.pushID,
                          );
                          Navigator.pop(context);
                        }
                      }
                  ),
                ],
              ),
            );
        }else {
          return Loading();
        }

      }
    );
  }
}