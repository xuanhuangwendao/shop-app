import 'package:shopapp/model/recommend_response.dart';
import 'package:shopapp/page/detail_page.dart';
import 'package:shopapp/provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageProvider>(
      create: (context) {
        var provider = HomePageProvider();
        provider.loadHomePageData();
        return provider;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("推荐"),
          ),
          body: Container(
            color: const Color(0xfff4f4f4),
            child: Consumer<HomePageProvider>(
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
                            provider.loadHomePageData();
                          },
                          child: const Text("刷新"),
                        )
                      ],
                    ),
                  );
                }
                List<ItemList> itemList = provider.result!.itemList!;
                double listSize = itemList.length / 2;
                int size = listSize.ceil();
                print(size);

                return ListView.builder(
                    itemCount: size,
                    itemBuilder: (context, index) {
                      ItemList item1 = itemList[index * 2];
                      if (2 * index + 1 < itemList.length) {
                        ItemList item2 = itemList[index * 2 + 1];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(child: buildItem(item1)),
                            Expanded(child: buildItem(item2)),
                          ],
                        );
                      } else {
                        return Row(
                          children: [
                            Expanded(child: buildItem(item1)),
                            Expanded(child: SizedBox())
                          ],
                        );
                      }
                    });

                return ListView(
                  children: [Text(itemList[0].title!)],
                );
              },
            ),
          )),
    );
  }

  Container buildItem(ItemList item) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          border: Border.all(width: 1, color: Colors.black),
        ),
        child: InkWell(
          child: Column(children: [
            Image.network(
              item.picUrl!,
              height: 150,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  item.title!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "￥${item.price}",
                  style:
                      const TextStyle(fontSize: 18.0, color: Color(0xFFe93b3d)),
                ),
                Text(
                  "库存: ${item.stock}",
                  style:
                      const TextStyle(fontSize: 13.0, color: Color(0xFF999999)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "卖家: ${item.sellerNick}",
                  style:
                      const TextStyle(fontSize: 13.0, color: Color(0xFF999999)),
                ),
                Text(
                  " ${item.gmtCreate?.split("T")[0]}",
                  style:
                      const TextStyle(fontSize: 13.0, color: Color(0xFF999999)),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
          ]),
          onTap: () {
            print("click item: " + item.title!);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ChangeNotifierProvider<ProductDetailProvider>(
                      create: (context) {
                        ProductDetailProvider provider =
                            ProductDetailProvider();
                        return provider;
                      },
                      child: Consumer<ProductDetailProvider>(
                          builder: (_, provider, __) {
                        provider.loadProduct(item.id.toString());
                        return Container(
                            child: DetailPage( id: item.id.toString())
                        );
                      }),
                    )));
          },
        ));
  }
}
