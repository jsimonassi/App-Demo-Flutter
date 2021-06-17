import 'package:app_demo_flutter/models/Lobby.dart';
import 'package:app_demo_flutter/services/Api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LobbyPage extends StatefulWidget {
  Lobby _lobby;

  LobbyPage(Lobby lobby){
    this._lobby = lobby;
  }
  @override
  _LobbyPageState createState() => _LobbyPageState(this._lobby);
}

class _LobbyPageState extends State<LobbyPage> {

  Lobby _lobby;
  Stream<DocumentSnapshot> stream;

  _LobbyPageState(Lobby lobby){
    this._lobby = lobby;
  }

  @override
  void initState() {
    listenDoc();
    super.initState();
  }

  listenDoc(){
    stream = Api.createListenerForLobby(this._lobby);
    if(mounted){
      stream.listen((obj) {
        print(obj);
        if(obj.data != null){
          setState(() {
            this._lobby.player1 = obj.data["player1"];
            this._lobby.player2 = obj.data["player2"];
          });
        }
      });
    }
  }

  @override
  void dispose(){
    stream = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Center(
          child: Column(
            children: <Widget>[
              Text(this._lobby.lobbyId != null? this._lobby.lobbyId : "NULL"),
              Text(this._lobby.player1  != null? this._lobby.player1 : "NULL"),
              Text(this._lobby.player2  != null? this._lobby.player2 : "NULL"),
            ],
          ),
        ),
      ),
    );
  }
}
