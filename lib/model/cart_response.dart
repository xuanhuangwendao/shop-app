class CartResponse {
  List<CartItemList>? cartItemList;

  CartResponse({this.cartItemList});

  CartResponse.fromJson(Map<String, dynamic> json) {
    if (json['cartItemList'] != null) {
      cartItemList = <CartItemList>[];
      json['cartItemList'].forEach((v) {
        cartItemList!.add(new CartItemList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cartItemList != null) {
      data['cartItemList'] = this.cartItemList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartItemList {
  int? orderId;
  String? title;
  String? picUrl;
  double? price;
  String? priceText;
  int? num;
  String? status;
  String? createTime;
  String? payTime;

  CartItemList(
      {this.orderId,
        this.title,
        this.picUrl,
        this.price,
        this.priceText,
        this.num,
        this.status,
        this.createTime,
        this.payTime
      });

  CartItemList.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    title = json['title'];
    picUrl = json['picUrl'];
    price = json['price'];
    priceText = json['priceText'];
    num = json['num'];
    status = json['status'];
    createTime = json['createTime'];
    payTime = json['payTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['title'] = this.title;
    data['picUrl'] = this.picUrl;
    data['price'] = this.price;
    data['priceText'] = this.priceText;
    data['num'] = this.num;
    data['status'] = this.status;
    data['createTime'] = this.payTime;
    return data;
  }
}
