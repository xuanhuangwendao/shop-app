import 'package:shopapp/model/category_content_model.dart';
import 'package:shopapp/page/product_list_page.dart';
import 'package:shopapp/provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CategoryPageProvider>(
      create: (context) {
        var provider = CategoryPageProvider();
        provider.loadCategoryPageData();
        return provider;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("分类"),
          ),
          body: Container(
            color: const Color(0xfff4f4f4),
            child: Consumer<CategoryPageProvider>(
              builder: (_, provider, __) {
                if (provider.isLoading && provider.categoryNavList.isEmpty) {
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
                            provider.loadCategoryPageData();
                          },
                          child: const Text("刷新"),
                        )
                      ],
                    ),
                  );
                }
                return Row(children: [
                  buildNavLeftContainer(provider),
                  Expanded(
                      child: Stack(
                    children: [
                      buildCategoryContent(provider.categoryContentList),
                      provider.isLoading
                          ? Center(
                              child: CupertinoActivityIndicator(),
                            )
                          : Container()
                    ],
                  )),
                ]);
              },
            ),
          )),
    );
  }

  Container buildNavLeftContainer(CategoryPageProvider provider) {
    return Container(
      width: 90,
      child: ListView.builder(
          itemCount: provider.categoryNavList.length,
          itemBuilder: (context, index) {
            return InkWell(
              child: Container(
                  height: 50.0,
                  padding: const EdgeInsets.only(top: 15),
                  color: provider.tabIndex == index
                      ? Colors.white
                      : Color(0xFFF8F8F8),
                  child: Text(
                    provider.categoryNavList[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: provider.tabIndex == index
                            ? Color(0xFFe93b3d)
                            : Color(0xFF333333),
                        fontWeight: FontWeight.w500),
                  )),
              onTap: () {
                provider.loadCategoryContentData(index);
              },
            );
          }),
    );
  }

  Widget buildCategoryContent(List<CategoryContentModel> contentList) {
    List<Widget> list = [];

    for (var i = 0; i < contentList.length; i++) {
      list.add(Container(
        height: 30.0,
        margin: const EdgeInsets.only(left: 10.0, top: 10.0),
        child: Text(
          "${contentList[i].title}",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
      ));
      List<Widget> descList = [];
      for (var j = 0; j < contentList[i].desc!.length; j++) {
        descList.add(InkWell(
          child: Container(
            width: 60.0,
            color: Colors.white,
            child: Column(
              children: [
                Image.asset(
                  "assets${contentList[i].desc![j].img}",
                  width: 50,
                  height: 50,
                ),
                Text("${contentList[i].desc![j].text}")
              ],
            ),
          ),
          onTap: () {
            //跳转商品页面
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ChangeNotifierProvider<ProductListProvider>(
                      create: (context) {
                        ProductListProvider provider = ProductListProvider();
                        provider.loadProductList();
                        return provider;
                      },
                      child: Consumer<ProductListProvider>(
                          builder: (_, provider, __) {
                        return Container(
                            child: ProductListPage(
                                title: contentList[i].desc![j].text!));
                      }),
                    )));
          },
        ));
      }
      list.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          spacing: 7.0,
          runSpacing: 10.0,
          alignment: WrapAlignment.start,
          children: descList,
        ),
      ));
    }
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: ListView(
        children: list,
      ),
    );
  }
}
