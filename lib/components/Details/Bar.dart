import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_blog/model/ArticleModel/ArticleModel.dart';

class DetailBar extends StatelessWidget {
  DetailBar({Key? key}) : super(key: key);

  ArticleModel articleModel = Get.find();

  /// 关注 widget
  Widget follow() {
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: () {},
          child: Container(
            width: 60.w,
            height: 26.h,
            decoration: BoxDecoration(
              color: Colors.blue.shade100.withOpacity(0.5),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  size: 18,
                  color: Colors.blue.shade500,
                ),
                Text(
                  '关注',
                  style: TextStyle(
                    fontSize: 14.sm,
                    color: Colors.blue,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2.0,
      centerTitle: true,
      title: Obx(
        () => AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: articleModel.isBarUser == true ? 1 : 0,
          child: Row(
            children: [
              ClipOval(
                child: Image.network(
                  'https://profile-avatar.csdnimg.cn/ba5de8384098446db7bec7023bd8acb3_weixin_45192421.jpg!0',
                  width: 30.r,
                  height: 30.r,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Text(
                  articleModel.detail.isEmpty
                      ? ''
                      : articleModel.detail['author']!['nickname'] ?? '',
                  style: TextStyle(
                    fontSize: 16.sm,
                    color: Colors.black54,
                  ),
                ),
              ),
              follow(),
            ],
          ),
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.black45,
        ),
      ),
    );
  }
}
