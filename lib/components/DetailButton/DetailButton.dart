import 'package:flutter/material.dart';
import 'package:flutter_blog/components/Details/Reply.dart';
import 'package:flutter_blog/components/Dianzan/Dianzan.dart';
import 'package:flutter_blog/iconfont/icon_font.dart';
import 'package:flutter_blog/pages/detail/detail.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_blog/model/ArticleModel/ArticleModel.dart';

class DetailButton extends StatelessWidget {
  DetailButton({Key? key}) : super(key: key);

  ArticleModel articleModel = Get.find();

  /// 评论
  void openComment(context) {
    Get.bottomSheet(Reply(
      parent: null,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 50.h + ScreenUtil().bottomBarHeight,
      padding: EdgeInsets.only(
        bottom: ScreenUtil().bottomBarHeight,
        top: 4.h,
        left: 10.w,
        right: 10.w,
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                openComment(context);
              },
              child: Container(
                height: 36.h,
                decoration: BoxDecoration(
                  color: const Color(0xffeef2f4),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.only(left: 10.w),
                child: Row(
                  children: [
                    const Icon(
                      Icons.edit,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: const Text(
                        '输入评论...',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: IconFont(
                IconNames.caidan,
                size: 26,
              )),
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  articleModel.commentTo();
                },
                icon: IconFont(
                  IconNames.xiaoxi_1,
                  size: 26,
                ),
              ),
              Positioned(
                right: 2.w,
                top: 4.h,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 1.h,
                    horizontal: 4.w,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    articleModel.detail['comment_count'].toString(),
                    style: TextStyle(
                      fontSize: 10.sm,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
          Dianzan(),
          CollectWidget()
        ],
      ),
    );
  }
}
