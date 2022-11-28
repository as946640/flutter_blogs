import 'package:flutter_blog/util/storage.dart';
import 'package:get/get.dart';
import 'package:flutter_blog/api/relevant/relevant.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RelevantModel extends GetxController {
  final current = '1'.obs;

  final title = ''.obs;

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  final list = [].obs;

  int total = 0;

  bool showNoData = true;

  Map<String, dynamic> params = {
    'type': 'fav',
    'page': 0,
    'per_page': 10,
    'access_token': ''
  };
  void getList() async {
    params['page'] += 1;

    if (params['access_token'] == '') {
      params['access_token'] = await storeGetItem('user_token');
    }

    final result = await getArticleList(params);

    list.addAll(result.data);
    total = result.data.length;

    if (list.isEmpty) showNoData = false;
  }

  void onRefresh() async {
    getList();

    if (total <= 10) {
      refreshController.refreshCompleted();
      refreshController.loadNoData();
    }
  }

  void onLoading() {
    getList();
    refreshController.loadComplete();
  }

  @override
  void onInit() {
    super.onInit();

    title.value = Get.parameters['title'] ?? '我的文章';
    current.value = Get.parameters['index'] ?? '1';

    switch (title.value) {
      case '点赞的帖子':
        params['type'] = 'like';
        break;
      case '评论的帖子':
        params['type'] = 'comment';
        break;
      default:
        params['type'] = 'fav';
    }
  }
}
