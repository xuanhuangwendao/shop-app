import 'package:flutter/services.dart';
import 'package:shopapp/config/api.dart';
import 'package:shopapp/model/detail_response.dart';
import 'package:shopapp/net/net_request.dart';
import 'package:shopapp/page/index_page.dart';
import 'package:shopapp/provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SellerDetailPage extends StatefulWidget {
  final String id;
  const SellerDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _SellerDetailPageState createState() => _SellerDetailPageState();
}

class _SellerDetailPageState extends State<SellerDetailPage> {
  int itemNum = 1;
  var price;
  var desc;

  @override
  void initState() {
    super.initState();
    price = TextEditingController();
    price.addListener(() {});
    desc = TextEditingController();
    desc.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("购物"),
      ),
      body: Container(
        child: Consumer<ProductDetailProvider>(
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
                    Text(provider.errorMsg!),
                    OutlineButton(
                      onPressed: () {
                        // provider.loadProduct(id: widget.id);
                      },
                      child: const Text("刷新"),
                    )
                  ],
                ),
              );
            }
            // 获取model
            DetailResponse result = provider.model!;
            return Stack(
              children: [
                // 主题内容
                ListView(
                  children: [
                    // 轮播图
                    Container(
                      color: Colors.white,
                      height: 400,
                      child: Image.network(
                        result.picUrl!,
                        height: 150,
                      ),
                    ),
                    // 标题
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        result.title!,
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),

                    Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(
                                  width: 1, color: Color(0xFFE8E8ED)),
                              bottom: BorderSide(
                                  width: 1, color: Color(0xFFE8E8ED)),
                            )),
                        child: Row(
                          children: [
                            const Text(
                              "拼团数量设置：",
                              style: TextStyle(color: Color(0xff999999)),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                                child: Text(itemNum.toString() + "件"),
                              ),
                            ),

                            InkWell(
                              child: Row(
                                children: [const Icon(Icons.add)],
                              ),
                              onTap: () {
                                this.setState(() {
                                  itemNum++;
                                }); // 选择商品个数
                              },
                            ),
                            const SizedBox(
                              width: 40.0,
                            ),
                            InkWell(
                              child: Row(
                                children: [const Icon(Icons.horizontal_rule)],
                              ),
                              onTap: () {
                                if (itemNum <= 1) {
                                  return;
                                }
                                this.setState(() {
                                  itemNum--;
                                }); // 选择商品个数
                              },
                            ),
                          ],
                        )),

                    // 商品件数
                    Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(
                                  width: 1, color: Color(0xFFE8E8ED)),
                              bottom: BorderSide(
                                  width: 1, color: Color(0xFFE8E8ED)),
                            )),
                        child: Row(
                          children: [
                            const Text(
                              "商品单价设置：",
                              style: TextStyle(color: Color(0xff999999)),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: TextField(
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: '请输入价格',
                                  border: InputBorder.none,
                                ),
                                controller: price,
                              ),
                            ),
                          ],
                        )),
                    // 商品件数
                    Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(
                                  width: 1, color: Color(0xFFE8E8ED)),
                              bottom: BorderSide(
                                  width: 1, color: Color(0xFFE8E8ED)),
                            )),
                        child: Row(
                          children: [
                            const Text(
                              "商品描述设置：",
                              style: TextStyle(color: Color(0xff999999)),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: TextField(
                                maxLines: 1,
                                decoration: const InputDecoration(
                                  hintText: '请输入描述',
                                  border: InputBorder.none,
                                ),
                                controller: desc,
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 60.0,
                    ),
                  ],
                ),

                // 底部菜单
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                width: 1, color: Color(0xFFE8E8ED)))),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            child: Container(
                              height: 60,
                              color: Colors.red,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text("开团  ",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                            onTap: () {

                              Map<String, dynamic> request = {
                                "goodsId": widget.id,
                                "num": itemNum,
                                "price": price.text,
                                "desc": desc.text
                              };
                              NetRequest()
                                  .request(MyApi.CREATE_SHOP, data: request, method: "post")
                                  .then((response) {
                                if (response.code == 200) {
                                  showAlertDialog(context, "开团成功", "");
                                } else {
                                  showAlertDialog(context, "开团失败", "");
                                }
                              }).catchError((error) {
                                print(error);
                                showAlertDialog(context, "开团失败", "");
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

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
}
