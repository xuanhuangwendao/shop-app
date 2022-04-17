import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/config/api.dart';
import 'package:shopapp/model/cart_response.dart';
import 'package:shopapp/net/net_request.dart';
import 'package:shopapp/provider/provider.dart';
import 'package:shopapp/util/alert_dialog.dart';

class HistoryOrderPage extends StatefulWidget {
  const HistoryOrderPage({Key? key}) : super(key: key);

  @override
  _HistoryOrderPageState createState() => _HistoryOrderPageState();
}

class _HistoryOrderPageState extends State<HistoryOrderPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OrderProvider>(
        create: (context) {
          var provider = OrderProvider();
          provider.loadOrder();
          return provider;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("历史订单"),
          ),
          body: Consumer<OrderProvider>(
            builder: (_, provider, __) {
              if (provider.isLoading) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }
              if (provider.result == null ||
                  provider.result!.cartItemList!.isEmpty) {
                return Column(
                  children: [ blankOrder()],
                );
              } else {
                List<CartItemList> cartItemList =
                provider.result!.cartItemList!;
                return Column(
                  children: [

                    orderList(cartItemList)
                  ],
                );
              }
            },
          ),
        ));
  }
}

Widget blankOrder() {
  return Center(
    child: Column(
      children: const [
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: Icon(Icons.shopping_cart),
        ),
        Text(
          "您没有订单记录",
          style: TextStyle(fontSize: 16, color: Colors.blueGrey),
        )
      ],
    ),
  );
}

Widget orderList(List<CartItemList> cartItemList) {
  return Expanded(
    child:
    // 商品列表
    ListView.builder(
        itemCount: cartItemList.length,
        itemBuilder: (context, index) {
          CartItemList item = cartItemList[index];
          return Row(
            children: [
              Expanded(
                child: Card(
                  margin: EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    item.title!,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],

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
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                                Spacer(),
                                Text(
                                  item.status!,
                                  style: const TextStyle(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20),
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
  );
}
