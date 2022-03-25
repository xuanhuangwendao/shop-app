import 'package:shopapp/config/api.dart';
import 'package:shopapp/model/summary_response.dart';
import 'package:shopapp/net/net_request.dart';
import 'package:shopapp/page/cart_page.dart';
import 'package:shopapp/page/home_page.dart';
import 'package:shopapp/page/index_page.dart';
import 'package:shopapp/provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final String id;
  const DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int itemNum = 1;

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
            DetailResponse result = provider.result!;
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
                      color: Colors.white,
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        result.desc!,
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    // 价格
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "￥${result.price!}",
                        style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    // 白条支付
                    Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(width: 1, color: Color(0xFFE8E8ED)),
                            bottom:
                                BorderSide(width: 1, color: Color(0xFFE8E8ED)),
                          )),
                      child: InkWell(
                        child: Row(
                          children: [
                            const Text(
                              "支付方式",
                              style: TextStyle(color: Color(0xff999999)),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                                child: Text("钱包"),
                              ),
                            ),
                            const Icon(Icons.more_horiz_outlined)
                          ],
                        ),
                        onTap: () {
                          // 选择支付方式
                        },
                      ),
                    ),
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
                              "已选择",
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
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.shopping_cart),
                                  Text(
                                    "购物车",
                                    style: TextStyle(fontSize: 13.0),
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              print("goto cart");
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChangeNotifierProvider<
                                              BottomNaviProvider>(
                                            create: (context) {
                                              BottomNaviProvider provider =
                                                  BottomNaviProvider();
                                              provider.changeBottomNaviIndex(1);
                                              return provider;
                                            },
                                            child: Consumer<BottomNaviProvider>(
                                                builder: (_, provider, __) {
                                              return Container(
                                                  child: IndexPage());
                                            }),
                                          )),
                                  (route) => false);
                            },
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Container(
                              height: 60,
                              color: Colors.red,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text("加入购物车",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                            onTap: () {
                              //购物车
                              NetRequest()
                                  .request(MyApi.PLACE_ORDER, params: {"itemId": result.id, "num": itemNum})
                                  .then((response) {
                                    if (response.success) {
                                      showAlertDialog(
                                          context, "购物车", "添加成功，请在购物车中查看~");
                                    } else {
                                      showAlertDialog(context, "购物车", response.message);

                                    }
                              }).catchError((error) {
                                print(error);
                                showAlertDialog(context, "购物车", "添加失败，请重试~");
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
