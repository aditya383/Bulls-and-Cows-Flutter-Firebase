import 'package:bullscows/models/game.dart';
import 'package:bullscows/models/player.dart';
import 'package:bullscows/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference playerData = Firestore.instance.collection('player');
  final CollectionReference gamesData = Firestore.instance.collection('games');

  Future updateUserData(String name, int games, int wins, int bestScore, String pushID) async{
    return await playerData.document(uid).setData({
      'name': name,
      'games': games,
      'wins': wins,
      'bestScore': bestScore,
      'pushID': pushID,
    });

  }

  Future updateGameData(bool turn, String name, String bulls , String cows, String guess, String receiverID , String receiverNumber, String senderID, String senderNumber) async{
    return await gamesData.document(uid).setData({
      'turn': turn,
      'name': name,
      'bulls': bulls,
      'cows': cows,
      'guess': guess,
      'receiverID': receiverID,
      'receiverNumber': receiverNumber,
      'senderID': senderID,
      'senderNumber': senderNumber,
    });

  }

  Future deleteGameData() async{
    return await gamesData.document(uid).delete();
  }

  //player list from snapshot
  List<Player> _playerListFromSnapshot (QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Player(
        name: doc.data['name'] ?? '',
        games: doc.data['games'] ?? 0,
        wins: doc.data['wins'] ?? 0,
        bestScore: doc.data['bestScore'] ?? null,
        pushID: doc.data['pushID'] ?? '',
        id: doc.documentID ?? '',
      );
    }).toList();
  }
  //user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      games: snapshot.data['games'],
      wins: snapshot.data['wins'],
      bestScore: snapshot.data['bestScore'],
      pushID: snapshot.data['pushID'],
    );
  }

  GameData _gameDataFromSnapshot(DocumentSnapshot snapshot){
    return GameData(
      turn: snapshot.data['turn'],
      uid: uid,
      bulls: snapshot.data['bulls'],
      cows: snapshot.data['cows'],
      guess: snapshot.data['guess'],
      name: snapshot.data['name'],
      receiverID: snapshot.data['receiverID'],
      receiverNumber: snapshot.data['receiverNumber'],
      senderID: snapshot.data['senderID'],
      senderNumber: snapshot.data['senderNumber'],
    );
  }

  // get player stream
  Stream<List<Player>> get player {
    return playerData.snapshots()
    .map(_playerListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return playerData.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

  // get game doc stream
  Stream<GameData> get gameData {
    return gamesData.document(uid).snapshots()
        .map(_gameDataFromSnapshot);
  }

}