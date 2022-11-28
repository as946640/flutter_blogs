import 'package:flutter/cupertino.dart';
import 'package:flutter_blog/iconfont/icon_font.dart';
import 'package:flutter_blog/model/relevantModel/relevantModel.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_blog/components/HomePage/ListItem.dart';

class Relevant extends StatelessWidget {
  Relevant({Key? key}) : super(key: key);

  final relevantModel = Get.put(RelevantModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
          color: Colors.black,
        ),
        title: Obx(
          () => Text(
            relevantModel.title.toString(),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      body: SizedBox(
        width: 1.sw,
        child: Obx(
          () => SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            onRefresh: relevantModel.onRefresh,
            onLoading: relevantModel.onLoading,
            controller: relevantModel.refreshController,
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
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              itemCount: relevantModel.list.length,
              itemBuilder: (context, int index) {
                return ListItem(data: relevantModel.list[index]);
              },
            ),
          ),
        ),
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
          body = const Text(
            "下面没有数据了哦",
            style: TextStyle(
              color: Colors.black,
            ),
          );
        }
        return SizedBox(
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
  }
}
