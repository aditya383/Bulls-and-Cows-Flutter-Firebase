class User {

  final String uid;
  User({ this.uid });

}

class UserData {
  final String uid;
  final String name;
  final int games;
  final int wins;
  final int bestScore;
  final String pushID;
  UserData({this.uid, this.name, this.games, this.wins, this.bestScore, this.pushID});
}