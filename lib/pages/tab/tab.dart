import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/iconfont/icon_font.dart';
import 'package:flutter_blog/pages/home/home.dart';
import 'package:flutter_blog/pages/serch/serch.dart';
import 'package:flutter_blog/pages/user/user.dart';

class HomeTab extends StatefulWidget {
  HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with TickerProviderStateMixin {
  int _selectedIndex = 0;

  late TabController tabController;

  /// 页面列表
  List<Map> pageList = [
    {
      'appBar': const Home().HomeAppBar,
      'page': () => const Home(),
    },
    {'appBar': null, 'page': () => Search()},
    {
      'appBar': null,
      'page': Container(
        color: Colors.blue,
      ),
    },
    {'appBar': null, 'page': () => User()},
  ];

  /// 底部菜单
  List tabBars = [
    {
      'icon': IconFont(
        IconNames.biaoqiankuozhan_wode_145,
        size: 28,
      ),
      'title': '首页'
    },
    {
      'icon': IconFont(
        IconNames.sousuo,
        size: 30,
      ),
      'title': '发现'
    },
    {
      'icon': IconFont(
        IconNames.xiaoxi,
        size: 28,
      ),
      'title': '信息'
    },
    {
      'icon': IconFont(
        IconNames.biaoqiankuozhan_wode_145,
        size: 28,
      ),
      'title': '我的'
    },
  ];

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(initialIndex: _selectedIndex, length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Widget page = pageList[_selectedIndex]['page']();

    return Scaffold(
      body: page,
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
          tabController.animateTo(index);
        }),
        items: tabBars
            .map(
              (e) => FlashyTabBarItem(
                icon: e['icon'],
                title: Text(e['title']),
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
