import 'dart:async';
import 'package:flutter_blog/util/toast/toast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/api/user/user.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_blog/util/storage.dart';

class verificationCode extends StatefulWidget {
  verificationCode({Key? key}) : super(key: key);

  @override
  State<verificationCode> createState() => _verificationCodeState();
}

class _verificationCodeState extends State<verificationCode> {
  /// 验证码
  String code = '';

  /// 秒数
  int second = 60;

  /// 定时器
  var _timer;

  late String phone;

  final defaultPinTheme = PinTheme(
    width: 60,
    height: 64,
    textStyle: const TextStyle(fontSize: 20, color: Colors.black54),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 225, 228, 231),
      borderRadius: BorderRadius.circular(24),
      boxShadow: const [
        BoxShadow(
          color: Color(0xffffffff),
          offset: Offset(-20.0, -20.0),
          blurRadius: 30,
          spreadRadius: 0.0,
        ),
      ],
    ),
  );

  /// 登录
  void submit() async {
    try {
      showLoading();

      final result = await checkCode({'phone': phone, 'code': code});

      if (result.data['code'] == 200) {
        final loginResult = await login(phone);

        if (loginResult.data['code'] != 200) {
          toast(loginResult.data['message']);
          return;
        }

        storeSetItem('user_info', loginResult.data['data']);
        storeSetItem('user_token', loginResult.data['data']['token']);

        hideLoading();

        Get.offAllNamed('/');
      } else {
        toast('验证码错误');
      }
    } catch (e) {
      hideLoading();

      print(e);
    }
  }

  /// 获取验证码
  void _getCode() {
    getCode(phone).then((value) {});
  }

  /// 倒计时
  void countDown() {
    _timer?.cancel();
    const timeout = Duration(seconds: 1);
    _timer = Timer.periodic(timeout, (timer) {
      if (second == 0) {
        print('清除');
        timer.cancel();
        return;
      }

      second -= 1;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    countDown();
    phone = Get.parameters['phone'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 1.sh,
        width: 1.sw,
        color: const Color(0xffecf0f3),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 100.h),
              child: Text(
                '请输入您的验证码',
                style: TextStyle(
                  fontSize: 30.sm,
                  color: Colors.black54,
                  height: 2,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              '验证码发送成功',
              style: TextStyle(
                fontSize: 14.sm,
                color: Colors.black54,
                // fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40.h),
              alignment: Alignment.center,
              child: Pinput(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                defaultPinTheme: defaultPinTheme,
                onCompleted: (pin) {
                  code = pin;
                  submit();
                },
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: BoxDecoration(
                    color: const Color(0xffecf0f3),
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xffecf0f3),
                        Color(0xffecf0f3),
                      ],
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffffffff),
                        offset: Offset(-20.0, -20.0),
                        blurRadius: 30,
                        spreadRadius: 0.0,
                      ),
                      BoxShadow(
                        color: Color(0xffced2d5),
                        offset: Offset(20.0, 20.0),
                        blurRadius: 30,
                        spreadRadius: 0.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 1.sw,
              margin: EdgeInsets.only(top: 40.h),
              child: ElevatedButton(
                onPressed: () {
                  if (second == 0) {
                    submit();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Offstage(
                      offstage: second == 0,
                      child: Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Text(
                          second.toString(),
                          style: const TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      '重新获取验证码',
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    )
                  ],
                ),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 10.h),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    const Color(0xffecf0f3),
                  ),
                  shadowColor: MaterialStateProperty.all(
                    const Color(0xffecf0f3),
                  ),
                  elevation: MaterialStateProperty.all(4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
