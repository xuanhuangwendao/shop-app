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
  String? title;
  String? price;
  String? sellerName;
  String? picUrl;

  ItemList({this.id, this.title, this.price, this.sellerName, this.picUrl});

  ItemList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    sellerName = json['sellerName'];
    picUrl = json['picUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['sellerName'] = this.sellerName;
    data['picUrl'] = this.picUrl;
    return data;
  }
}
