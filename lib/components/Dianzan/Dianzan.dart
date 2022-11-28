import 'package:flutter/material.dart';
import 'package:flutter_blog/util/toast/toast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_blog/model/ArticleModel/ArticleModel.dart';

class Dianzan extends StatefulWidget {
  bool agree = false;
  Dianzan({Key? key, this.agree = false}) : super(key: key);

  @override
  State<Dianzan> createState() => _DianzanState();
}

class _DianzanState extends State<Dianzan> with TickerProviderStateMixin {
  late final AnimationController _controller;

  ArticleModel articleModel = Get.find();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  /// 文章点赞
  void _like() async {
    try {
      showLoading();
      final result = await articleModel.like();
      int status = result.data['status'];
      if (status == 200) {
        _controller.forward();
      } else {
        _controller.reset();
      }
      toast(result.data['message']);
      hideLoading();
    } on DioError catch (e) {
      var message = e.response!.data['message'] ?? '哎呀 点赞失败';
      hideLoading();
      toast(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _like(),
      child: Stack(
        children: [
          Lottie.asset(
            'assets/lottie/dianzan.json',
            controller: _controller,
            onLoaded: (composition) {
              _controller.duration = composition.duration;

              /// 是否已点赞 当前接口 缺少字段
              if (widget.agree) {
                _controller.animateTo(
                  200,
                  duration: const Duration(milliseconds: 0),
                );
              }
            },
          ),
          Positioned(
            right: 6.w,
            top: 8.h,
            child: Text(
              articleModel.detail["custom_fields"]?['puock_like']?[0] ?? '0',
              style: TextStyle(
                color: const Color(0xff0081f6),
                fontSize: 10.sm,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
