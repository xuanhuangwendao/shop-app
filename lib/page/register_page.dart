//登录界面

import 'package:flutter/material.dart';
import 'package:shopapp/config/api.dart';
import 'package:shopapp/net/net_request.dart';
import 'package:shopapp/page/login_page.dart';
import 'package:shopapp/util/alert_dialog.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var username;
  var password;
  var password2;
  var nickName;
  var address;

  @override
  void initState() {
    super.initState();
    username = TextEditingController();
    username.addListener(() {});
    password = TextEditingController();
    password.addListener(() {});
    password2 = TextEditingController();
    password2.addListener(() {});
    nickName = TextEditingController();
    nickName.addListener(() {});
    address = TextEditingController();
    address.addListener(() {});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("注册"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 2, 8, 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.black12,
                ),
                alignment: Alignment.center,
                child: TextField(
                  maxLines: 1,
                  decoration: const InputDecoration(
                    hintText: '用户名',
                    border: InputBorder.none,
                  ),
                  controller: username,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 2, 8, 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.black12,
                ),
                alignment: Alignment.center,
                child: TextField(
                  maxLines: 1,
                  decoration: const InputDecoration(
                    hintText: '密码',
                    border: InputBorder.none,
                  ),
                  obscureText: true,
                  controller: password,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            SizedBox(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 2, 8, 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.black12,
                ),
                alignment: Alignment.center,
                child: TextField(
                  maxLines: 1,
                  decoration: const InputDecoration(
                    hintText: '请再次输入密码',
                    border: InputBorder.none,
                  ),
                  obscureText: true,
                  controller: password2,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 2, 8, 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.black12,
                ),
                alignment: Alignment.center,
                child: TextField(
                  maxLines: 1,
                  decoration: const InputDecoration(
                    hintText: '用户昵称',
                    border: InputBorder.none,
                  ),
                  controller: nickName,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 2, 8, 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.black12,
                ),
                alignment: Alignment.center,
                child: TextField(
                  maxLines: 1,
                  decoration: const InputDecoration(
                    hintText: '住址',
                    border: InputBorder.none,
                  ),
                  controller: address,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
                child: InkWell(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(2, 15, 2, 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.deepOrangeAccent,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        '注册',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            letterSpacing: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70),
                      )),
                  onTap: () {

                    Map<String, dynamic> data = {
                      "username": username.text,
                      "password": password.text,
                      "nickname": nickName.text,
                      "address": address.text
                    };
                    NetRequest()
                        .request(MyApi.REGISTER, data: data, method: "post")
                        .then((response) {
                      if (response.code == 200) {
                        showAlertDialog(context, "注册成功", "");
                        Navigator.push(context,
                            new MaterialPageRoute(
                              builder: (BuildContext context) {
                                return  LoginPage();
                              },
                            ));

                      } else {
                        showAlertDialog(context, "注册失败", "");
                      }
                    }).catchError((error) {
                      print(error);
                      showAlertDialog(context, "注册失败", "");
                    });

                  },
                )),
          ]),
        ),
      ),
    );
  }
}
