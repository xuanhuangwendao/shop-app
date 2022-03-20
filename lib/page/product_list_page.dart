import 'package:shopapp/model/product_info_model.dart';
import 'package:shopapp/page/product_detail_page.dart';
import 'package:shopapp/provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  final String title;
  const ProductListPage({Key? key, required this.title}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: const Color(0xFFF7f7f7),
        child: Consumer<ProductListProvider>(
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
                    OutlinedButton(
                      onPressed: () {
                        provider.loadProductList();
                      },
                      child: const Text("刷新"),
                    )
                  ],
                ),
              );
            }
            return buildItemList(provider);
          },
        ),
      ),
    );
  }

  ListView buildItemList(ProductListProvider provider) {
    return ListView.builder(
              itemCount: provider.list.length,
              itemBuilder: (context, index) {
                ProductInfoModel model = provider.list[index];

                return InkWell(
                  child: buildProductItem(model),
                  onTap: (){
                    //跳转商品页面
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ChangeNotifierProvider<ProductDetailProvider>(
                              create: (context) {
                                ProductDetailProvider provider = ProductDetailProvider();
                                provider.loadProduct(model.id!);
                                return provider;
                              },
                              child: Consumer<ProductDetailProvider>(
                                  builder: (_, provider, __) {
                                    return Container(
                                        child: ProductDetailPage( id: model.id!));
                                  }),
                            )));
                  },
                );
              });
  }

  Row buildProductItem(ProductInfoModel model) {
    return Row(
      children: [
        Image.asset("assets${model.cover}", width: 95, height: 120),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  model.title!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "￥${model.price}",
                  style: const TextStyle(fontSize: 16.0, color: Color(0xFFe93b3d)),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    Text(
                      "${model.comment}条评价",
                      style:
                          const TextStyle(fontSize: 13.0, color: Color(0xFF999999)),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      "好评率${model.rate}",
                      style:
                          const TextStyle(fontSize: 13.0, color: Color(0xFF999999)),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10.0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
