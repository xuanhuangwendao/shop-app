import 'package:shopapp/model/home_page_model.dart';
import 'package:shopapp/provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
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
            title: const Text("首页"),
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
                        Text(provider.errorMsg!),
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
                HomePageModel model = provider.model!;
                return ListView(
                  children: [
                    // 轮播图
                    buildAspectRatio(model),
                    // 分类
                    buildLogos(model),
                    // 掌上秒杀
                    buildMSHeaderContainer(),
                    // 秒杀商品
                    buildMSBodyContainer(model),
                    // 广告
                    buildAds(model.pageRow!.ad1),

                    buildAds(model.pageRow!.ad2),
                  ],
                );
              },
            ),
          )),
    );
  }

  Container buildMSBodyContainer(HomePageModel model) {
    return Container(
        height: 120,
        color: Colors.white,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: model.quicks!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Image.asset(
                      "assets${model.quicks![index].image}",
                      width: 85,
                      height: 85,
                    ),
                    Text(
                      "${model.quicks![index].price}",
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    )
                  ],
                ),
              );
            }));
  }

  Container buildMSHeaderContainer() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.all(10.0),
      height: 50,
      color: Colors.white,
      child: Row(
        children: [
          Image.asset("assets/image/bej.png", width: 90, height: 20),
          const Spacer(),
          const Text("更多秒杀"),
          const Icon(
            CupertinoIcons.right_chevron,
            size: 14,
          )
        ],
      ),
    );
  }

  AspectRatio buildAspectRatio(HomePageModel model) {
    return AspectRatio(
      aspectRatio: 72 / 35,
      child: Swiper(
        itemCount: 5,
        pagination: const SwiperPagination(),
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return Image.asset("assets${model.swipers![index].image}");
        },
      ),
    );
  }

  Widget buildLogos(HomePageModel model) {
    List<Widget> list = [];
    for (var i = 0; i < model.logos!.length; i++) {
      list.add(Container(
        width: 60.0,
        child: Column(
          children: [
            Image.asset("assets${model.logos![i].image}",
                width: 50, height: 50),
            Text("${model.logos![i].title}")
          ],
        ),
      ));
    }
    return Container(
      color: Colors.white,
      height: 170,
      padding: const EdgeInsets.all(10.0),
      child: Wrap(
          spacing: 7.0,
          runSpacing: 10.0,
          alignment: WrapAlignment.spaceBetween,
          children: list),
    );
  }

  Widget buildAds(List<String>? ads) {
    List<Widget> list = [];
    for (var value in ads!) {
      list.add(Expanded(
        child: Image.asset("assets$value"),
      ));
    }
    return Row(
      children: list,
    );
  }
}
