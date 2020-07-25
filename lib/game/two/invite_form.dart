import 'package:bullscows/models/user.dart';
import 'package:bullscows/services/database.dart';
import 'package:flutter/material.dart';
import 'package:bullscows/game/two/withPlayer.dart';
import 'package:bullscows/models/player.dart';
import 'package:provider/provider.dart';

class InviteForm extends StatefulWidget {
  final Player player;
  InviteForm({Key key, this.player}) : super(key: key);

  @override
  _InviteFormState createState() => _InviteFormState();
}

class _InviteFormState extends State<InviteForm> {
  final _formKey = GlobalKey<FormState>();

  String senderNumber;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        UserData userData = snapshot.data;
        return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Invite ${widget.player.name}',
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
                onChanged: (val) => setState(() => senderNumber = val),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10.0),

              RaisedButton(
                  color: Colors.orangeAccent[400],
                  child: Text(
                    'Invite',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    DatabaseService(uid: user.uid).deleteGameData();
                    DatabaseService(uid: user.uid).updateGameData(false, userData.name, "" , "", "", widget.player.id , "9876", user.uid, senderNumber);
                    if(_formKey.currentState.validate()){
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WithPlayer(player: widget.player, senderID: userData.uid, senderName: userData.name, senderNumber: senderNumber,)),
                      );
                    }
                  }
              ),
            ],
          ),
        );
      }
    );
  }
}