import 'package:bullscows/models/player.dart';
import 'package:bullscows/screens/home/player_list.dart';
import 'package:bullscows/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bullscows/screens/home/setting_form.dart';

class Two extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

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


    return StreamProvider<List<Player>>.value(
      value: DatabaseService().player,
      child: Scaffold(
        backgroundColor: Colors.blueGrey[700],
        appBar: AppBar(
          title: Text('Players'),
          backgroundColor: Colors.blueGrey[700],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.settings, color: Colors.orangeAccent[400],),
              label: Text('Settings', style: TextStyle(color: Colors.white),),
              onPressed: () => _showSettingsPanel(),
            ),

          ],
        ),
        body: PlayerList(),
      ),
    );
  }
}