import 'package:flutter_blog/util/dio_util/dio_util.dart';

/// 搜索文章
Future serchArticle(String serch) {
  return DioUtil().request('/api/get_search_results/?search=' + serch);
}
