import 'dart:io';

import 'package:app_demo_flutter/constants/Messages.dart';
import 'package:app_demo_flutter/models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
      return await Firestore.instance.collection("users")
          .document(newUser.uid)
          .setData(newUser.toMap());
    }catch(e){

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

}