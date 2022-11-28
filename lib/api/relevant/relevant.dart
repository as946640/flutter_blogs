import 'package:flutter_blog/util/dio_util/dio_method.dart';
import 'package:flutter_blog/util/dio_util/dio_util.dart';

///  文章列表
Future getArticleList(params) {
  return DioUtil().request('/wp-json/mp/v1/posts/comment', params: params);
}
