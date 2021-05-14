import 'package:app_demo_flutter/constants/Colors.dart';
import 'package:flutter/material.dart';

class RedButton extends StatelessWidget {

  String title;
  VoidCallback action;

  RedButton(this.title, this.action);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.RED_BUTTON_COLOR,
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      child: TextButton(
        onPressed: this.action,
        child: Text(
          this.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18
          ),
        ),
      ),
    );
  }


}
