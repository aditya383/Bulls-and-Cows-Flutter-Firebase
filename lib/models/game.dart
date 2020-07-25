class Game {

  final String uid;
  Game({ this.uid });

}

class GameData {
  final bool turn;
  final String uid;
  final String bulls;
  final String cows;
  final String guess;
  final String name;
  final String receiverID;
  final String receiverNumber;
  final String senderID;
  final String senderNumber;
  GameData({this.turn, this.uid, this.bulls, this.cows, this.guess, this.name, this.receiverID, this.receiverNumber, this.senderID, this.senderNumber});
}