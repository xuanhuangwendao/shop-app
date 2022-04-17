import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/config/api.dart';
import 'package:shopapp/model/user_info_response.dart';
import 'package:shopapp/page/register_page.dart';
import 'package:shopapp/page/wallet_page.dart';
import 'package:shopapp/provider/provider.dart';
import 'package:shopapp/util/file.dart';

import 'login_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserInfoProvider>(
        create: (context) {
          var provider = UserInfoProvider();
          provider.loadUserInfo();
          return provider;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("我的 "),
          ),
          body: Consumer<UserInfoProvider>(
            builder: (_, provider, __) {
              if (provider.isLoading) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }
              if (provider.isError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlineButton(
                        onPressed: () {
                          provider.loadUserInfo();
                        },
                        child: const Text("刷新"),
                      )
                    ],
                  ),
                );
              }
              UserInfoResponse result = provider.result!;
              return Container(
                child: ListView(
                  children: [
                    getUserHeader(result, provider),
                    const SizedBox(
                      height: 10,
                    ),
                    // info(context),
                    wallet(context),
                    // seller(context),
                    version(context),
                    forOur(context),
                    logout(context)

                  ],
                ),
              );
            },
          ),
        ));
  }
}

//顶部用户信息
Widget getUserHeader(UserInfoResponse userInfo, UserInfoProvider provider) {
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
                  userInfo.profilePic!,
                  // "http://192.168.31.42:7002/img/3935b4c18b15431ba6a225e0541a1fd3.jpg",
                  height: 90,
                  width: 90,
                  fit: BoxFit.cover,

                ),
                onTap: () {
                  uploadHeader("1");
                  print("更换头像");
                  provider.loadUserInfo();
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
                      Text(
                        "昵称: " + userInfo.nickName!,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Color(0xFFFDE5E3),
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "个人简介: " + userInfo.sign!,
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

Widget info(BuildContext context) {
  return Container(
      child: InkWell(
        child: Card(
          color: Colors.white70,
          margin: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              SizedBox(
                width: 20,
                height: 40,
              ),
              Text(
                "个人信息",
                style: TextStyle(fontSize: 20),
              ),
              Spacer(),
              Icon(Icons.keyboard_arrow_right)
            ],
          ),
        ),
        onTap: () {
          // todo 修改信息
        },
      )
  );
}

Widget wallet(BuildContext context) {
  return Container(
    child: InkWell(
      child: Card(
        color: Colors.white70,
        margin: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SizedBox(
              width: 20,
              height: 40,
            ),
            Text(
              "钱包",
              style: TextStyle(fontSize: 20),
            ),
            Spacer(),
            Icon(Icons.keyboard_arrow_right)
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                ChangeNotifierProvider<OrderProvider>(
                  create: (context) {
                    OrderProvider provider =
                    OrderProvider();
                    return provider;
                  },
                  child: Consumer<OrderProvider>(
                      builder: (_, provider, __) {
                        return Container(
                            child: WalletPage()
                        );
                      }),
                )));
      },
    )
  );
}

Widget seller(BuildContext context) {
  return Container(
      child: InkWell(
        child: Card(
          color: Colors.white70,
          margin: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              SizedBox(
                width: 20,
                height: 40,
              ),
              Text(
                "我是团长",
                style: TextStyle(fontSize: 20),
              ),
              Spacer(),
              Icon(Icons.keyboard_arrow_right)
            ],
          ),
        ),
        onTap: () {
          // todo 跳转至钱包
        },
      )
  );
}

Widget logout(BuildContext context) {
  return Container(
      child: InkWell(
        child: Card(
          color: Colors.red,
          margin: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              SizedBox(
                width: 20,
                height: 40,
              ),
              Text(
                "退出登录",
                style: TextStyle(fontSize: 20),
              ),
              Spacer(),
              Icon(Icons.keyboard_arrow_right)
            ],
          ),
        ),
        onTap: () {
          Navigator.push(context,
              new MaterialPageRoute(
                builder: (BuildContext context) {
                  return  LoginPage();
                },
              ));
        },
      )
  );
}

Widget version(BuildContext context) {
  return Container(
      child: InkWell(
        child: Card(
          color: Colors.white70,
          margin: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              SizedBox(
                width: 20,
                height: 40,
              ),
              Text(
                "版本",
                style: TextStyle(fontSize: 20),
              ),
              Spacer(),
              Icon(Icons.keyboard_arrow_right)
            ],
          ),
        ),
        onTap: () {
          // todo 修改信息
        },
      )
  );
}

Widget forOur(BuildContext context) {
  return Container(
      child: InkWell(
        child: Card(
          color: Colors.white70,
          margin: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              SizedBox(
                width: 20,
                height: 40,
              ),
              Text(
                "关于我们",
                style: TextStyle(fontSize: 20),
              ),
              Spacer(),
              Icon(Icons.keyboard_arrow_right)
            ],
          ),
        ),
        onTap: () {
          // todo 修改信息
        },
      )
  );
}