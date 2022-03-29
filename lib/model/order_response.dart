class OrderResponse {
  List<CartItemList>? cartItemList;
  double? totalAmount;
  String? totalAmountText;
  bool selectedAll = false;

  OrderResponse({this.cartItemList, this.totalAmount, this.totalAmountText});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    if (json['cartItemList'] != null) {
      cartItemList = <CartItemList>[];
      json['cartItemList'].forEach((v) {
        cartItemList!.add(new CartItemList.fromJson(v));
      });
    }
    totalAmount = json['totalAmount'];
    totalAmountText = json['totalAmountText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cartItemList != null) {
      data['cartItemList'] = this.cartItemList!.map((v) => v.toJson()).toList();
    }
    data['totalAmount'] = this.totalAmount;
    data['totalAmountText'] = this.totalAmountText;
    return data;
  }
}

class CartItemList {
  int? orderId;
  String? picUrl;
  String? title;
  double? price;
  String? priceText;
  int? num;
  bool selected = false;


  CartItemList(
      {this.orderId,
        this.picUrl,
        this.title,
        this.price,
        this.priceText,
        this.num});

  CartItemList.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    picUrl = json['picUrl'];
    title = json['title'];
    price = json['price'];
    priceText = json['priceText'];
    num = json['num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['picUrl'] = this.picUrl;
    data['title'] = this.title;
    data['price'] = this.price;
    data['priceText'] = this.priceText;
    data['num'] = this.num;
    return data;
  }
}
