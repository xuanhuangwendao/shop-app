
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, String title, String text) {
  //设置按钮
  Widget okButton = FlatButton(
      child: Text("确定"),
      onPressed: () {
        Navigator.pop(context);
      });

  //设置对话框
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(text),
    actions: [okButton],
  );

  //显示对话框
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}