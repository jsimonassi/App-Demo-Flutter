import 'dart:convert';
import 'package:app_demo_flutter/components/RedButton.dart';
import 'package:app_demo_flutter/constants/Colors.dart';
import 'package:app_demo_flutter/constants/Messages.dart';
import 'package:app_demo_flutter/models/User.dart';
import 'package:app_demo_flutter/screens/MenuNavigation.dart';
import 'package:app_demo_flutter/services/Api.dart';
import 'package:app_demo_flutter/storage/CurrentUser.dart';
import 'package:app_demo_flutter/storage/Storage.dart';
import 'package:flutter/material.dart';
import 'SignUp.dart';
import 'Home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState(){
    getLastUser();
    super.initState();
  }

  getLastUser() async {
    String lastUser = await Storage.retrieve("last_user");
    if(lastUser == null) return;
    Map<String, dynamic> mapUser = jsonDecode(lastUser);
    CurrentUser.user = User().mapToUser(mapUser);
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (BuildContext context) => MenuNavigation()), (route) => false);
  }

  goToSignUp(){
    Navigator.push(context,
    MaterialPageRoute(builder: (BuildContext context) => SignUp()));
  }

  initLoginFlux() async {
    try{
      if(validateInfos()){
        User user = await Api.loginWithEmailAndPassword(_emailController.text, _passwordController.text);
        if(user != null){
          CurrentUser.user = user;
          await Storage.save("last_user", CurrentUser.user.toMap());
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (BuildContext context) => MenuNavigation()), (route) => false);
        }
        //Todo: Exibir modal de erro
      }
    }catch(e){

    }
  }

  bool validateInfos(){
    return _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.only(
            left: size.width * 0.05,
            right: size.width * 0.05,
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.BACKGROUND_1,
              AppColors.BACKGROUND_2,
            ],
          )),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 250,
                width: 250,
                child: Image.asset("assets/images/logo.png"),
              ),
              Container(
                  decoration: BoxDecoration(
                    color: AppColors.WHITE_LOW_OPACITY,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                      ),
                      labelText: AppMessages.EMAIL_PLACEHOLDER,
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                      )
                    ),
                    style: TextStyle(
                      color: Colors.white
                    ),
                  )
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Container(
                  decoration: BoxDecoration(
                    color: AppColors.WHITE_LOW_OPACITY,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                      ),
                      labelText: AppMessages.PASSWORD_PLACEHOLDER,
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                      )
                    ),
                    style: TextStyle(
                      color: Colors.white
                    ),
                  )
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              RedButton("ENTRAR", () => initLoginFlux()),
              Container(
                child: TextButton(
                  onPressed: () {goToSignUp();},
                  child: Text(
                    AppMessages.NEW_ACCOUNT,
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
