import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

// 加载
void showLoading({String? status = 'loading...'}) {
  EasyLoading.instance
    ..radius = 10.0
    ..userInteractions = false;
  EasyLoading.show(status: status);
}

/// 关闭加载
void hideLoading() {
  EasyLoading.dismiss();
}

/// none 不带图标 error 错误提示 success 成功提示  info 警告
void toast(String text, {String icon = 'none'}) {
  EasyLoading.instance.radius = 10.0;

  switch (icon) {
    case 'error':
      EasyLoading.showError(text);
      break;
    case 'info':
      EasyLoading.showInfo(text);
      break;
    case 'sucess':
      EasyLoading.showSuccess(text);
      break;
    default:
      EasyLoading.showToast(text);
  }
}


/**
 * 
 *  Container( 
              width: 1.sw,
              height: 100,
              color: Colors.white,
              padding: EdgeInsets.only(
                top: ScreenUtil().statusBarHeight,
                left: 10.w,
                right: 10.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xfff1f4f5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search_rounded,
                            color: Color(0xff8f98a1),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: const Text(
                              '搜索博客',
                              style: TextStyle(
                                color: Color(0xff8f98a1),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () {},
                      icon: const Icon(Icons.no_sim),
                    ),
                  )
                ],
              ),
            ),
 * 
*/