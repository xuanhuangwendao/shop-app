import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/config/api.dart';
import 'package:shopapp/model/user_info_response.dart';
import 'package:shopapp/provider/provider.dart';
import 'package:shopapp/util/file.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserInfoProvider>(
      create: (context){
        var provider = UserInfoProvider();
        provider.loadUserInfo();
        return provider;
      },
      child:  Scaffold(
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
                  getUserHeader(result, provider)
                ],
              ),
            );
          },
        ),

      )
    );
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
                        userInfo.nickName!,
                        style: TextStyle(
                          fontSize: 20.0,
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
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    userInfo.sign!,
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
