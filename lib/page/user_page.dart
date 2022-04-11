import 'package:flutter/material.dart';
import 'package:shopapp/config/api.dart';
import 'package:shopapp/util/file.dart';

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
        title: Text("我的 "),
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
Widget getUserHeader() {
  return Container(
    width: double.infinity,
    height: 140,
    decoration: const BoxDecoration(
      gradient: LinearGradient(colors: [Color(0xFFE43B3A), Color(0xFFF07157)]),
    ),
    child: Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 21, bottom: 20, top: 20),
          child: Row(
            children: <Widget>[
              InkWell(
                child: Image.network(
                  MyApi.LOCAL_URL + "/2b2d37a04ad345c2997550be1201017c.jpg",
                  height: 90,
                  width: 90,
                ),
                onTap: () {
                  uploadHeader("1");
                  print("更换头像");
                },
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Text(
                        "用户昵称",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xFFFDE5E3),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(2.0),
                          margin: EdgeInsets.all(2.0),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.red,
                            size: 12.0,
                          ))
                    ],
                  ),
                  const Text(
                    "⽤户名",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFFFABBB7),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
