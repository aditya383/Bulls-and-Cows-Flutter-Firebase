import 'package:flutter/material.dart';
import 'package:bullscows/models/player.dart';
import 'package:bullscows/game/two/invite_form.dart';

class PlayerTile extends StatelessWidget {

  final Player player;
  PlayerTile({this.player});
  @override
  Widget build(BuildContext context) {
    void _showInvitePanel() {
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
          child: InviteForm(player: player),
        );
      });
    }

    return Padding(
      padding: EdgeInsets.only(top:8.0),
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          onTap: (){
            _showInvitePanel();
          },
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.orangeAccent[400],
          ),
          title: Text(player.name),
          subtitle: Text('Total Games: ${player.games}, Wins: ${player.wins}, Best Score: ${player.bestScore}'),
        ),
      ),
    );
  }
}
