import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bullscows/game/game.dart';
import 'package:provider/provider.dart';
import 'package:bullscows/models/user.dart';
import 'package:bullscows/services/database.dart';


class WithAndroid extends StatefulWidget {
  @override
  _WithAndroidState createState() => _WithAndroidState();
}

class Allpossible{

  List<int> possible = [];
  Allpossible(){
    int i;
    for(i=123;i<=9876;i++)
    {
      int d=i%10;
      int c=((i%100) - d)~/10;
      int b=((i%1000)-(i%100))~/100;
      int a=(i-(i%1000))~/1000;
      if(a!=b && a!=c && a!=d && b!=c && b!=d && c!=d)
      {
        possible.add(i);
      }
    }
  }

}


class CheckBullsCows{

  CheckBullsCows(int bull, int cow, int randomNum, List<int> possi){
    int d2=randomNum%10;
    int c2=((randomNum%100) - d2)~/10;
    int b2=((randomNum%1000)-(randomNum%100))~/100;
    int a2=(randomNum-(randomNum%1000))~/1000;

    for(int i=0; i<possi.length; i++){

      int x=0;
      int y=0;
      if(possi[i] != 0){
        int d1=possi[i]%10;
        int c1=((possi[i]%100) - d1)~/10;
        int b1=((possi[i]%1000)-(possi[i]%100))~/100;
        int a1=(possi[i]-(possi[i]%1000))~/1000;


        if(a1==a2)
        {
          x++;
        }
        else if(a1==b2||a1==c2||a1==d2)
        {
          y++;
        }
        if(b1==b2)
        {
          x++;
        }
        else if(b1==a2||b1==c2||b1==d2)
        {
          y++;
        }
        if(c1==c2)
        {
          x++;
        }
        else if(c1==a2||c1==b2||c1==d2)
        {
          y++;
        }
        if(d1==d2)
        {
          x++;
        }
        else if(d1==a2||d1==b2||d1==c2)
        {
          y++;
        }
        if(x == bull && y == cow)
        {
        }
        else
        {
          possi.setAll(i,[0]);
        }
      }

    }

  }
}

class _WithAndroidState extends State<WithAndroid> {

  final _formKey = GlobalKey<FormState>();
  String checkNum = '';
  String _currentName = 'My Game';

  List<List<int>> display = [];
  List<List<int>> displayAndroid = [];
  List<int> randomNumber = [];

  int pcGuess;
  int cows = 9;
  int bulls = 9;
  bool turn = true;
  List<int> possi = [];

  final TextEditingController ecls = new TextEditingController();

  @override

