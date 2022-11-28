import 'package:flutter/material.dart';
import 'package:flutter_blog/components/Details/Reply.dart';
import 'package:flutter_blog/iconfont/icon_font.dart';
import 'package:get/get.dart';
import 'package:flutter_blog/model/ArticleModel/ArticleModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentPage extends StatelessWidget {
  CommentPage({Key? key}) : super(key: key);

  ArticleModel articleModel = Get.find();

  Map commentList = {};

  final comId = Get.arguments;

  /// 评论
  void openComment({parent}) {
    Get.bottomSheet(Reply(
      parent: commentList['id'],
    ));
  }

  findList() {
    articleModel.comments.forEach((element) {
      if (element['id'] == comId) {
        commentList = element;
      }
    });
  }

  // 评论列表
  Widget _item(item) {
    if (item['islike'] == null) item['islike'] = false;

    if (item['likes'] == null) item['likes'] = 0;

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
                            color:
                                item['islike'] == false ? '#7d828f' : '#0071fb',
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
          ],
        ));
  }

  Widget _header() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: Image.network(
              commentList['author']['avatar'],
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
                    commentList['author']['name'],
                    style: TextStyle(
                      color: Colors.blue.shade600,
                    ),
                  ),
                  Text(
                    commentList['date'],
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.sm,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 6.h),
                    child: Text(
                      commentList['content'],
                      style: TextStyle(
                        fontSize: 15.sm,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  int getLength() {
    int length = 0;
    articleModel.comments.forEach((element) {
      if (element['id'] == comId) {
        length = element['reply'].length;
      }
    });

    return length;
  }

  @override
  Widget build(BuildContext context) {
    findList();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black54,
          ),
        ),
        title: const Text(
          '评论',
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          _header(),
          Container(
            padding: EdgeInsets.only(left: 14.w, top: 10.h),
            child: Row(
              children: [
                Text(
                  '${commentList['reply'].length} 回复',
                  style: TextStyle(
                    fontSize: 16.sm,
                    color: Colors.grey.shade400,
                  ),
                ),
                Container(
                  width: 1.w,
                  height: 14.h,
                  margin: EdgeInsets.symmetric(horizontal: 6.w),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                  ),
                ),
                Text(
                  '${commentList['likes']} 赞',
                  style: TextStyle(
                    fontSize: 16.sm,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
              width: 1,
              color: Colors.grey.shade300,
            ))),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 20.h),
                itemCount: getLength(),
                itemBuilder: (BuildContext context, int index) {
                  return _item(commentList['reply'][index]);
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 10.0,
        child: InkWell(
          onTap: () {
            openComment();
          },
          child: Container(
            child: Text(
              '回复 ${commentList['author']['name']}',
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 8.h),
            padding: EdgeInsets.symmetric(
              vertical: 8.h,
              horizontal: 20.w,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
