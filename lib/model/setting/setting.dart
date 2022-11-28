import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blog/model/userModel/userModel.dart';
import 'package:flutter_blog/util/storage.dart';
import 'package:flutter_blog/util/toast/toast.dart';
import 'package:get/get.dart';
import 'package:flutter_blog/api/user/user.dart';

class SettingModel extends GetxController {
  /// 用户信息
  final user = {
    'ID': null,
    'user_nicename': '',
    'phone': '',
    'user_email': '',
  }.obs;

  /// 更新用户信息
  void getCodes() {
    String regexPhoneNumber =
        "^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$";

    if (!RegExp(regexPhoneNumber).hasMatch(user['phone'] as String)) {
      toast('请输入正确的手机号', icon: 'error');
      return;
    }

    getCode(user['phone']).then((res) {
      codeTime();
      toast('验证码已发送', icon: 'success');
    }).catchError((err) {
      print(err);
      toast('验证码发送失败');
    });
  }

  final timeIndex = 60.obs;

  /// 验证码倒计时
  void codeTime() {
    Timer.periodic(const Duration(seconds: 1), (time) {
      if (timeIndex <= 0) {
        time.cancel();
        timeIndex.value = 60;
        return;
      }

      timeIndex.value -= 1;
    });
  }

  String code = '';
  bool isCode = false;

  /// 验证码 chang
  void codeChange(value) {
    code = value;

    if (code.length == 4) {
      checkCode({'phone': user['phone'], 'code': code}).then((res) {
        if (res.data['code'] != 200) {
          toast('验证码错误');
          isCode = false;
          return;
        }
        isCode = true;
      });
    }
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// 提交
  void submit() async {
    try {
      if (user['phone'] != '' && !isCode) {
        toast('验证码错误');
        return;
      }

      formKey.currentState?.save();

      print(user);

      showLoading();
      final result = await updateUser(user);
      hideLoading();

      print(result.data['data']);

      UserModel userModel = Get.find();
      userModel.user.value = result.data['data'];

      toast('更新成功', icon: 'success');
    } catch (e) {
      toast('更新用户信息错误');
    }
  }

  @override
  void onInit() {
    super.onInit();

    user['ID'] = Get.arguments.value['ID'];
    user['user_nicename'] = Get.arguments.value['user_nicename'];
    user['user_email'] = Get.arguments.value['user_email'] ?? '';
  }
}
