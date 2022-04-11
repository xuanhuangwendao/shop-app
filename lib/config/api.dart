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

  // 注册
  static const String REGISTER = LOCAL_URL + "/user/register";

  // 获取用户信息
  static const String USER_INFO = LOCAL_URL + "/user/userInfo";

  // 上传图片
  static const String UP_LOAD = LOCAL_URL + "/file/upload";

  // 读取图片
  static const String READ_IMG = LOCAL_URL + "/file/img";


}