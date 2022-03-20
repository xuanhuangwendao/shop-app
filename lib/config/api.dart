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
}