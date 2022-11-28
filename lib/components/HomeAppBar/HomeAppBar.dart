import 'package:flutter/material.dart';
import 'package:flutter_blog/components/HomeAppBar/AppBar.dart';
import 'package:flutter_blog/components/tabIndicator/tabIndicator.dart';
import 'package:flutter_blog/model/homeModel.dart';
import 'package:flutter_blog/util/toast/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/instance_manager.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> with TickerProviderStateMixin {
  HomeModel homeModel = Get.find();
  List tbas = [];

  @override
  void initState() {
    super.initState();
    homeModel.setTabController = TabController(
        initialIndex: 0, vsync: this, length: homeModel.tabList.length);
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      expandedHeight: 100,
      backgroundColor: Colors.white,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          //头部整个背景颜色
          height: double.infinity,
          color: const Color(0xffffffff),
          child: const AppBars(),
        ),
      ),
      bottom: TabBar(
        isScrollable: true,
        labelColor: const Color(0xff333333),
        controller: homeModel.tabController,
        indicatorSize: TabBarIndicatorSize.label,
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          fontSize: 13.sp,
        ),
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 14.sp,
        ),
        indicator: TmdTabIndicator(
          borderSide: BorderSide(
            width: 3.w,
            color: Theme.of(context).primaryColor,
          ),
        ),
        onTap: (index) {
          tabTap(index);
        },
        tabs: List.generate(
          homeModel.tabList.length,
          (int index) => Tab(
            text: homeModel.tabList[index]['name'],
          ),
        ),
      ),
    );
  }

  void tabTap(int index) {
    homeModel.pageController.animateTo(
      MediaQuery.of(context).size.width * index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  void dispose() {
    print('home tab 销毁');
    homeModel.tabController.dispose();
    super.dispose();
  }
}
