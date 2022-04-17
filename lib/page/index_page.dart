import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopapp/page/cart_page.dart';
import 'package:shopapp/page/home_page.dart';
import 'package:shopapp/page/seller_home_page.dart';
import 'package:shopapp/page/user_page.dart';
import 'package:shopapp/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IndexPage extends StatefulWidget {
  final int userType;

  const IndexPage({Key? key, required this.userType}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.userType == 1) {
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
                      CartPage(),
                      UserPage(),
                    ],
                  )));
    } else if (widget.userType == 2) {
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
                      SellerHomePage(),
                      UserPage(),
                    ],
                  )));
    } else {
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
                      CartPage(),
                      UserPage(),
                    ],
                  )));
    }
  }
}
