import 'package:shopapp/config/api.dart';
import 'package:shopapp/model/cart_response.dart';
import 'package:shopapp/model/detail_response.dart';
import 'package:shopapp/model/recommend_response.dart';
import 'package:shopapp/model/user_info_response.dart';
import 'package:shopapp/net/net_request.dart';
import 'package:flutter/material.dart';

class BottomNaviProvider extends ChangeNotifier {
  int bottomNaviIndex = 0;

  void changeBottomNaviIndex(int index) {
    if (bottomNaviIndex != index) {
      bottomNaviIndex = index;
      notifyListeners();
    }
  }
}

class HomePageProvider extends ChangeNotifier {
  RecommendResponse? result;
  bool isLoading = false;
  bool isError = false;
  String? errorMsg = "";

  loadHomePageData() {
    print("view home");
    isLoading = true;
    isError = false;
    errorMsg = "";
    NetRequest().request(MyApi.RECOMMEND).then((response) {
      isLoading = false;
      result = RecommendResponse.fromJson(response.model);
      notifyListeners();
    }).catchError((error) {
      isError = true;
      print(error);
      errorMsg = error.toString();
      isLoading = false;
      notifyListeners();
    });
  }
  loadGoodsPageData() {
    print("view home");
    isLoading = true;
    isError = false;
    errorMsg = "";
    NetRequest().request(MyApi.GOODS).then((response) {
      isLoading = false;
      result = RecommendResponse.fromJson(response.model);
      notifyListeners();
    }).catchError((error) {
      isError = true;
      print(error);
      errorMsg = error.toString();
      isLoading = false;
      notifyListeners();
    });
  }
}
class ProductDetailProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String? errorMsg = "";
  DetailResponse? model;

  loadProduct(String id) {
    if (model != null && model!.id.toString() == id) {
      return;
    }
    isLoading = true;
    isError = false;
    errorMsg = "";
    Map<String, dynamic> param = {'id': id};

    NetRequest().request(MyApi.DETAIL, params: param).then((response) {
      isLoading = false;
      model = DetailResponse.fromJson(response.model);
      notifyListeners();
    }).catchError((error) {
      isError = true;
      errorMsg = error;
      isLoading = false;
      print(error);
      notifyListeners();
    });
  }
  loadGoods(String id) {
    if (model != null && model!.id.toString() == id) {
      return;
    }
    isLoading = true;
    isError = false;
    errorMsg = "";
    Map<String, dynamic> param = {'id': id};

    NetRequest().request(MyApi.GOODS_ITEM, params: param).then((response) {
      isLoading = false;
      model = DetailResponse.fromJson(response.model);
      notifyListeners();
    }).catchError((error) {
      isError = true;
      errorMsg = error;
      isLoading = false;
      print(error);
      notifyListeners();
    });
  }
}

class CartProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String? errorMsg = "";
  CartResponse? result;
  bool selectedAll = false;
  Map<int, bool> selectedMap = {};

  loadCart() {
    isLoading = true;
    isError = false;
    errorMsg = "";
    selectedMap = {};
    Map<String, dynamic> param = {"status": 1};
    NetRequest().request(MyApi.GET_ORDER, params: param).then((response) {
      isLoading = false;
      print(response.model);

      result = CartResponse.fromJson(response.model);
      for (CartItemList item in result!.cartItemList!) {
        selectedMap[item.orderId!] = false;
      }
      notifyListeners();
    }).catchError((error) {
      isError = true;
      isLoading = false;
      print(error);
      notifyListeners();
    });
  }

  selectAll() {
    selectedAll = !selectedAll;
    selectedMap.forEach((key, value) {
      selectedMap[key] = selectedAll;
    });
    notifyListeners();
  }
  select(int id) {
    selectedMap[id] = !selectedMap[id]!;
    if (!selectedMap[id]!) {
      selectedAll = false;
    }
    notifyListeners();
  }
}

class OrderProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String? errorMsg = "";
  CartResponse? result;
  bool selectedAll = false;
  Map<int, bool> selectedMap = {};


  loadOrder() {
    isLoading = true;
    isError = false;
    errorMsg = "";
    selectedMap = {};
    Map<String, dynamic> param = {"status": 0};
    NetRequest().request(MyApi.GET_ORDER, params: param).then((response) {
      isLoading = false;
      print(response.model);

      result = CartResponse.fromJson(response.model);
      for (CartItemList item in result!.cartItemList!) {
        selectedMap[item.orderId!] = false;
      }
      notifyListeners();
    }).catchError((error) {
      isError = true;
      isLoading = false;
      print(error);
      notifyListeners();
    });
  }
}

class UserInfoProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String? errorMsg = "";
  UserInfoResponse? result;

  loadUserInfo() {
    isLoading = true;
    isError = false;
    errorMsg = "";
    print("loadUserInfooooo");
    NetRequest().request(MyApi.USER_INFO).then((response) {
      isLoading = false;
      result = UserInfoResponse.fromJson(response.model);
      print(result!.toJson());
      notifyListeners();
    }).catchError((error) {
      isError = true;
      errorMsg = error;
      isLoading = false;
      print(error);
      notifyListeners();
    });
  }
}
