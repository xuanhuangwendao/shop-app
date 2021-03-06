class MyApi {
  //
  static const String LOCAL_URL = "http://123.60.77.134:7002";
  // static const String LOCAL_URL = "http://192.168.31.42:7002";
  // 登录
  static const String LOGIN = LOCAL_URL + "/user/login";

  // 注册
  static const String REGISTER = LOCAL_URL + "/user/register";


  // 推荐商品
  static const String RECOMMEND = LOCAL_URL + "/shop/recommend";

  // 商详页
  static const String DETAIL = LOCAL_URL + "/shop/detail";

  // 供给
  static const String GOODS = LOCAL_URL + "/shop/goods";

  // 供给详情
  static const String GOODS_ITEM = LOCAL_URL + "/shop/goodsItem";

  // 开团
  static const String CREATE_SHOP = LOCAL_URL + "/shop/createShop";

  // 商品下单
  static const String PLACE_ORDER = LOCAL_URL + "/pay/addCart";

  // 查询订单
  static const String GET_ORDER = LOCAL_URL + "/pay/getOrder";

  // 修改订单
  static const String MODIFY_ORDER = LOCAL_URL + "/pay/updateOrder";

  // 支付订单
  static const String PAY_ORDER = LOCAL_URL + "/pay/payOrder";


  // 获取用户信息
  static const String USER_INFO = LOCAL_URL + "/user/myUserInfo";

  // 修改头像
  static const String UP_LOAD = LOCAL_URL + "/user/changeUserPic";

  // 上传图片
  static const String SAVE_PIC = LOCAL_URL + "/file/save";

  // 读取图片
  static const String READ_IMG = LOCAL_URL + "/file/img";


}