import 'package:flutter_blog/util/dio_util/dio_method.dart';
import 'package:flutter_blog/util/dio_util/dio_util.dart';

/// 文章详情
Future articleDetails(String articleId) {
  return DioUtil().request('/api/get_post', params: {'id': articleId});
}

/// 相关文章
Future tagArticles(List tags) {
  return DioUtil().request('/api/get_tag_posts', params: {'slug': tags});
}

/// 文章点赞
Future articleLike(Map data) {
  return DioUtil().request(
    '/wp-json/mp/v1/comments?type=like',
    method: DioMethod.post,
    data: data,
  );
}

/// 文章收藏
Future articletCollec(Map data) {
  return DioUtil().request(
    '/wp-json/mp/v1/comments?type=fav',
    method: DioMethod.post,
    data: data,
  );
}

/// 评论列表
Future articleComments(Map<String, dynamic> data) {
  return DioUtil().request('/wp-json/mp/v1/comments', params: data);
}

/// 评论点赞
Future commentLike(Map data) {
  return DioUtil().request(
    '/wp-json/mp/v1/comments/mark',
    method: DioMethod.post,
    data: data,
  );
}

/// 评论 回复
Future commentReply(Map data) {
  return DioUtil().request(
    '/wp-json/wp/v2/comments',
    method: DioMethod.post,
    data: data,
  );
}
