import 'package:flutter/material.dart';
import 'package:flutter_blog/components/DetailButton/DetailButton.dart';
import 'package:flutter_blog/components/DetailHeader/DetailHeader.dart';
import 'package:flutter_blog/components/Details/Bar.dart';
import 'package:flutter_blog/components/Details/Comment.dart';
import 'package:flutter_blog/components/Details/TagArticle.dart';
import 'package:flutter_blog/components/MyBehavior/MyBehavior.dart';
import 'package:flutter_blog/components/detailHtml/detailHtml.dart';
import 'package:flutter_blog/iconfont/icon_font.dart';
import 'package:flutter_blog/util/toast/toast.dart';
import 'package:get/get.dart';
import 'package:flutter_blog/model/ArticleModel/ArticleModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArticleDetail extends StatelessWidget {
  ArticleDetail({Key? key}) : super(key: key);

  ArticleModel articleModel = Get.put(ArticleModel());

  ScrollController scrollController = ScrollController();

  /// 加载 widget
  Widget loadWidget() {
    return Align(
        alignment: Alignment.topCenter,
        child: Padding(
            padding: EdgeInsets.only(top: 100.h),
            child: Column(
              children: [
                Image.asset(
                  'assets/GIF/custom.gif',
                  width: 100.r,
                  height: 100.r,
                ),
                Text(
                  '网络正在疯狂奔跑中···',
                  style: TextStyle(
                    fontSize: 18.sm,
                    // fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                )
              ],
            )));
  }

  /// 文章标签
  List<Widget> tags() {
    return List.generate(
      articleModel.detail['categories'].length > 3
          ? 3
          : articleModel.detail['categories'].length,
      (index) => Container(
        height: 28.h,
        padding: EdgeInsets.symmetric(
          horizontal: 8.w,
        ),
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blue.shade100.withOpacity(0.3),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          articleModel.detail['categories'][index]['title'],
          style: const TextStyle(color: Color(0xff555e63)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: DetailBar(),
        preferredSize: const Size.fromHeight(50),
      ),
      body: Obx(() {
        if (articleModel.loading.value) {
          return loadWidget();
        } else {
          return Container(
            width: 1.sw,
            height: 1.sh,
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: SingleChildScrollView(
                      controller: articleModel.scrollController,
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DetailHeader(),
                          Obx(
                            () => DetailHtml(
                              html: articleModel.detail['content'] ?? '',
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 20.h,
                              horizontal: 10.w,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconFont(
                                  IconNames.shengqian,
                                  size: 24,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10.w),
                                  child: Row(
                                    children: tags(),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 30.w,
                                  height: 1.h,
                                  color: Colors.grey.shade400,
                                  margin: EdgeInsets.only(right: 8.w),
                                ),
                                Text(
                                  '本文更新于 ${articleModel.detail['modified']}',
                                  style: TextStyle(
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                Container(
                                  width: 30.w,
                                  height: 1.h,
                                  color: Colors.grey.shade400,
                                  margin: EdgeInsets.only(left: 8.w),
                                ),
                              ],
                            ),
                          ),
                          TagArticle(),
                          Offstage(
                              offstage: articleModel.comments.isEmpty,
                              child: Comment()),
                        ],
                      ),
                    ),
                  ),
                ),
                DetailButton(),
              ],
            ),
          );
        }
      }),
    );
  }
}

///收藏
class CollectWidget extends StatefulWidget {
  CollectWidget({Key? key}) : super(key: key);

  @override
  State<CollectWidget> createState() => _CollectWidgetState();
}

class _CollectWidgetState extends State<CollectWidget> {
  ArticleModel articleModel = Get.find();

  String favColor = '#ccc';

  /// 收藏
  void _collect() async {
    try {
      showLoading();
      final result = await articleModel.collect();
      int status = result.data['status'];
      if (status == 200) {
        favColor = '#ffb23e';
      } else {
        favColor = '#ccc';
      }

      hideLoading();
      toast(result.data['message']);
      setState(() {});
    } catch (e) {
      hideLoading();
      toast('哎呀 收藏失败啦');
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _collect();
      },
      icon: IconFont(
        IconNames.shoucang_1,
        size: 26,
        color: favColor,
      ),
    );
  }
}
