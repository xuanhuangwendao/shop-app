import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的  "),
      ),
      body: Container(
        child: ListView(
          children: [
            getUserHeader()


          ],
        ),


      ),
    );
  }
}
//顶部用户信息
Widget getUserHeader(){
  return Container(
    width: double.infinity,
    height: 140,
    decoration: BoxDecoration(
      gradient:const LinearGradient(
          colors:[Color(0xFFE43B3A), Color(0xFFF07157)]
      ),
    ),
  );
}