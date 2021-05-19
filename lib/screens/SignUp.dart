import 'dart:io';
import 'package:app_demo_flutter/components/Loading.dart';
import 'package:app_demo_flutter/components/ModalDialog.dart';
import 'package:app_demo_flutter/components/RedButton.dart';
import 'package:app_demo_flutter/constants/Colors.dart';
import 'package:app_demo_flutter/constants/Messages.dart';
import 'package:app_demo_flutter/models/User.dart';
import 'package:app_demo_flutter/services/Api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _networkImageUrl = "";
  String _localImageUrl = "";


  bool validateInfos(){
    return _emailController.text.isNotEmpty &&
        _nameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  createAccount() async{
    try{
      Loading.enableLoading(context);
      if(validateInfos()){
        AuthResult response = await Api.registerUser(_emailController.text, _passwordController.text); //Auth
        String downloadUrl = _localImageUrl.isNotEmpty?
        await Api.updatePicture(_localImageUrl, _emailController.text):
        _localImageUrl;
        if(response.user != null){
          User newUser = User();
          newUser.uid = response.user.uid;
          newUser.name = _nameController.text;
          newUser.email = _emailController.text;
          newUser.urlImage = downloadUrl;
          await Api.updateUser(newUser);
        }
        Loading.disableLoading(context);
        showDialog(context: context,
            builder: (_) => ModalDialog("Conta criada!", "", "OK",
                    () =>{if(Navigator.canPop(context)) Navigator.pop(context)}));
      }
    }catch(e){
      Loading.disableLoading(context);
      showDialog(context: context,
          builder: (_) => ModalDialog("Deu velha!", e.message, "OK",
                  () =>{if(Navigator.canPop(context)) Navigator.pop(context)}));
    }
  }

  pickerImage() async {
    PickedFile selectedImage = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _localImageUrl = selectedImage.path;
    });
  }

  getProfileImage(){
    if(_networkImageUrl.isNotEmpty){
      return NetworkImage(_networkImageUrl);
    }else if(_localImageUrl.isNotEmpty){
      return FileImage(File(_localImageUrl));
    }
    return ExactAssetImage("assets/images/profile-icon.png");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
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
              Container(
                height: size.height * 0.1,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  AppMessages.NEW_ACCOUNT_TITLE,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              GestureDetector(
                onTap: () => {pickerImage()},
                child: CircleAvatar(
                  maxRadius: 80,
                  backgroundColor: Colors.black,
                  backgroundImage: getProfileImage(),
                ),
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
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
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
                    keyboardType: TextInputType.text,
                    controller: _nameController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                        ),
                        labelText: AppMessages.NAME_PLACEHOLDER,
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
                    keyboardType: TextInputType.text,
                    controller: _passwordController,
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
              RedButton(AppMessages.NEW_ACCOUNT_TITLE, () {createAccount();}),
            ],
          ),
        ),
      ),
    );
  }
}
