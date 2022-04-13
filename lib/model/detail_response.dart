class DetailResponse {
  int? id;
  String? title;
  String? sellerName;
  String? price;
  int? stock;
  String? desc;
  String? picUrl;

  DetailResponse(
      {this.id,
        this.title,
        this.sellerName,
        this.price,
        this.stock,
        this.desc,
        this.picUrl});

  DetailResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    sellerName = json['sellerName'];
    price = json['price'];
    stock = json['stock'];
    desc = json['desc'];
    picUrl = json['picUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['sellerName'] = this.sellerName;
    data['price'] = this.price;
    data['stock'] = this.stock;
    data['desc'] = this.desc;
    data['picUrl'] = this.picUrl;
    return data;
  }
}
