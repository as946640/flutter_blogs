import 'package:flutter/material.dart';
import 'package:flutter_blog/api/article/article.dart';
import 'package:flutter_blog/util/storage.dart';
import 'package:flutter_blog/util/toast/toast.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:dio/dio.dart';

class ArticleModel extends GetxController {
  /// 加载中
  final loading = false.obs;

  /// 文章详情
  final detail = {}.obs;

  /// 相关文章
  final tagArticle = [].obs;

  /// 用户 token
  String token = '';

  ///  获取文章详情
  getDetails(String id) async {
    try {
      loading.value = true;
      final result = await articleDetails(id);
      detail.value = result.data['post'];
      loading.value = false;

      // 获取相关类文章
      List tags = [];
      detail['categories'].forEach((e) {
        tags.add(e['title']);
      });
      if (tags.isNotEmpty) {
        if (tags.length > 3) {
          tags.removeRange(3, tags.length);
        }
        tagArticles(tags).then((res) {
          tagArticle.value = res.data['posts'];
        }).catchError((err) {
          print(err);
        });
      }
    } catch (e) {
      print(e);
      toast('哎呀 找不到这个文章啦');
    }
  }

  /// 点赞
  Future like() {
    Map data = {'access_token': token, 'id': detail['id']};

    return articleLike(data);
  }

  /// 收藏
  collect() async {
    Map data = {'access_token': token, 'id': detail['id']};

    return await articletCollec(data);
  }

  /// 评论列表
  final comments = [].obs;

  void getComment(id) async {
    try {
      final data = {'id': id, 'access_token': token};

      final result = await articleComments(data);
      comments.value = result.data;
    } catch (e) {
      print(e);
      toast('哎呀 获取评论列表失败');
    }
  }

  /// 评论点赞
  void commentLikes(id) async {
    try {
      print(id);
      final data = {'id': id, 'access_token': token};
      final result = await commentLike(data);

      // 查找对应数据修改
      for (int i = 0; i < comments.length; i++) {
        if (id == comments[i]['id']) {
          if (result.data['status'] == 200) {
            comments[i]['islike'] = true;
            comments[i]['likes'] += 1;
          } else {
            comments[i]['islike'] = false;
            comments[i]['likes'] -= 1;
          }
          comments.refresh();
          break;
        }
      }

      toast(result.data['success']);
    } catch (e) {}
  }

  /// 文章评论
  void articleComment(Map data) async {
    try {
      showLoading();
      data['post'] = detail['id'];
      final result = await commentReply(data);

      // 数据组装
      final resultData = result.data;

      print(resultData['parent']);

      var item = {
        "id": resultData['id'],
        "author": {
          "id": resultData['author'],
          "name": resultData['author_name'],
          "avatar": resultData['author_avatar_urls']['48']
        },
        "date": resultData['date'],
        "content": resultData['content']['raw'],
        "parent": resultData['parent'],
        "likes": 0,
        "islike": false,
        "reply": []
      };

      // 是否是回复
      if (item['parent'] != 0) {
        for (int i = 0; i < comments.length; i++) {
          if (item['parent'].toString() == comments[i]['id'].toString()) {
            comments[i]['reply'].insert(0, item);
            comments.refresh();
            break;
          }
        }
      } else {
        comments.insert(0, item);
      }

      detail['comment_count'] += 1;

      toast('评论成功');
      hideLoading();
      Get.back();
    } catch (e) {
      print(e);
      hideLoading();
    }
  }

  /// 文章滚动判断
  ScrollController scrollController = ScrollController();

  /// 是否显示 appbar 信息栏
  final isBarUser = false.obs;

  /// 评论定位
  GlobalKey commentKey = GlobalKey();
  void commentTo() {
    RenderBox? box = commentKey.currentContext?.findRenderObject() as RenderBox;

    final topLeftPosition = box.localToGlobal(Offset.zero);

    scrollController.animateTo(topLeftPosition.dy,
        duration: const Duration(milliseconds: 1000), curve: Curves.easeIn);
  }

  @override
  void onInit() {
    super.onInit();
    String articleId = Get.parameters['id'] ?? '81';
    getDetails(articleId);

    getComment(articleId);

    scrollController.addListener(() {
      if (scrollController.offset >= 300) {
        isBarUser.value = true;
      } else {
        isBarUser.value = false;
      }
    });

    storeGetItem('user_token').then((value) {
      print(value);
      token = value;
    });
  }

  @override
  void onClose() {
    print('onClose ');

    scrollController.dispose();

    super.onClose();
  }
}
