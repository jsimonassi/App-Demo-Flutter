import 'package:flutter/material.dart';

class Loading{

  static enableLoading(BuildContext context){
    showDialog(context: context,
        builder: (_) => LoadingView());
  }

  static disableLoading(BuildContext context){
    if(Navigator.canPop(context)) Navigator.pop(context);
  }

}

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(child: Container()),
        CircularProgressIndicator(),
        Expanded(child: Container()),
      ],
    );
  }
}
