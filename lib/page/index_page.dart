import 'package:shopapp/page/cart_page.dart';
import 'package:shopapp/page/category_page.dart';
import 'package:shopapp/page/home_page.dart';
import 'package:shopapp/page/user_page.dart';
import 'package:shopapp/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Consumer<BottomNaviProvider>(
          builder: (_, mProvider, __) => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: mProvider.bottomNaviIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "首页",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: "分类",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: "购物车",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "我的",
              ),
            ],
            onTap: (index) {
              setState(() {
                mProvider.changeBottomNaviIndex(index);
              });
            },
          ),
        ),
        body: Consumer<BottomNaviProvider>(
            builder: (context, mProvider, __) => IndexedStack(
                  index: mProvider.bottomNaviIndex,
                  children: const [
                    HomePage(),
                    CategoryPage(),
                    CartPage(),
                    UserPage(),
                  ],
                )));
  }
}
