import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_blog/iconfont/icon_font.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class ListItem extends StatelessWidget {
  final data;
  const ListItem({Key? key, required this.data}) : super(key: key);

  _buildText() {
    if (data['custom_fields']?['puock_like'] != null) {
      return Text(
        data['custom_fields']?['puock_like'].length > 0
            ? data['custom_fields']['puock_like'][0].toString()
            : '0',
        style: TextStyle(
          color: Colors.grey.shade500,
        ),
      );
    } else {
      return Text(
        '0',
        style: TextStyle(
          color: Colors.grey.shade500,
        ),
      );
    }
  }

  Widget _buildButton() {
    return Row(
      children: [
        SizedBox(
          width: 60.w,
          child: Row(
            children: [
              IconFont(
                IconNames.xihuancon,
                size: 24,
              ),
              Padding(padding: EdgeInsets.only(left: 10.w), child: _buildText())
            ],
          ),
        ),
        SizedBox(
          width: 100.w,
          child: Row(
            children: [
              IconFont(
                IconNames.xinxi,
                size: 24,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Text(
                  data['comment_count'].toString(),
                  style: TextStyle(
                    color: Colors.grey.shade500,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTitile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipOval(
          child: Image.network(
            'https://profile-avatar.csdnimg.cn/ba5de8384098446db7bec7023bd8acb3_weixin_45192421.jpg!0',
            width: 44.r,
            height: 44.r,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Text(
              data['title'],
              maxLines: 1,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        SizedBox(
          child: Text(
            data['modified'],
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        )
      ],
    );
  }

  getImgUrl() {
    String img = '';

    if (data['thumbnail_images'] != null &&
        data['thumbnail_images']['full'] != null) {
      img = data['thumbnail_images']['full']['url'];
    } else if (data['custom_fields']['cover'] != null &&
        data['custom_fields']['cover'].length > 0) {
      img = data['custom_fields']['cover'][0];
    }
    if (img == '') {
      return const SizedBox();
    } else {
      return Padding(
        padding: EdgeInsets.only(top: 6.h),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(img),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed("/detailds?id=${data['id']}");
      },
      child: Container(
        margin: EdgeInsets.only(top: 10.h),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          children: [
            _buildTitile(),
            Container(
              margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HtmlWidget(
                    data['excerpt'],
                    textStyle: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                    customStylesBuilder: ((element) {
                      return {
                        'overflow': 'hidden',
                        'text-overflow': 'ellipsis',
                        'display': ' -webkit-box',
                        '-webkit-line-clamp': '2',
                        'line-clamp': '2',
                        '-webkit-box-orient': 'vertical',
                      };
                    }),
                  ),
                  getImgUrl(),
                ],
              ),
            ),
            _buildButton()
          ],
        ),
      ),
    );
  }
}
