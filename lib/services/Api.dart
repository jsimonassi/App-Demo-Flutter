import 'package:app_demo_flutter/constants/Messages.dart';
import 'package:app_demo_flutter/models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Api{

  static Future<AuthResult> registerUser(String email, String password) async {
    try{
      AuthResult response = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return response;
    }catch(e){
      String error = e.errorCode != null ? e.errorCode : "";
      if(error.isNotEmpty && error.contains("ERROR_EMAIL_ALREADY_IN_USE")){
        throw FormatException(AppMessages.ERROR_EMAIL_IN_USE);
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
}