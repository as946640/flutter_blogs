import 'package:flutter/material.dart';
import 'package:flutter_blog/components/HomeAppBar/HomeAppBar.dart';
import 'package:flutter_blog/components/HomePage/HomePage.dart';
import 'package:flutter_blog/model/homeModel.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  /// appBar

  HomeAppBar() {
    return AppBar(
      title: Text('你好'),
    );
  }

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final homeModel = Get.put(HomeModel());

  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    homeModel.pageController = pageController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            const HomeAppBar(),
          ];
        },
        body: PageView(
          controller: pageController,
          onPageChanged: (int index) {
            homeModel.pageChange(index);
          },
          children: List.generate(
            homeModel.tabList.length,
            (index) => HomePage1(
              slug: homeModel.tabList[index]['slug'],
              title: homeModel.tabList[index]['name'],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    print('home 销毁');
    pageController.dispose();
    super.dispose();
  }
}
