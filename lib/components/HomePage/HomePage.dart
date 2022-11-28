import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/api/home/home.dart';
import 'package:flutter_blog/components/HomePage/ListItem.dart';
import 'package:flutter_blog/iconfont/icon_font.dart';
import 'package:flutter_blog/util/toast/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage1 extends StatefulWidget {
  final title;
  final slug;
  const HomePage1({
    Key? key,
    required this.title,
    required this.slug,
  }) : super(key: key);

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  List list = [];

  bool showNoData = true;

  /// 当前请求条数
  int total = 0;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  Map<String, dynamic> params = {'slug': '', 'page': 0};

  void _onRefresh() async {
    try {
      if (total <= list.length) {
        _refreshController.refreshCompleted();
        _refreshController.loadNoData();
        return;
      }

      params['page'] += 1;
      final result = await typeArticle(params);
      list.addAll(result.data['posts']);
      total = result.data['count'];
      setState(() {});
      _refreshController.refreshCompleted();
      total = result.data.length;
    } catch (e) {}
  }

  void _onLoading() async {
    try {
      params['page'] += 1;

      final result = await typeArticle(params);

      list.addAll(result.data['posts']);
      total = result.data['count'];
      if (list.isEmpty) showNoData = false;

      if (mounted) setState(() {});
      _refreshController.loadComplete();

      if (total <= list.length) {
        _refreshController.loadNoData();
      }
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    params['slug'] = widget.slug;
    _onLoading();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      controller: _refreshController,
      header: CustomHeader(
        height: 80.h,
        builder: (context, mode) {
          return Image.asset(
            'assets/GIF/custom.gif',
            height: 60,
          );
        },
      ),
      footer: footerWidget(),
      child: showNoData
          ? ListView.builder(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              itemCount: list.length,
              itemBuilder: (context, int index) {
                return ListItem(data: list[index]);
              },
            )
          : noData(),
    );
  }

  /// 无数据提示
  Widget noData() {
    return Padding(
      padding: EdgeInsets.only(top: 40.h),
      child: Column(
        children: [
          IconFont(
            IconNames.queshengye_zanwushuju,
            size: 100,
          ),
          const Text(
            '当前分类没有数据哦~',
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }

  /// 下拉无数据提示
  Widget footerWidget() {
    return CustomFooter(
      builder: (context, mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = const Text("上拉 加载哦");
        } else if (mode == LoadStatus.loading) {
          body = const CupertinoActivityIndicator();
        } else if (mode == LoadStatus.failed) {
          body = const Text("加载失败了 点击重试");
        } else if (mode == LoadStatus.canLoading) {
          body = const Text("释放 加载更多");
        } else {
          body = const Text("下面没有数据了哦");
        }
        return SizedBox(
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
  }

  @override
  void dispose() {
    print('${widget.title}销毁');
    _refreshController.dispose();
    super.dispose();
  }
}
