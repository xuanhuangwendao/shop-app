class MyApi {

  static const String LOCAL_URL = "http://192.168.31.42:7002";

  // 推荐商品
  static const String RECOMMEND = LOCAL_URL + "/shop/recommend";

  // 商详页
  static const String DETAIL = LOCAL_URL + "/shop/detail";

  // 商品下单
  static const String PLACE_ORDER = LOCAL_URL + "/shop/addCart";

  // 查询订单
  static const String GET_ORDER = LOCAL_URL + "/shop/getOrder";

  // 修改订单
  static const String MODIFY_ORDER = LOCAL_URL + "/shop/updateOrder";

  // 登录
  static const String LOGIN = LOCAL_URL + "/user/login";
}