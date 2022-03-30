class MyApi {
  static const String BASE_URL = "https://flutter-jdapi.herokuapp.com/api";

  // 首页
  static const String HOME_PAGE = BASE_URL + "/profiles/homepage";

  // 分类导航
  static const String CATEGORY_NAV = BASE_URL + "/profiles/navigationLeft";

  // 分类类目
  static const String CATEGORY_CONTENT = BASE_URL + "/profiles/navigationRight";

  //商品列表
  static const String PRODUCTIONS_LIST = BASE_URL + "/profiles/productionsList";

  // 商详
  static const String PRODUCTION_DETAIL = BASE_URL + "/profiles/productionDetail";


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