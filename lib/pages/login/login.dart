import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/api/user/user.dart';
import 'package:flutter_blog/util/storage.dart';
import 'package:flutter_blog/util/toast/toast.dart';
import 'package:get/get.dart';
import 'package:flutter_blog/iconfont/icon_font.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int formType = 1;

  RegExp reg = RegExp(r'^\d{11}$');

  final _formKey = GlobalKey<FormState>();

  final _registProtocolRecognizer = TapGestureRecognizer();

  /// 提交
  void submit() {
    if (_formKey.currentState!.validate()) {
      print(_formKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 1.sh,
          color: Colors.white,
          padding: EdgeInsets.only(
            top: ScreenUtil().statusBarHeight + 60.h,
            left: 20.w,
            right: 20.w,
          ),
          child: Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '欢迎使用 阿森 Blog',
                    style: TextStyle(
                      fontSize: 24.sm,
                      height: 2.h,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    '珍惜每一次相遇',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 40.h,
                      bottom: 20.h,
                    ),
                    child: PhoneLogin(),
                  ),
                ],
              ),
              Positioned(
                  bottom: 40.h,
                  left: 20.w,
                  right: 20.w,
                  child: Column(
                    children: [
                      Container(
                        width: 60.r,
                        height: 60.r,
                        margin: EdgeInsets.only(bottom: 10.h),
                        child: IconButton(
                          onPressed: () {},
                          icon: IconFont(
                            IconNames.weixindenglu,
                            size: 100,
                          ),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                            text: '注册即代表您同意',
                            style: const TextStyle(
                              color: Colors.black87,
                            ),
                            children: [
                              TextSpan(
                                text: '《用户协议》',
                                style: const TextStyle(
                                  color: Colors.blue,
                                ),
                                recognizer: _registProtocolRecognizer
                                  ..onTap = () {
                                    print('用户协议点击');
                                  },
                              ),
                            ]),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _registProtocolRecognizer.dispose();
    super.dispose();
  }
}

/// 手机号登录
class PhoneLogin extends StatefulWidget {
  PhoneLogin({Key? key}) : super(key: key);

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  RegExp reg = RegExp(r'^\d{11}$');

  String phone = '';
  bool loading = false;

  /// 提交
  void submit() {
    if (phone.isEmpty || phone.length < 11) {
      toast('请输入正确的手机号');
      return;
    }
    loading = true;
    setState(() {});

    getCode(phone).then((value) {
      loading = false;
      setState(() {});
      Get.toNamed('/code?phone=$phone');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          maxLength: 11,
          maxLines: 1,
          onChanged: (value) {
            phone = value;
          },
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            counterText: '',
            labelText: '请输入您的手机号',
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: .1,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue,
                width: .5,
              ),
            ),
          ),
        ),
        Container(
          width: 1.sw,
          margin: EdgeInsets.only(top: 20.h),
          child: ElevatedButton(
            onPressed: () {
              if (!loading) {
                submit();
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Offstage(
                  offstage: !loading,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: const CupertinoActivityIndicator(
                      radius: 10.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(loading ? '获取中···' : '获取验证码')
              ],
            ),
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(vertical: 12.h),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(
                const Color(0xff0074fa),
              ),
              shadowColor: MaterialStateProperty.all(
                const Color(0xff0074fa),
              ),
              elevation: MaterialStateProperty.all(4),
            ),
          ),
        ),
      ],
    );
  }
}
