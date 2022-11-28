import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_blog/components/Details/Reply.dart';
import 'package:flutter_blog/iconfont/icon_font.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_blog/model/ArticleModel/ArticleModel.dart';

class Comment extends StatelessWidget {
  Comment({Key? key}) : super(key: key);

  ArticleModel articleModel = Get.find();

  // 评论列表
  List<Widget> commentList() {
    return articleModel.comments.map((item) {
      return Container(
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipOval(
                    child: Image.network(
                      item['author']['avatar'],
                      width: 40.r,
                      height: 40.r,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['author']['name'],
                            style: TextStyle(
                              color: Colors.blue.shade600,
                            ),
                          ),
                          Text(
                            item['date'],
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.sm,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 6.h),
                            child: Text(
                              item['content'],
                              style: TextStyle(
                                fontSize: 15.sm,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20.w,
                          child: IconButton(
                            padding: const EdgeInsets.all(0),
                            onPressed: () {
                              articleModel.commentLikes(item['id'].toString());
                            },
                            icon: IconFont(
                              item['islike'] == false
                                  ? IconNames.dianzanweixuanzhong
                                  : IconNames.dianzan_xuanzhong,
                              color: item['islike'] == false
                                  ? '#7d828f'
                                  : '#0071fb',
                              size: 16,
                            ),
                          ),
                        ),
                        Offstage(
                          offstage: item['likes'] == 0,
                          child: Text(
                            item['likes'].toString(),
                            style: const TextStyle(
                              color: Color(0xff0071fb),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 40.w,
                    height: 20.h,
                    child: IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () {
                        openComment(parent: item['id']);
                      },
                      icon: IconFont(
                        IconNames.xiaoxi_1,
                        color: '#7d828f',
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              Offstage(
                offstage: item['reply'].isEmpty,
                child: InkWell(
                  onTap: () {
                    Get.toNamed("/comment", arguments: item['id']);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 48.w, top: 8.h),
                    padding: const EdgeInsets.all(6),
                    color: Colors.blue.shade100.withOpacity(.3),
                    child: Column(
                      children: childComment(item['reply']),
                    ),
                  ),
                ),
              )
            ],
          ));
    }).toList();
  }

  /// 二级评论
  List<Widget> childComment(List list) {
    List newList = list;
    bool more = false;
    int length = list.length;
    if (list.length > 3) {
      newList = list.sublist(0, 3);
      more = true;
    }

    final listWidget = newList.map((child) {
      return Container(
        width: 1.sw,
        margin: EdgeInsets.symmetric(vertical: 4.h),
        child: Text.rich(
          TextSpan(
              text: child['author']['name'],
              style: const TextStyle(
                color: Colors.blue,
              ),
              children: [
                const TextSpan(
                  text: '  回复 ',
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                ),
                TextSpan(
                  text: child['reply_to'],
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                ),
                const TextSpan(
                  text: '：',
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                ),
                TextSpan(
                  text: child['content'],
                  style: const TextStyle(
                    color: Colors.black87,
                  ),
                ),
              ]),
        ),
      );
    }).toList();

    if (more) {
      listWidget.add(Container(
        alignment: Alignment.centerLeft,
        child: Text(
          '全部 $length条评论',
          style: const TextStyle(
            color: Colors.blue,
          ),
        ),
      ));
    }

    return listWidget;
  }

  /// 评论
  void openComment({parent}) {
    Get.bottomSheet(Reply(
      parent: parent,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: articleModel.commentKey,
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '全部评论',
            style: TextStyle(
              fontSize: 17.sm,
              fontWeight: FontWeight.w500,
            ),
          ),
          Obx(
            () => Column(
              children: commentList(),
            ),
          )
        ],
      ),
    );
  }
}
