import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/config/api.dart';
import 'package:shopapp/model/cart_response.dart';
import 'package:shopapp/model/user_info_response.dart';
import 'package:shopapp/net/net_request.dart';
import 'package:shopapp/provider/provider.dart';
import 'package:shopapp/util/alert_dialog.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
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
            title: Text("钱包"),
          ),
          body: Consumer<UserInfoProvider>(builder: (_, provider, __) {
            if (provider.isLoading) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            UserInfoResponse userInfo = provider.result!;
            return Column(
              children: [
                walletInfo(context, userInfo),
              ],
            );
          }),
        ));
  }
}

Widget walletInfo(BuildContext context, UserInfoResponse userInfo) {
  return Container(
      child: InkWell(
    child: Card(
      color: Colors.white,
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 20,
                height: 40,
              ),
              Text(
                "账户余额:",
                style: TextStyle(fontSize: 18),
              ),
              Spacer(),
              Text(
                "￥" + userInfo.balance!,
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
              SizedBox(
                width: 20,
                height: 40,
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 20,
                height: 40,
              ),
              Text(
                "收货地址:",
                style: TextStyle(fontSize: 18),
              ),
              Spacer(),
              Text(
                userInfo.address!,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                width: 20,
                height: 40,
              ),
            ],
          ),
        ],
      ),
    ),
    onTap: () {},
  ));
}
