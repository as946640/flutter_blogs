import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_blog/model/ArticleModel/ArticleModel.dart';

class DetailHeader extends StatelessWidget {
  DetailHeader({Key? key}) : super(key: key);

  ArticleModel articleModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Obx(
        () => Container(
          width: double.maxFinite,
          height: 100.h,
          padding: EdgeInsets.symmetric(
            vertical: 14.h,
            horizontal: 16.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                articleModel.detail['title'] ?? '',
                style: TextStyle(
                  fontSize: 20.sm,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.h),
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.network(
                        'https://profile-avatar.csdnimg.cn/ba5de8384098446db7bec7023bd8acb3_weixin_45192421.jpg!0',
                        width: 34.r,
                        height: 34.r,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            articleModel.detail['author']!['nickname'] ?? '',
                            style: TextStyle(
                              fontSize: 14.sm,
                              color: const Color(0xff333333),
                            ),
                          ),
                          Text(
                            '${articleModel.detail['date']} · 阅读 ${articleModel.detail["custom_fields"]['views'][0]}',
                            style: TextStyle(
                              fontSize: 12.sm,
                              color: Colors.grey,
                              fontWeight: FontWeight.w300,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
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
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
