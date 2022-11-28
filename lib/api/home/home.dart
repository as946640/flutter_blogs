import 'package:flutter_blog/util/dio_util/dio_util.dart';

/// 获取 分类栏目
Future getTypes() {
  return DioUtil().request('/wp-json/wp/v2/categories');
}

/// 分类 文章
Future typeArticle(data) {
  return DioUtil().request('/api/get_category_posts', params: data);
}
