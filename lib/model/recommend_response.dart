class RecommendResponse {
  List<ItemList>? itemList;

  RecommendResponse({this.itemList});

  RecommendResponse.fromJson(Map<String, dynamic> json) {
    if (json['itemList'] != null) {
      itemList = <ItemList>[];
      json['itemList'].forEach((v) {
        itemList!.add(new ItemList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.itemList != null) {
      data['itemList'] = this.itemList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemList {
  int? id;
  int? sellerId;
  String? sellerNick;
  double? price;
  double? stock;
  String? title;
  String? picUrl;
  String? desc;
  String? gmtCreate;
  String? gmtModified;

  ItemList(
      {this.id,
        this.sellerId,
        this.sellerNick,
        this.price,
        this.stock,
        this.title,
        this.picUrl,
        this.desc,
        this.gmtCreate,
        this.gmtModified});

  ItemList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerId = json['sellerId'];
    sellerNick = json['sellerNick'];
    price = json['price'];
    stock = json['stock'];
    title = json['title'];
    picUrl = json['picUrl'];
    desc = json['desc'];
    gmtCreate = json['gmtCreate'];
    gmtModified = json['gmtModified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sellerId'] = this.sellerId;
    data['sellerNick'] = this.sellerNick;
    data['price'] = this.price;
    data['stock'] = this.stock;
    data['title'] = this.title;
    data['picUrl'] = this.picUrl;
    data['desc'] = this.desc;
    data['gmtCreate'] = this.gmtCreate;
    data['gmtModified'] = this.gmtModified;
    return data;
  }
}
