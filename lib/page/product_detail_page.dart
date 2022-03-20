import 'package:shopapp/model/product_detail_model.dart';
import 'package:shopapp/provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  final String id;
  const ProductDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("京东"),
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
            ProductDetailModel? model = provider.model!;
            String? baitiaoTitle = "【白条支付】首单优惠";
            for (var item in model.baitiao!) {
              if (item.select == true) {
                baitiaoTitle = item.desc!;
              }
            }
            return Stack(
              children: [
                // 主题内容
                ListView(

                  children: [
                    // 轮播图
                    Container(
                      color: Colors.white,
                      height: 400,
                      child: Swiper(
                        itemCount: model.partData!.loopImgUrl!.length,
                        pagination: const SwiperPagination(),
                        itemBuilder: (BuildContext context, int index) {
                          return Image.asset(
                            "assets${model.partData!.loopImgUrl![index]}",
                            width: double.infinity,
                            height: 400,
                            fit: BoxFit.fill,
                          );
                        },
                      ),
                    ),
                    // 标题
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        model.partData!.title!,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    // 价格
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "￥${model.partData!.price!}",
                        style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.red,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    // 白条支付
                    Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(
                            width: 1,
                            color: Color(0xFFE8E8ED)
                          ),
                          bottom: BorderSide(
                              width: 1,
                              color: Color(0xFFE8E8ED)
                          ),
                        )
                      ),
                      child: InkWell(
                        child: Row(
                          children: [
                            const Text(
                              "支付",
                              style: TextStyle(
                                color: Color(0xff999999)
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                                child: Text(baitiaoTitle!),
                              ),
                            ),
                          const Icon(Icons.more_horiz_outlined)
                          ],
                        ),
                        onTap: (){
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
                                width: 1,
                                color: Color(0xFFE8E8ED)
                            ),
                            bottom: BorderSide(
                                width: 1,
                                color: Color(0xFFE8E8ED)
                            ),
                          )
                      ),
                      child: InkWell(
                        child: Row(
                          children: [
                            const Text(
                              "已选择",
                              style: TextStyle(
                                  color: Color(0xff999999)
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                                child: Text("${model.partData!.count}件"),
                              ),
                            ),
                            const Icon(Icons.more_horiz_outlined)
                          ],
                        ),
                        onTap: (){
                          // 选择商品个数
                        },
                      ),
                    ),
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
