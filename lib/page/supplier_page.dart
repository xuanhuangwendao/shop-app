//登录界面

import 'package:flutter/material.dart';
import 'package:shopapp/config/api.dart';
import 'package:shopapp/net/net_request.dart';
import 'package:shopapp/page/login_page.dart';
import 'package:shopapp/util/alert_dialog.dart';
import 'package:shopapp/util/file.dart';

class SupplierPage extends StatefulWidget {
  const SupplierPage({Key? key}) : super(key: key);

  @override
  State<SupplierPage> createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SupplierPage> {
  var title;
  List<String> _radioList = [];
  String _radioCheck = '水果';
  int categoryType = 1;


  @override
  void initState() {
    super.initState();
    title = TextEditingController();
    title.addListener(() {});
    _radioList.add("水果");
    _radioList.add("蔬菜");
    _radioList.add("肉蛋");
    _radioList.add("其他");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("添加供给"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              color: Colors.white,
              height: 300,
              child: InkWell(
                child: Image.network(
                  "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fku.90sjimg.com%2Felement_pic%2F01%2F37%2F90%2F79573c681a770e6.jpg&refer=http%3A%2F%2Fku.90sjimg.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1654595195&t=042d97694156e99c1ffcf1b81d089c2c",
                  height: 150,
                ),
                onTap: (){
                  savePic("1");
                  print("更换头像");
                },
              )

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
                    hintText: '标题',
                    border: InputBorder.none,
                  ),
                  controller: title,
                ),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: _radioList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(_radioList[index]),
                    leading: Radio(
                      value: _radioList[index],
                      groupValue: _radioCheck,
                      onChanged: (String? value) {
                        setState(() {
                          _radioCheck = value!;
                        });
                        categoryType = index + 1;
                      },
                    ),
                    onTap:(){
                      setState(() {
                        _radioCheck = _radioList[index];
                        categoryType = index + 1;
                      });
                    },
                  );
                }),
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
                        '发布',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            letterSpacing: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70),
                      )),
                  onTap: () {

                  },
                )),
          ]),
        ),
      ),
    );
  }
}
