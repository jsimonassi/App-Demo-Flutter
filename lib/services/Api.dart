import 'dart:io';

import 'package:app_demo_flutter/constants/Messages.dart';
import 'package:app_demo_flutter/models/Lobby.dart';
import 'package:app_demo_flutter/models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class Api{

  static Future<AuthResult> registerUser(String email, String password) async {
    try{
      FirebaseAuth auth = FirebaseAuth.instance;
      AuthResult response = await auth.createUserWithEmailAndPassword(email: email, password: password);
      return response;
    }catch(e){
      print(e);
      String error = e != null? e.code : "";
      if(error.contains("ERROR_INVALID_EMAIL")){
        throw FormatException(AppMessages.ERROR_INVALID_EMAIL);
      }
      throw FormatException(AppMessages.DEFAULT_ERROR);
    }
  }
  
  static Future<void> updateUser(User newUser) async {
    try{
      // OSPermissionSubscriptionState status = await OneSignal.shared.getPermissionSubscriptionState();
      // if(status != null){
      //   newUser.pushId = status.subscriptionStatus.userId;
      // }
      return await Firestore.instance.collection("users")
          .document(newUser.uid)
          .setData(newUser.toMap());
    }catch(e){
      print("Deu erro! ${e.toString()}");
    }
  }

  static Future<String> updatePicture(String path, String filename) async {
    try{
      StorageUploadTask task = FirebaseStorage.instance.ref().child(filename).putFile(File(path));
      String downloadUrl = await (await task.onComplete).ref.getDownloadURL();
      return downloadUrl;
    }catch(e){

    }
  }

  static Future<User> loginWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult response = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if(response.user != null){
        return await getUser(response.user.uid);
      }
      return null;
    }catch(e){

    }
  }
  
  static Future<User> getUser(String uid) async {
    try{
      DocumentSnapshot userDoc = await Firestore.instance.collection("users").document(uid).get();
      Map<String,dynamic> infos = userDoc.data;
      if(infos == null){
        return null;
      }
      User user = User();
      user.name = infos["name"];
      user.urlImage = infos["urlImage"];
      user.uid = infos["uid"];
      user.email = infos["email"];
      user.pushId = infos["pushId"];
      return user;
    }catch(e){

    }
  }

  static Future<void> sendPushNotification(User user) async {
    try{
      if(user.pushId != null){
        return await OneSignal.shared.postNotification(
            OSCreateNotification(playerIds: [user.pushId],
                content: "DESCRIÇÃO DA NOTIFICAÇÃO",

            ));
      }
    }catch(e){

    }
  }

  static Future<void> updateLobby(Lobby lobby) async {
    try{
      return await Firestore.instance.collection("lobbys")
          .document(lobby.lobbyId)
          .setData(lobby.toMap());
    }catch(e){

    }
  }

  static Stream<DocumentSnapshot> createListenerForLobby(Lobby lobby){
    try{
      return Firestore.instance.collection("lobbys")
          .document(lobby.lobbyId).snapshots();
    }catch(e){

    }
  }

}