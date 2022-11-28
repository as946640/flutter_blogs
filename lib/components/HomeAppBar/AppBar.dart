import 'package:flutter/material.dart';
import 'package:flutter_blog/iconfont/icon_font.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBars extends StatelessWidget {
  const AppBars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              padding: EdgeInsets.only(left: 10.w),
              decoration: BoxDecoration(
                color: const Color(0xfff1f4f5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  IconFont(
                    IconNames.sousuo,
                    size: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: const Text(
                      '搜索博客',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 40,
            height: 40,
            child: IconButton(
              onPressed: () {},
              icon: IconFont(
                IconNames.daka_1,
                size: 40,
              ),
            ),
          )
        ],
      ),
    );
  }
}
