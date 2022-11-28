import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_blog/model/ArticleModel/ArticleModel.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class TagArticle extends StatelessWidget {
  TagArticle({Key? key}) : super(key: key);
  ArticleModel articleModel = Get.find();

  void _click(id) {
    Get.offNamed("/detailds?id=$id");
  }

  /// 相关文章列表
  List<Widget> listArticle() {
    return List.generate(articleModel.tagArticle.length, (index) {
      return InkWell(
        onTap: () {
          _click(articleModel.tagArticle[index]['id']);
        },
        child: Container(
          margin: EdgeInsets.only(top: 10.h),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade100, width: 1),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Column(
            children: [
              HtmlWidget(
                articleModel.tagArticle[index]['excerpt'],
                textStyle: TextStyle(
                  fontSize: 16.sm,
                ),
                customStylesBuilder: (element) {
                  return {
                    'text-overflow': 'ellipsis',
                    'overflow': 'overflow',
                    'white-space': 'nowrap',
                  };
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Row(
                  children: [
                    Text(
                      '${articleModel.tagArticle[index]['custom_fields']['puock_like']?[0] ?? 0} 点赞',
                      style: TextStyle(
                        fontSize: 14.sm,
                        color: const Color(0xff828c9b),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Text(
                        '${articleModel.tagArticle[index]['comment_count']} 评论',
                        style: TextStyle(
                          fontSize: 14.sm,
                          color: const Color(0xff828c9b),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Text(
                        '${articleModel.tagArticle[index]['author']['nickname']}',
                        style: TextStyle(
                          fontSize: 14.sm,
                          color: const Color(0xff828c9b),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 1.sw,
          margin: EdgeInsets.only(top: 40.h),
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 20.h,
          ),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.blue.shade100.withOpacity(0.2),
                width: 6.h,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '相关文章',
                style: TextStyle(
                  fontSize: 17.sm,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Obx(
                () => Column(
                  children: listArticle(),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
