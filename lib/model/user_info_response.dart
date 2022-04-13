class UserInfoResponse {
  String? nickName;
  String? profilePic;
  String? sign;
  String? address;

  UserInfoResponse({this.nickName, this.profilePic, this.sign, this.address});

  UserInfoResponse.fromJson(Map<String, dynamic> json) {
    nickName = json['nickName'];
    profilePic = json['profilePic'];
    sign = json['sign'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nickName'] = this.nickName;
    data['profilePic'] = this.profilePic;
    data['sign'] = this.sign;
    data['address'] = this.address;
    return data;
  }
}
