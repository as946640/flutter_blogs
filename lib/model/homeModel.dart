import 'package:flutter/material.dart';
import 'package:flutter_blog/api/home/home.dart';
import 'package:get/get.dart';

class HomeModel extends GetxController {
  // late TabController tabController ;

  late TabController _tabController;

  set setTabController(value) => _tabController = value;

  get tabController => _tabController;

  late PageController _pageController;

  set pageController(value) => _pageController = value;

  get pageController => _pageController;

  final tabList = [
    {
      'name': 'Flutter',
      'slug': 'flutter',
    },
    {
      'name': 'JavaScript',
      'slug': 'javascript',
    },
    {
      'name': 'Node',
      'slug': 'node',
    },
    {
      'name': '前端资源',
      'slug': '前端资源',
    },
    {
      'name': '题目',
      'slug': '题目',
    },
  ];

  final tabIndex = 0.obs;

  /// pageview 滚动
  pageChange(int index) {
    _tabController.animateTo(index);
    tabIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    print('home getx 销毁');
    super.onClose();
  }
}
