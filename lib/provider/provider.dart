import 'package:shopapp/config/api.dart';
import 'package:shopapp/model/category_content_model.dart';
import 'package:shopapp/model/product_detail_model.dart';
import 'package:shopapp/model/product_info_model.dart';
import 'package:shopapp/model/recommend_response.dart';
import 'package:shopapp/model/summary_response.dart';
import 'package:shopapp/net/net_request.dart';
import 'package:flutter/material.dart';

class BottomNaviProvider extends ChangeNotifier {
  int bottomNaviIndex = 0;

  void changeBottomNaviIndex(int index) {
    print("selected " + bottomNaviIndex.toString() + " page");
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
}

class CategoryPageProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String? errorMsg = "";
  List<String> categoryNavList = [];
  List<CategoryContentModel> categoryContentList = [];
  int tabIndex = 0;

  loadCategoryPageData() {
    isLoading = true;
    isError = false;
    errorMsg = "";
    NetRequest().requestData(MyApi.CATEGORY_NAV).then((response) {
      isLoading = false;
      if (response.data is List) {
        for (var i = 0; i < response.data.length; i++) {
          categoryNavList.add(response.data[i]);
        }
        loadCategoryContentData(tabIndex);
      }
      notifyListeners();
    }).catchError((error) {
      print(error);
      isError = true;
      errorMsg = error;
      isLoading = false;
      notifyListeners();
    });
  }

  loadCategoryContentData(int index) {
    tabIndex = index;
    isLoading = true;
    categoryContentList.clear();
    var data = {"title": categoryNavList[index]};
    NetRequest()
        .requestData(MyApi.CATEGORY_CONTENT, data: data, method: "post")
        .then((response) {
      isLoading = false;
      if (response.data is List) {
        for (var item in response.data) {
          CategoryContentModel contentModel =
              CategoryContentModel.fromJson(item);
          categoryContentList.add(contentModel);
        }
      }
      notifyListeners();
    }).catchError((error) {
      print(error);
      isError = true;
      errorMsg = error;
      isLoading = false;
      notifyListeners();
    });
    notifyListeners();
  }
}

class ProductListProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String? errorMsg = "";
  List<ProductInfoModel> list = [];

  loadProductList() {
    isLoading = true;
    isError = false;
    errorMsg = "";
    NetRequest().requestData(MyApi.PRODUCTIONS_LIST).then((response) {
      isLoading = false;
      if (response.code == 200 && response.data is List) {
        for (var item in response.data) {
          ProductInfoModel model = ProductInfoModel.fromJson(item);
          list.add(model);
        }
      }
      notifyListeners();
    }).catchError((error) {
      isError = true;
      errorMsg = error;
      isLoading = false;
      notifyListeners();
    });
  }
}

class ProductDetailProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String? errorMsg = "";
  ProductDetailModel? model;
  DetailResponse? result;

  loadProduct(String id) {
    if (result != null && result!.id.toString() == id) {
      print(id);
      return;
    }
    isLoading = true;
    isError = false;
    errorMsg = "";
    Map<String, dynamic> param = {'id': id};

    NetRequest().request(MyApi.DETAIL, params: param).then((response) {
      isLoading = false;
      print("ProductDetailProvider:" + response.toString());
      result = DetailResponse.fromJson(response.model);
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

class CartProvider extends ChangeNotifier {}