  void initState() {
    _getThingsOnStartup().then((value){
      print('Async done');
      CreateRandomNum randomNumOne = CreateRandomNum();
      randomNumber = randomNumOne.randomNum();
      pcGuess = (randomNumber[0]*1000 + randomNumber[1]*100 + randomNumber[2]*10 + randomNumber[3]);
      CreateRandomNum randomNumTwo = CreateRandomNum();
      randomNumber = randomNumTwo.randomNum();
      Allpossible allpossible = Allpossible();
      possi = allpossible.possible;
      print(randomNumber);
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,

      builder:(context, snapshot) {
        UserData userData = snapshot.data;
        if(snapshot.hasData){
          _currentName = userData.name;
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
                            label: Text('Android', style: TextStyle(color: Colors.white),),
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
                              width: 120.0,
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
                                    if (turn) {
                                      checkNum = str;
                                      CheckNumber checkNumberTen = CheckNumber(
                                          int.parse(checkNum), randomNumber);
                                      List<int> bullsAndcows10 = checkNumberTen
                                          .bullsAndCows();
                                      print(bullsAndcows10);
                                      if (bullsAndcows10 != null) {
                                        if (bullsAndcows10[1] != 4) {
                                          display.add(bullsAndcows10);
                                          displayAndroid.add([pcGuess, 9, 9]);
                                          //('display is $display');
                                          //print('displayAndroid is $displayAndroid');
                                          turn = !turn;
                                        } else {
                                          CreateRandomNum randomNumOne = CreateRandomNum();
                                          randomNumber =  randomNumOne.randomNum();
                                          print('new $randomNumber');
                                          Allpossible allpossibleOne = Allpossible();
                                          possi = allpossibleOne.possible;
                                          display = [];
                                          displayAndroid = [];
                                          print( '..........This is game over........');
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
                                      }
                                      else {
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
                                    else {
                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Enter Bulls and Cows'),
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

                      Builder(
                        builder: (context) =>
                        Form(
                          key: _formKey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SizedBox(
                                width: 60.0,
                                child: TextFormField(
                                  maxLength: 1,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: 'Bulls',
                                    labelStyle: TextStyle(color: Colors.white),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.orangeAccent[400], width: 2.0),
                                    ),
                                  ),
                                  validator: (val) => val.isEmpty ? 'Bulls' : null,
                                  onChanged: (val) => setState(() => bulls = int.parse(val)),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
                                ),
                              ),

                              SizedBox(
                                width: 60.0,
                                child: TextFormField(
                                  maxLength: 1,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: 'Cows',
                                    labelStyle: TextStyle(color: Colors.white),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.orangeAccent[400], width: 2.0),
                                    ),
                                  ),
                                  validator: (val) => val.isEmpty ? 'Cows' : null,
                                  onChanged: (val) => setState(() => cows = int.parse(val)),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
                                ),
                              ),

                              SizedBox(
                                width: 80.0,
                                child: RaisedButton(
                                    color: Colors.orangeAccent[400],
                                    child: Text(
                                      'Submit',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      FocusScope.of(context).unfocus();
                                      print('bulls $bulls');
                                      print('cows $cows');
                                      if (turn == false) {
                                        if (bulls == 4 && cows == 0) {
                                          setState(() {
                                            turn = !turn;
                                            Scaffold.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('Android Won, Its Number is $randomNumber'),
                                                action: SnackBarAction(
                                                  label: 'OK',
                                                  onPressed: () {
                                                    // Some code to undo the change.
                                                  },
                                                ),
                                              ),
                                            );
                                            CreateRandomNum randomNumOne = CreateRandomNum();
                                            randomNumber = randomNumOne.randomNum();
                                            print('new $randomNumber');
                                            Allpossible allpossibleOne = Allpossible();
                                            possi = allpossibleOne.possible;
                                            display = [];
                                            displayAndroid = [];
                                          });
                                        }
                                        else if((cows + bulls) >= 0 && (cows + bulls) <= 4){
                                          setState(() {
                                              displayAndroid.removeLast();
                                              displayAndroid.add([pcGuess, bulls, cows]);
                                              //print('display is $display');
                                              //print('displayAndroid is $displayAndroid');
                                              CheckBullsCows(bulls, cows, pcGuess, possi);
                                              int possibleLength = 0;
                                              for (int p = 0; p < possi.length; p++) {
                                                if (possi[p] != 0) {
                                                  pcGuess = possi[p];
                                                  print('PC Guess is $pcGuess');
                                                  break;
                                                }
                                                else {
                                                  possibleLength++;
                                                }
                                              }
                                              turn = !turn;
                                              if (possibleLength == possi.length) {
                                                setState(() {
                                                  CreateRandomNum randomNumOne = CreateRandomNum();
                                                  randomNumber = randomNumOne.randomNum();
                                                  print('new $randomNumber');
                                                  Allpossible allpossibleOne = Allpossible();
                                                  possi = allpossibleOne.possible;
                                                  display = [];
                                                  displayAndroid = [];
                                                  Scaffold.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Text('There was a wrong entry of Bulls and Cows'),
                                                      action: SnackBarAction(
                                                        label: 'OK',
                                                        onPressed: () {
                                                          // Some code to undo the change.
                                                        },
                                                      ),
                                                    ),
                                                  );
                                                });
                                              }
                                          });
                                        }
                                        else{
                                          Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Enter Valid Bulls and Cows'),
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
                                      else {
                                        Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Enter Guess'),
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

                                ),
                              ),
                            ],
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
                          setState(() {
                            turn = true;
                            CreateRandomNum randomNumOne = CreateRandomNum();
                            randomNumber = randomNumOne.randomNum();
                            print('new $randomNumber');
                            Allpossible allpossibleOne = Allpossible();
                            possi = allpossibleOne.possible;
                            display = [];
                            displayAndroid = [];
                            print('..........This is restart........');
                          });
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
  Future _getThingsOnStartup() async {
    await Future.delayed(Duration(seconds: 1));
  }
}
