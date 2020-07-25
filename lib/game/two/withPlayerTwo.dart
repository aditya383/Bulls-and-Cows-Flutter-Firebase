import 'package:bullscows/models/game.dart';
import 'package:bullscows/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bullscows/game/game.dart';
import 'package:bullscows/services/database.dart';
import 'package:provider/provider.dart';


class WithPlayerTwo extends StatefulWidget {
  WithPlayerTwo({Key key, this.gameID, this.senderName, this.senderNumber, this.receiverName, this.receiverNumber, this.receiverID}) : super(key: key);
  final String gameID;
  final String receiverID;
  final String receiverName;
  final String senderName;
  final String senderNumber;
  final String receiverNumber;
  @override
  _WithPlayerTwoState createState() => _WithPlayerTwoState();
}

class _WithPlayerTwoState extends State<WithPlayerTwo> {

  String checkNum = '';

  List<List<int>> display = [];
  List<List<int>> displayAndroid = [];
  List<int> randomNumber = [];


  bool turn = true;
  String bulls = '0';

  final TextEditingController ecls = new TextEditingController();

  @override

  void initState() {
    _getThingsOnStartup().then((value) {
      print('Async done');
      int senderNumber = int.parse(widget.senderNumber);
      int d=senderNumber%10;
      int c=((senderNumber%100) - d)~/10;
      int b=((senderNumber%1000)-(senderNumber%100))~/100;
      int a=(senderNumber-(senderNumber%1000))~/1000;
      randomNumber.add(a);
      randomNumber.add(b);
      randomNumber.add(c);
      randomNumber.add(d);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return new StreamBuilder<GameData>(
        stream: DatabaseService(uid: widget.gameID).gameData,
        builder:(context, snapshot) {
          GameData gameData = snapshot.data;
          if (snapshot.hasData) {
            print(gameData);
            turn = gameData.turn;
            print(turn);
            print(gameData.guess);
            if(!turn && gameData.guess != '' && bulls != '4'){
                displayAndroid.removeLast();
                displayAndroid.add([int.parse(gameData.guess), int.parse(gameData.bulls), int.parse(gameData.cows)]);
                bulls = gameData.bulls;
                print(bulls);
                print(display);
                print(displayAndroid);
                print('Added to display list two');
            }
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
                              label: Text(widget.receiverName, style: TextStyle(color: Colors.white),),
                              onPressed: (){},
                            ),
                            FlatButton.icon(
                              icon: Icon(Icons.arrow_downward, color: Colors.black,),
                              label: Text(widget.senderName, style: TextStyle(color: Colors.white),),
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
                                      if (!turn && bulls != '4') {
                                          checkNum = str;
                                          CheckNumber checkNumberTen = CheckNumber(int.parse(checkNum), randomNumber);
                                          List<int> bullsAndcows10 = checkNumberTen.bullsAndCows();
                                          print(bullsAndcows10);
                                          if (bullsAndcows10 != null) {
                                            if (bullsAndcows10[1] != 4) {
                                              turn = !turn;
                                              display.add(bullsAndcows10);
                                              displayAndroid.add([0, 9, 9]);
                                              print(display);
                                              print(displayAndroid);
                                              DatabaseService(uid: widget.gameID).updateGameData(turn, widget.senderName, bullsAndcows10[1].toString() , bullsAndcows10[2].toString(), bullsAndcows10[0].toString(), widget.receiverID , widget.receiverNumber, widget.gameID, widget.senderNumber);

                                            }
                                            else {
                                              print('new $randomNumber');
                                              turn = !turn;
                                              display.add(bullsAndcows10);
                                              displayAndroid.add([0,9,9]);
                                              print(display);
                                              print(displayAndroid);
                                              DatabaseService(uid: widget.gameID).updateGameData(turn, widget.senderName, bullsAndcows10[1].toString() , bullsAndcows10[2].toString(), bullsAndcows10[0].toString(), widget.receiverID , widget.receiverNumber, widget.gameID, widget.senderNumber);

                                              print('..........This is game over........');

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
                                      else if(!turn && bulls == '4'){

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

                    SizedBox(height: 10.0,),
                  ],
                ),
              ),

            ),
          );
        }
    );
  }

  Future _getThingsOnStartup() async {
    await Future.delayed(Duration(seconds: 5));
  }
}
