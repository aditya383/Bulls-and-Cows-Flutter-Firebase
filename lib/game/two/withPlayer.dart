import 'package:bullscows/models/game.dart';
import 'package:bullscows/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bullscows/game/game.dart';
import 'package:bullscows/services/database.dart';
import 'package:bullscows/models/player.dart';
import 'package:bullscows/game/two/invite_form.dart';
import 'package:provider/provider.dart';


class WithPlayer extends StatefulWidget {
  WithPlayer({Key key, this.player, this.senderID, this.senderName, this.senderNumber}) : super(key: key);
  final Player player;
  final String senderNumber;
  final String senderID;
  final String senderName;
  @override
  _WithPlayerState createState() => _WithPlayerState();
}


class _WithPlayerState extends State<WithPlayer> {


  String checkNum = '';
  String _currentName = 'My Game';

  List<List<int>> display = [];
  List<List<int>> displayAndroid = [];
  List<int> randomNumber = [];


  bool turn = false;
  String bulls = '0';
  int receiverNumber;

  final TextEditingController ecls = new TextEditingController();

  @override

  void initState() {
    _getThingsOnStartup().then((value) {
      print('Async done');
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<GameData>(
        stream: DatabaseService(uid: user.uid).gameData,
        builder:(context, snapshot) {
          GameData gameData = snapshot.data;
          if (snapshot.hasData) {
            print(gameData);
            turn = gameData.turn;
            _currentName = gameData.name;
            print(turn);
            if(turn && bulls != '4'){
                display.add([0, 9, 9]);
                displayAndroid.add([int.parse(gameData.guess), int.parse(gameData.bulls), int.parse(gameData.cows)]);
                print('Added to display list');
                bulls = gameData.bulls;
                print(bulls);
            }

            receiverNumber = int.parse(gameData.receiverNumber);
            print(receiverNumber);
            int d=receiverNumber%10;
            int c=((receiverNumber%100) - d)~/10;
            int b=((receiverNumber%1000)-(receiverNumber%100))~/100;
            int a=(receiverNumber-(receiverNumber%1000))~/1000;
            randomNumber = [];
            randomNumber.add(a);
            randomNumber.add(b);
            randomNumber.add(c);
            randomNumber.add(d);
            print(randomNumber);
          }

          return MaterialApp(
            home: Scaffold(
              backgroundColor: Colors.blueGrey[700],

              body: SafeArea(
                child: Column(
                  children: <Widget>[

                    Card(
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      color: Colors.blueGrey[700],
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            FlatButton.icon(
                              icon: Icon(Icons.arrow_downward, color: Colors.orangeAccent[400],),
                              label: Text(_currentName, style: TextStyle(color: Colors.white),),
                              onPressed: (){},
                            ),
                            FlatButton.icon(
                              icon: Icon(Icons.arrow_downward, color: Colors.black,),
                              label: Text(widget.player.name, style: TextStyle(color: Colors.white),),
                              onPressed: (){},
                            ),
                          ],
                        ),
                      ),
                    ),

                    Card(
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      color: Colors.blueGrey[700],
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text('Guess',
                              style: TextStyle(
                                color: Colors.orangeAccent[400],
                              ),),
                            Text('B',
                              style: TextStyle(
                                color: Colors.greenAccent,
                              ),),
                            Text('C',
                              style: TextStyle(
                                color: Colors.redAccent,
                              ),),
                            Text('Guess',
                              style: TextStyle(
                                color: Colors.black,
                              ),),
                            Text('B',
                              style: TextStyle(
                                color: Colors.greenAccent,
                              ),),
                            Text('C',
                              style: TextStyle(
                                color: Colors.redAccent,
                              ),),

                          ],
                        ),
                      ),
                    ),


                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: display.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            color: Colors.white,
                            child: ListTile(
                              onTap: () {},
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  display[index][0] < 999 ? Text(
                                    '0' + display[index][0].toString(),
                                    style: TextStyle(
                                      color: Colors.orangeAccent[400],
                                      letterSpacing: 1.5,
                                      fontSize: MediaQuery.of(context).size.height / 40,
                                    ),) : Text(
                                    display[index][0].toString(),
                                    style: TextStyle(
                                      color: Colors.orangeAccent[400],
                                      letterSpacing: 1.5,
                                      fontSize: MediaQuery.of(context).size.height / 40,
                                    ),),
                                  Text(display[index][1].toString(),
                                    style: TextStyle(
                                      color: Colors.greenAccent[400],
                                      letterSpacing: 1.5,
                                      fontSize: MediaQuery.of(context).size.height / 40,
                                    ),),
                                  Text(display[index][2].toString(),
                                    style: TextStyle(
                                      color: Colors.redAccent[200],
                                      letterSpacing: 1.5,
                                      fontSize: MediaQuery.of(context).size.height / 40,
                                    ),),
                                  displayAndroid[index][0] < 999 ? Text(
                                    '0' + displayAndroid[index][0].toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      letterSpacing: 1.5,
                                      fontSize: MediaQuery.of(context).size.height / 40,
                                    ),) : Text(
                                    displayAndroid[index][0].toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      letterSpacing: 1.5,
                                      fontSize: MediaQuery.of(context).size.height / 40,
                                    ),),
                                  Text(displayAndroid[index][1].toString(),
                                    style: TextStyle(
                                      color: Colors.greenAccent[400],
                                      letterSpacing: 1.5,
                                      fontSize: MediaQuery.of(context).size.height / 40,
                                    ),),
                                  Text(displayAndroid[index][2].toString(),
                                    style: TextStyle(
                                      color: Colors.redAccent[200],
                                      letterSpacing: 1.5,
                                      fontSize: MediaQuery.of(context).size.height / 40,
                                    ),),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Builder(
                          builder: (context) =>
                              SizedBox(
                                width: 80.0,
                                child: TextField(
                                  controller: ecls,
                                  maxLength: 4,
                                  autocorrect: true,
                                  decoration: new InputDecoration(
                                    labelText: "Guess",
                                    labelStyle: TextStyle(
                                        color: Colors.orangeAccent[400]),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.orangeAccent[400],
                                          width: 2.0),
                                    ),
                                  ),
                                  onSubmitted: (String str) {
                                    setState(() {
                                      print(turn);
                                      if (turn && bulls != '4') {
                                        checkNum = str;
                                        CheckNumber checkNumberTen = CheckNumber(int.parse(checkNum), randomNumber);
                                        List<int> bullsAndcows10 = checkNumberTen.bullsAndCows();
                                        print(bullsAndcows10);
                                        if (bullsAndcows10 != null) {
                                          if (bullsAndcows10[1] != 4) {
                                            turn = !turn;
                                            print(turn);
                                            display.removeLast();
                                            display.add(bullsAndcows10);
                                            print(display);
                                            print(displayAndroid);
                                            //('display is $display');
                                            //print('displayAndroid is $displayAndroid');
                                            DatabaseService(uid: widget.senderID).updateGameData(turn, widget.senderName, bullsAndcows10[1].toString() , bullsAndcows10[2].toString(), bullsAndcows10[0].toString(), widget.player.id , receiverNumber.toString(), widget.senderID, widget.senderNumber);
                                          } else {
                                            turn = !turn;
                                            print(turn);
                                            display.removeLast();
                                            display.add(bullsAndcows10);
                                            DatabaseService(uid: widget.senderID).updateGameData(turn, widget.senderName, bullsAndcows10[1].toString() , bullsAndcows10[2].toString(), bullsAndcows10[0].toString(), widget.player.id , receiverNumber.toString(), widget.senderID, widget.senderNumber);

                                            Scaffold.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('Yay! Your Won and your Guess is $checkNum'),
                                                action: SnackBarAction(
                                                  label: 'OK',
                                                  onPressed: () {
                                                    // Some code to undo the change.
                                                  },
                                                ),
                                              ),
                                            );
                                          }
                                        } else {
                                          Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Enter a valid number'),
                                              action: SnackBarAction(
                                                label: 'OK',
                                                onPressed: () {
                                                  // Some code to undo the change.
                                                },
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                      else if(turn && bulls == '4'){

                                        Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Opponent has guessed your number and his number is $randomNumber'),
                                            action: SnackBarAction(
                                              label: 'OK',
                                              onPressed: () {
                                                // Some code to undo the change.
                                              },
                                            ),
                                          ),
                                        );
                                      }
                                      else {
                                        Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Let Opponent Guess'),
                                            action: SnackBarAction(
                                              label: 'OK',
                                              onPressed: () {
                                                // Some code to undo the change.
                                              },
                                            ),
                                          ),
                                        );
                                      }
                                    });
                                    ecls.clear();
                                  },
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
                                ),
                              ),
                        ),

                      ],
                    ),
                    ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text('RESTART',
                            style: TextStyle(
                              color: Colors.white,
                            ),),
                          onPressed: () {
                            Navigator.pop(context);
                            _showInvitePanel();
                          },
                        ),

                      ],
                    ),
                  ],
                ),
              ),

            ),
          );
        }
    );
  }
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
        child: InviteForm(player: widget.player),
      );
    });
  }
  Future _getThingsOnStartup() async {
    await Future.delayed(Duration(seconds: 5));
  }
}
