import 'package:shopapp/model/summary_response.dart';
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
  int size = 1;

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
                                child: Text(size.toString() + "件"),
                              ),
                            ),
                            InkWell(
                              child: Row(
                                children: [
                                  const Icon(Icons.add)
                                ],
                              ),
                              onTap: () {
                                this.setState(() {
                                  size++;
                                });// 选择商品个数
                              },
                            ),
                            const SizedBox(
                              width: 40.0,
                            ),
                            InkWell(
                              child: Row(
                                children: [
                                  const Icon(Icons.horizontal_rule)
                                ],
                              ),
                              onTap: () {
                                if (size == 0) {
                                  return;
                                }
                                this.setState(() {
                                  size--;
                                });// 选择商品个数
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
                              //购物车
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
}
