//登录界面

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopapp/config/api.dart';
import 'package:shopapp/net/net_request.dart';
import 'package:shopapp/page/register_page.dart';
import 'package:shopapp/provider/provider.dart';
import 'package:shopapp/util/alert_dialog.dart';

import 'index_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var username;
  var password;

  @override
  void initState() {
    super.initState();
    username = TextEditingController();
    username.addListener(() {});
    password = TextEditingController();
    password.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 120,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: const <Widget>[
                Text(
                  '社区团购',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: const <Widget>[
                Text(
                  '登录',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 25,
                    height: 1.5,
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
              const SizedBox(height: 120),
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
                height: 20,
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
                          '登录',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              letterSpacing: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70),
                        )),
                    onTap: () {
                      print(username.text);
                      print(password.text);

                      Map<String, dynamic> params = {
                        "username": username.text,
                        "password": password.text
                      };
                      NetRequest()
                          .request(MyApi.LOGIN, params: params)
                          .then((response) async {
                        if (response.code == 200) {
                          print(response.model);
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString('token', response.model);

                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ChangeNotifierProvider<BottomNaviProvider>(
                                        create: (context) {
                                          BottomNaviProvider provider =
                                          BottomNaviProvider();
                                          provider.changeBottomNaviIndex(0);
                                          return provider;
                                        },
                                        child: Consumer<BottomNaviProvider>(
                                            builder: (_, provider, __) {
                                              return Container(child: IndexPage());
                                            }),
                                      )),
                                  (route) => false);
                        } else {
                          showAlertDialog(context, "登录失败", "");
                        }
                      }).catchError((error) {
                        print(error);
                        showAlertDialog(context, "", "error");
                      });
                    },
                  )),
              const SizedBox(
                height: 10,
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
                      Navigator.push(context,
                          new MaterialPageRoute(
                            builder: (BuildContext context) {
                              return  RegisterPage();
                            },
                          ));
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
