import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/config/api.dart';
import 'package:shopapp/model/cart_response.dart';
import 'package:shopapp/net/net_request.dart';
import 'package:shopapp/provider/provider.dart';
import 'package:shopapp/util/alert_dialog.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CartProvider>(
        create: (context) {
          var provider = CartProvider();
          provider.loadCart();
          return provider;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("购物车"),
          ),
          body: Consumer<CartProvider>(
            builder: (_, provider, __) {
              if (provider.result == null ||
                  provider.result!.cartItemList!.isEmpty) {
                return Center(
                  child: Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Icon(Icons.shopping_cart),
                      ),
                      Text(
                        "购物车空空如也，去逛逛叭~",
                        style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                      )
                    ],
                  ),
                );
              } else {
                List<CartItemList> cartItemList =
                    provider.result!.cartItemList!;
                ;
                double amountAll = 0.0;
                bool allSelect = true;
                for (CartItemList item in cartItemList) {
                  if (provider.selectedMap[item.orderId]!) {
                    amountAll += item.price!;
                  } else {
                    allSelect = false;
                  }
                }
                if (allSelect) {
                  provider.selectedAll = true;
                }

                return Container(
                  child: Stack(
                    children: [
                      // 商品列表
                      ListView.builder(
                          itemCount: cartItemList.length,
                          itemBuilder: (context, index) {
                            CartItemList item = cartItemList[index];

                            bool selected = provider.selectedMap[item.orderId]!;

                            return Row(
                              children: [
                                InkWell(
                                  child:  Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: selected ? Icon(Icons.radio_button_checked): Icon(Icons.radio_button_off)
                                    // child: Icon(Icons.radio_button_off),
                                  ),
                                  onTap: () {
                                    provider.select(item.orderId!);
                                  },
                                ),
                                Expanded(
                                  child: Card(
                                    margin: EdgeInsets.all(8),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(right: 5),
                                          child: Image.network(
                                            item.picUrl!,
                                            height: 90,
                                            width: 90,
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding:
                                                    EdgeInsets.only(top: 5),
                                                child: Text(
                                                  item.title!,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    item.priceText!,
                                                    style: const TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16),
                                                  ),
                                                  Spacer(),
                                                  InkWell(
                                                    child: Row(
                                                      children: [
                                                        const Icon(Icons.add)
                                                      ],
                                                    ),
                                                    onTap: () {
                                                      Map<String, dynamic> params = {
                                                        "orderId": item.orderId,
                                                        "operation": "update",
                                                        "content": "1"
                                                      };

                                                      NetRequest()
                                                          .request(MyApi.MODIFY_ORDER, params: params)
                                                          .then((response) {
                                                        if (response.success) {

                                                        } else {
                                                          showAlertDialog(context, "", response.message);

                                                        }
                                                        provider.loadCart();

                                                      }).catchError((error) {
                                                        print(error);
                                                        provider.loadCart();
                                                        showAlertDialog(context, "", "操作失败，请重试~");

                                                      });
                                                    },
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    item.num!.toString(),
                                                    style: const TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    width:   10,
                                                  ),
                                                  InkWell(
                                                    child: Row(
                                                      children: [
                                                        const Icon(Icons
                                                            .horizontal_rule)
                                                      ],
                                                    ),
                                                    onTap: () {
                                                      if (item.num! < 0) {
                                                        showAlertDialog(context, "", "操作失败，请重试~");
                                                        provider.loadCart();
                                                        return;
                                                      }

                                                      Map<String, dynamic> params = {
                                                        "orderId": item.orderId,
                                                        "operation": "update",
                                                        "content": "-1"
                                                      };
                                                      NetRequest()
                                                          .request(MyApi.MODIFY_ORDER, params: params)
                                                          .then((response) {
                                                        if (response.success) {

                                                        } else {
                                                          showAlertDialog(context, "", response.message);

                                                        }
                                                        provider.loadCart();

                                                      }).catchError((error) {
                                                        print(error);
                                                        provider.loadCart();

                                                        showAlertDialog(context, "", "操作失败，请重试~");

                                                      });
                                                    },
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                          }),

                      // 底部菜单
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 50,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                top: BorderSide(width: 1, color: Colors.grey),
                                bottom:
                                    BorderSide(width: 1, color: Colors.grey),
                              )),
                          child: Row(
                            children: [
                              InkWell(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  child: provider.selectedAll ? Icon(Icons.radio_button_checked) : Icon(Icons.radio_button_off),
                                ),
                                onTap: () {
                                  provider.selectAll();
                                  //选中
                                },
                              ),
                              const Text(
                                "全选",
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "合计",
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                  "￥" + amountAll.toStringAsFixed(2),
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                              ),
                              Spacer(),

                              InkWell(
                                child: Container(
                                  width: 120,
                                  height: double.infinity,
                                  color: Colors.red,
                                  child: const Center(
                                    child: Text(
                                      "去结算",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  provider.loadCart();
                                },
                              ),

                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
            },
          ),
        ));
  }
}
